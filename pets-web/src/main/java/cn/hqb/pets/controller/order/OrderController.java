package cn.hqb.pets.controller.order;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import cn.hqb.pets.comm.LayuiTableData;
import cn.hqb.pets.comm.Result;
import cn.hqb.pets.controller.BaseController;
import cn.hqb.pets.model.order.OrderModel;
import cn.hqb.pets.pojo.order.TOrder;
import cn.hqb.pets.pojo.order.TOrderItem;
import cn.hqb.pets.pojo.user.TUser;
import cn.hqb.pets.service.order.OrderService;
import cn.hqb.pets.vo.order.TOrderVo;

@Controller
@RequestMapping("/order")
public class OrderController extends BaseController {
	
	@Autowired
	private OrderService orderService;
		
	private static ObjectMapper mapper = new ObjectMapper();
	
	@RequestMapping("/toOrder")
	public String toOrder(){
		return "order/order";
	}
	
	/**  
	* @Title: addOrder  
	* @Description: 订单条目数据从数据库取,原因是有可能重复提交表单,所以每次提交完后JAVA会清除购物车,
	* 以免造成重复提交
	* @param @return    
	* @return String 
	* @throws  
	*/ 
	@RequestMapping(value= "addOrder", method=RequestMethod.POST)
	@ResponseBody
	public Result addOrder(HttpServletRequest request, @RequestBody OrderModel model){
		Result result = new Result();
		TUser user = (TUser)request.getSession().getAttribute("user");
		if(null == user){
			result.setCode("100");
			result.setMsg("请先登录!");
			return result;
		}
		model.setUserId(user.getId());
		model.setBuyerNick(user.getNickName());
		result = orderService.createOrder(model);
		return result;
	}
	
	/**  
	* @Title: orderPay  
	* @Description: 返回在线支付页面
	* @param @param request
	* @param @param model
	* @param @param orderId
	* @param @return    
	* @return String 
	* @throws  
	*/ 
	@RequestMapping(value="orderPay", method=RequestMethod.GET)
	public String orderPay(HttpServletRequest request, Model model, String orderId){
		Result result = new Result();
		if(null == orderId || "".equals(orderId)){
			model.addAttribute("code",100);
			model.addAttribute("msg", "此订单状态不需要在线支付或者订单为空!");
			return "order/orderPay";
		}
		TOrder order = orderService.getOrderIsPaying(Long.parseLong(orderId));
		if(null == order){
			model.addAttribute("code",100);
			model.addAttribute("msg", "此订单状态不需要在线支付或者订单为空!");
		}else{
			model.addAttribute("code",0);
			model.addAttribute("order",order);
		}
		model.addAttribute("orderId", orderId);
		return "order/orderPay";
	}
	
	/**  
	* @Title: orderPay  
	* @Description: 返回货到付款页面
	* @param @param request
	* @param @param model
	* @param @param orderId
	* @param @return    
	* @return String 
	* @throws  
	*/ 
	@RequestMapping(value="orderPayInFace", method=RequestMethod.GET)
	public String orderPayInFace(HttpServletRequest request, Model model, String orderId){
		TOrder order = orderService.getOrderByOrderId(Long.parseLong(orderId));
		model.addAttribute("orderId", order.getOrderId());
		model.addAttribute("paymentType",order.getPaymentType());
		model.addAttribute("payment", order.getPayment());
		model.addAttribute("status", order.getStatus());
		return "order/orderPayInFace";
	}
	
	/**
	 * @throws Exception   
	* @Title: orderDetail  
	* @Description: 返回订单详情
	* @param @param request
	* @param @param model
	* @param @param orderId
	* @param @return    
	* @return String 
	* @throws  
	*/ 
	@RequestMapping(value="orderDetail", method=RequestMethod.GET)
	public String orderDetail(HttpServletRequest request, Model model, String orderId) throws Exception{
		LayuiTableData table = new LayuiTableData();
		TUser user = (TUser) request.getSession().getAttribute("user");
		if(null == user){
			table.setCode("300");
			table.setMsg("您还未登录,请先进行登录!");
			table.setData(new ArrayList());
			table.setCount(0);
		}else{
			TOrderVo vo = orderService.getOrderDetailByOrderId(Long.parseLong(orderId));
			List<TOrderItem> list = vo.getList();
			if(list.isEmpty()){
				table.setCode("200");
				table.setMsg("订单异常!");
				table.setData(new ArrayList());
				table.setCount(0);
			}else{
				model.addAttribute("order", vo);
				table.setCode("0");
				table.setCount(Integer.parseInt(vo.getItemCount().toString()));
				String json = mapper.writeValueAsString(list);
				table.setMsg(json);
				table.setData(list);
			}
		}
		model.addAttribute("data", table);
		return "order/orderDetail";
	}
	
	@RequestMapping(value="/myOrder", method=RequestMethod.GET)
	public String getMyOrder(HttpServletRequest request, HttpServletResponse response, Model model){
		TUser user = (TUser)request.getSession().getAttribute("user");
		List<TOrder> list = new ArrayList<TOrder>();
		if(null == user){
			model.addAttribute("order", list);
		}else{
			list = orderService.getMyOrder(user.getId());
			model.addAttribute("order", list);
		}
		return "order/myOrder";
	}
	
	/**
	 * @throws Exception   
	* @Title: orderPay  
	* @Description:付款页面,暂时只是改变状态
	* @param @param request
	* @param @param model
	* @param @param orderId
	* @param @return    
	* @return String 
	* @throws  
	*/ 
	@RequestMapping(value="pay", method=RequestMethod.POST)
	public void pay(HttpServletRequest request, HttpServletResponse response, String orderId,Integer platform) throws Exception{
		Result result = orderService.pay(Long.parseLong(orderId), platform);
		String json = mapper.writeValueAsString(result);
		super.printOutMsg(response, json);
	}
	
	/**
	 * @throws Exception   
	* @Title: orderAccept  
	* @Description: 确认收货
	* @param @param request
	* @param @param model
	* @param @param orderId
	* @param @return    
	* @return String 
	* @throws  
	*/ 
	@RequestMapping(value="orderAccept", method=RequestMethod.POST)
	public void orderAccept(HttpServletRequest request, HttpServletResponse response, String orderId) throws Exception{
		Result result = new Result();
		if(null == orderId || "".equals(orderId)){
			result.setCode("100");
			result.setMsg("订单号为空!");
		}else{
			result = orderService.accept(orderId);
		}
		String json = mapper.writeValueAsString(result);
		super.printOutMsg(response, json);
	}
	
}
