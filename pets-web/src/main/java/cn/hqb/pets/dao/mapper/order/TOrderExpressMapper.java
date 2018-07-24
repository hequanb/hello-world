package cn.hqb.pets.dao.mapper.order;

import org.apache.ibatis.annotations.Param;

import cn.hqb.pets.pojo.order.TOrder;
import cn.hqb.pets.pojo.order.TOrderExpress;
import cn.hqb.pets.pojo.shopcart.TShopcart;
import cn.hqb.pets.vo.shopcart.TShopcartVo;

public interface TOrderExpressMapper {
	
	int insertOrderExpress(TOrderExpress orderExpress);
		
}
