package cn.hqb.pets.service.impl.order;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import cn.hqb.pets.comm.LayuiTableData;
import cn.hqb.pets.comm.Result;
import cn.hqb.pets.comm.Utils;
import cn.hqb.pets.dao.mapper.item.TItemMapper;
import cn.hqb.pets.dao.mapper.order.TOrderExpressMapper;
import cn.hqb.pets.dao.mapper.order.TOrderItemMapper;
import cn.hqb.pets.dao.mapper.order.TOrderMapper;
import cn.hqb.pets.dao.mapper.shopcart.TShopcartItemMapper;
import cn.hqb.pets.dao.mapper.shopcart.TShopcartMapper;
import cn.hqb.pets.model.order.OrderModel;
import cn.hqb.pets.po.TItemPo;
import cn.hqb.pets.pojo.item.TItem;
import cn.hqb.pets.pojo.order.TOrder;
import cn.hqb.pets.pojo.order.TOrderExpress;
import cn.hqb.pets.pojo.order.TOrderItem;
import cn.hqb.pets.pojo.shopcart.TShopcartItem;
import cn.hqb.pets.service.order.OrderService;
import cn.hqb.pets.vo.item.TItemVo;
import cn.hqb.pets.vo.order.TAdminOrderVo;
import cn.hqb.pets.vo.order.TOrderVo;

