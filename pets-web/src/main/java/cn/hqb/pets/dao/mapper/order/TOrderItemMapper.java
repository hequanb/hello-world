package cn.hqb.pets.dao.mapper.order;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.hqb.pets.pojo.order.TOrderItem;

public interface TOrderItemMapper {
	
	int insertOrderItemBatch(List<TOrderItem> list);
	
	List<TOrderItem> getOrderItemByOrderId(@Param("orderId")Long orderId);
	
}
