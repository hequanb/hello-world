package cn.hqb.pets.service.order;

import java.util.List;

import cn.hqb.pets.comm.LayuiTableData;
import cn.hqb.pets.comm.Result;
import cn.hqb.pets.model.order.OrderModel;
import cn.hqb.pets.pojo.order.TOrder;
import cn.hqb.pets.pojo.order.TOrderItem;
import cn.hqb.pets.vo.item.TItemVo;
import cn.hqb.pets.vo.order.TAdminOrderVo;
import cn.hqb.pets.vo.order.TOrderVo;

public interface OrderService {
	
	Result createOrder(OrderModel orderModel);
	
	TOrder getOrderByOrderId(Long orderId);
	
	TOrderVo getOrderDetailByOrderId(Long orderId);
	
	List<TOrder> getMyOrder(Long userId);
	
	TOrder getOrderIsPaying(Long orderId);
	
	Result pay(Long orderId, Integer platform);
	
	LayuiTableData getOrderList(TAdminOrderVo tAdminOrderVo);
	
	Result consign(String orderId);
	
	Result end(String orderId);
	
	LayuiTableData getOrderDetailByIdAmin(String orderId);
	
	Result accept(String orderId);
	
}
