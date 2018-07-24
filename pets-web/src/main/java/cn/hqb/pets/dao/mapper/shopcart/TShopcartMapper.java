package cn.hqb.pets.dao.mapper.shopcart;

import cn.hqb.pets.pojo.shopcart.TShopcart;
import cn.hqb.pets.vo.shopcart.TShopcartVo;

public interface TShopcartMapper {
	
	Long insertShopcart(TShopcart shopcart);
	
	TShopcartVo getShopcartByUserId(Long id);
	
	Integer getCountByUserId(Long id);
	
}
