package cn.hqb.pets.dao.mapper.order;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.hqb.pets.po.TItemPo;
import cn.hqb.pets.pojo.order.TOrder;
import cn.hqb.pets.pojo.shopcart.TShopcart;
import cn.hqb.pets.vo.item.TItemVo;
import cn.hqb.pets.vo.order.TAdminOrderVo;
import cn.hqb.pets.vo.order.TOrderVo;
import cn.hqb.pets.vo.shopcart.TShopcartVo;

public interface TOrderMapper {
	
	Long insertOrder(TOrder order);
	
	Long selectOrderIdById(@Param("id") Long id);
	
	TOrder getOrderByOrderId(@Param("orderId") Long orderId);
	
	TOrderVo getOrderDetailByOrderId(@Param("orderId") Long orderId);
	
	Long getOrderItemCountByOrderId(@Param("orderId") Long orderId);
	
	List<TOrder> getMyOrder(@Param("userId") Long userId);	
	
	TOrder getOrderIsPaying(@Param("orderId") Long orderId);
	
	Integer updatePaid(TOrder order);
	
	Integer getCount(TAdminOrderVo TAdminOrderVo);
	
	List<TAdminOrderVo> getAllOrder(TAdminOrderVo TAdminOrderVo);
	
	Integer updateConsign(TOrder order);
	
	Integer updateEnd(TOrder order);
	
	Integer updateAccept(TOrder order);

}