@Transactional
@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired
	private TShopcartMapper shopcartMapper;
	
	@Autowired
	private TOrderMapper orderMapper;
	
	@Autowired
	private TOrderItemMapper orderItemMapper;
	
	@Autowired
	private TItemMapper itemMapper;
	
	@Autowired
	private TOrderExpressMapper orderExpressMapper;
	
	@Autowired
	private TShopcartItemMapper shopcartItemMapper;
	
	/**
	 * @throws Exception 
	 * @throws Exception 
	 * @throws Exception   
	* @Title: addOrder  
	* @Description: 订单条目数据从数据库取,原因是有可能重复提交表单,所以每次提交完后JAVA会清除购物车,
	* 以免造成重复提交
	* 
	* 先判断是否还有剩余库存,若有,则先插入订单,若成功,插入订单条目;若订单条目也全部插入成功,插入邮递信息,
	* 若插入邮递信息成功则清空购物车条目,若清空购物车条目成功,则返回订单插入成功;
	* @param @return    
	* @return String 
	* @throws  
	*/ 
	@Transactional(rollbackFor=Exception.class)
	public Result createOrder(OrderModel orderModel){
		Result result = new Result();
		TOrder order = new TOrder();
		Long userId = orderModel.getUserId();
		
		List<TShopcartItem> itemList = shopcartMapper.getShopcartByUserId(userId).getItemList();
		if( null == itemList || itemList.isEmpty()){
			result.setCode("100");
			result.setMsg("购物车没有商品!");
			return result;
		}
		int length = itemList.size();
		//计算总价
		Double payment = (double) 0;
		//初始化订单条目
		List<TOrderItem> orderItemList = new ArrayList<TOrderItem>();
		//初始化商品条目,用于修改库存
		List<TItem> originItemList = new ArrayList<TItem>();
		//记录购物车条目ID,准备用于删除购物车条目
		StringBuffer ids = new StringBuffer();
		for (TShopcartItem shopcartItem : itemList) {
			//修改商品的剩余数量
			TItem originItem = shopcartItem.getItem();
			if(Utils.isEmpty(originItem)){
				result.setCode("100");
				result.setMsg("["+shopcartItem.getItemId()+"]出现错误");
				return result;
			}
			//计算库存是否足够
			if(originItem.getNum() < shopcartItem.getCount()){
				result.setCode("100");
				result.setMsg("["+shopcartItem.getItemId()+"] 库存不够,请重新购买!");
				return result;
			}
			originItem.setNum(originItem.getNum() - Integer.parseInt(shopcartItem.getCount().toString()));
			originItem.setId(shopcartItem.getItemId());
			TOrderItem item = new TOrderItem();
			item.setItemId(shopcartItem.getItemId());
			item.setPrice(shopcartItem.getItem().getPrice());
			item.setCount(shopcartItem.getCount());
			item.setTitle(shopcartItem.getItem().getTitle());
			item.setImage(shopcartItem.getItem().getImage());
			item.setSubTotal(Utils.mul(shopcartItem.getCount(), shopcartItem.getItem().getPrice()));
			orderItemList.add(item);
			originItemList.add(originItem);
			payment = Utils.add(payment, item.getSubTotal());
			ids.append(shopcartItem.getId()).append(",");
		}
		ids.toString().substring(0, ids.length() - 1);
		//修改库存
		int i = itemMapper.updateItemNumBatch(originItemList);
		order.setPayment(payment.toString());
		order.setPaymentType(orderModel.getPaymentType());
		order.setStatus(1);
		order.setUserId(orderModel.getUserId());
		order.setBuyerMessage(orderModel.getBuyerMessage());
		order.setBuyerNick(orderModel.getBuyerNick());
		orderMapper.insertOrder(order);
		Long id = order.getId();
		Long orderId = orderMapper.selectOrderIdById(id);
		if(null == orderId || 0 == orderId){
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly(); 
			result.setCode("100");
			result.setMsg("订单创建失败");
			return result;
		}

		for (TOrderItem tOrderItem : orderItemList) {
			tOrderItem.setOrderId(orderId);
		}
		
		int itemNum = orderItemMapper.insertOrderItemBatch(orderItemList);
		if(itemNum != length){
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly(); 
			result.setCode("100");
			result.setMsg("订单条目创建失败");
			return result;
		}
		//插入邮递信息
		TOrderExpress express = new TOrderExpress();
		express.setOrderId(orderId);
		express.setReceiverName(orderModel.getReceiverName());
		express.setReceiverAddress(orderModel.getReceiverAddress());
		express.setReceiverPhone(orderModel.getReceiverPhone());
		express.setReceiverZip(orderModel.getReceiverZip());
		int expressNum = orderExpressMapper.insertOrderExpress(express);
		if(expressNum < 1){
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly(); 
			result.setCode("100");
			result.setMsg("邮递信息创建失败");
			return result;
		}
		List<Long> list = Utils.separateToList(ids.toString(), ",");
		int cartItemDel = shopcartItemMapper.deleteShopcartItemBatch(list);
		if(cartItemDel != length){
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly(); 
			result.setCode("100");
			result.setMsg("购物车条目删除失败");
			return result;
		}
		//TransactionAspectSupport.currentTransactionStatus().setRollbackOnly(); 
		if(1 == orderModel.getPaymentType()){
			result.setCode("0");
		}else{
			result.setCode("2");
		}
		result.setMsg("订单创建成功");
		result.setData(orderId.toString());
		System.out.println(orderId);
		return result;
	}

	public TOrder getOrderByOrderId(Long orderId){
		return orderMapper.getOrderByOrderId(orderId);
	}
	
	/**  
	* @Title: getOrderDetailByOrderId  
	* @Description: 根据活动ID获得订单详情
	* @param @param orderId
	* @param @return    
	* @return TOrderVo 
	* @throws  
	*/ 
	public TOrderVo getOrderDetailByOrderId(Long orderId){
		TOrderVo vo = orderMapper.getOrderDetailByOrderId(orderId);
		Long count = orderMapper.getOrderItemCountByOrderId(orderId);
		vo.setItemCount(count);
		return vo;
	}
	
	public List<TOrder> getMyOrder(Long userId){
		return orderMapper.getMyOrder(userId);
	}

	/**  
	* @Title: getOrderIsPaying  
	* @Description: 根据订单ID,查找订单是否是在线支付的未支付状态
	* @param @param orderId
	* @param @return    
	* @throws  
	*/ 
	public TOrder getOrderIsPaying(Long orderId) {
		return orderMapper.getOrderIsPaying(orderId);
	}

	@Transactional
	public Result pay(Long orderId, Integer platform) {
		Result result = new Result();
		TOrder order = new TOrder();
		result.setCode("100");
		result.setMsg("支付失败");
		order.setStatus(2);
		order.setOrderId(orderId.toString());
		int i = orderMapper.updatePaid(order);
		if(i > 0){
			result.setCode("0");
			result.setMsg("订单支付成功");
		}
		return result;
	}

	public LayuiTableData getOrderList(TAdminOrderVo tAdminOrderVo) {
		LayuiTableData tableData = new LayuiTableData();
		//可能不为列表查询,后续修改
		Integer count = orderMapper.getCount(tAdminOrderVo);
		tAdminOrderVo.setTotal(count);
		int firstResult = tAdminOrderVo.getFirstResult();
		tAdminOrderVo.setFirstResult(firstResult);
		List<TAdminOrderVo> list = orderMapper.getAllOrder(tAdminOrderVo);
		if(count > 0 && null != list){
			tableData.setCount(count);
			tableData.setData(list);
			tableData.setMsg("成功");
			tableData.setCode("0");
		}else{
			tableData.setMsg("暂无数据!");
			tableData.setCode("200");
			tableData.setCount(0);
			tableData.setData(null);
		}
		return tableData;
	}

	public Result consign(String orderId) {
		Result result = new Result();
		TOrder order = new TOrder();
		result.setCode("100");
		result.setMsg("发货失败");
		order.setOrderId(orderId);
		order.setStatus(4);
		int i = orderMapper.updateConsign(order);
		if(i > 0){
			result.setCode("0");
			result.setMsg("发货成功");
		}
		return result;
	}

	public Result end(String orderId) {
		Result result = new Result();
		TOrder order = new TOrder();
		result.setCode("100");
		result.setMsg("交易完成失败");
		order.setOrderId(orderId);
		order.setStatus(6);
		int i = orderMapper.updateEnd(order);
		if(i > 0){
			result.setCode("0");
			result.setMsg("交易完成成功");
		}
		return result;
	}

	public LayuiTableData getOrderDetailByIdAmin(String orderId) {
		LayuiTableData data = new LayuiTableData();
		List<TOrderItem> list = orderItemMapper.getOrderItemByOrderId(Long.parseLong(orderId));
		if(null != list && list.size() != 0){
			data.setData(list);
			data.setMsg("成功");
			data.setCode("0");
		}else{
			data.setMsg("请求失败!");
			data.setCode("200");
			data.setCount(0);
			data.setData(null);
		}
		return data;
	}

	public Result accept(String orderId) {
		Result result = new Result();
		result.setCode("100");
		result.setMsg("确认收货失败!");
		TOrder order = new TOrder();
		order.setStatus(5);
		order.setOrderId(orderId);
		int i = orderMapper.updateAccept(order);
		if(i > 0){
			result.setCode("0");
			result.setMsg("确认收货成功");
		}
		return result;
	}

}
