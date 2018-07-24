package cn.hqb.pets.controller.order.admin;

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
import cn.hqb.pets.vo.item.TItemVo;
import cn.hqb.pets.vo.order.TAdminOrderVo;
import cn.hqb.pets.vo.order.TOrderVo;

@Controller
@RequestMapping("/admin/order")
public class AdminOrderController extends BaseController {
	
	@Autowired
	private OrderService orderService;
		
	private static ObjectMapper mapper = new ObjectMapper();
	
	@RequestMapping(value = "toOrderManage", method = RequestMethod.GET)
	public String toOrderManage(HttpServletRequest request){
		return "admin/orderManage";
	}
	
	@RequestMapping(value = "/getOrderList")
	public void getOrderList(HttpServletResponse response, TAdminOrderVo vo) throws Exception{
		LayuiTableData ltb = orderService.getOrderList(vo);
		String json = mapper.writeValueAsString(ltb);
		super.printOutMsg(response, json);
	}
	
	/**
	 * @throws Exception   
	* @Title: consign  
	* @Description: 发货
	* @param @param request
	* @param @return    
	* @return String 
	* @throws  
	*/ 
	@RequestMapping(value = "/consign", method = RequestMethod.POST)
	public void consign(HttpServletRequest request, HttpServletResponse response, String orderId) throws Exception{
		Result result = orderService.consign(orderId);
		String json = mapper.writeValueAsString(result);
		super.printOutMsg(response, json);
	}
	
	/**
	 * @throws Exception   
	* @Title: end  
	* @Description: 完成交易
	* @param @param request
	* @param @return    
	* @return String 
	* @throws  
	*/ 
	@RequestMapping(value = "/end", method = RequestMethod.POST)
	public void end(HttpServletRequest request, HttpServletResponse response, String orderId) throws Exception{
		Result result = orderService.end(orderId);
		String json = mapper.writeValueAsString(result);
		super.printOutMsg(response, json);
	}
	
	/**
	 * @throws Exception   
	* @Title: toOrderDetail  
	* @Description: 订单详情
	* @param @param request
	* @param @return    
	* @return String 
	* @throws  
	*/ 
	@RequestMapping(value = "/toOrderDetail", method = RequestMethod.GET)
	public String toOrderDetail(HttpServletRequest request, Model model, String orderId) throws Exception{
		model.addAttribute("orderId", orderId);
		return "admin/orderDetail";
	}
	
	/**
	 * @throws Exception   
	* @Title: toOrderDetail  
	* @Description: 订单详情
	* @param @param request
	* @param @return    
	* @return String 
	* @throws  
	*/ 
	@RequestMapping(value = "/orderDetail", method = RequestMethod.GET)
	public void orderDetail(HttpServletRequest request, HttpServletResponse response, String orderId) throws Exception{
		LayuiTableData data = orderService.getOrderDetailByIdAmin(orderId);
		String json = mapper.writeValueAsString(data);
		super.printOutMsg(response, json);
	}
	
}
