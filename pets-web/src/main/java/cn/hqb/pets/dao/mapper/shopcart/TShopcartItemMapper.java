package cn.hqb.pets.dao.mapper.shopcart;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.hqb.pets.pojo.shopcart.TShopcart;
import cn.hqb.pets.pojo.shopcart.TShopcartItem;
import cn.hqb.pets.vo.shopcart.TShopcartVo;

public interface TShopcartItemMapper {
	
	int insertItem(TShopcartItem item);
	
	int updateShopcartItem(TShopcartItem item);
	
	int deleteShopcartItem(@Param("id") Long id);
	
	int deleteShopcartItemBatch(List list);
		
}
