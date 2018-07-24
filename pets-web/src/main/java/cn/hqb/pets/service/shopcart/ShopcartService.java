package cn.hqb.pets.service.shopcart;

import java.util.List;

import cn.hqb.pets.comm.LayuiTableData;
import cn.hqb.pets.comm.Page;
import cn.hqb.pets.po.TItemPo;
import cn.hqb.pets.pojo.item.TItem;
import cn.hqb.pets.pojo.shopcart.TShopcart;
import cn.hqb.pets.pojo.shopcart.TShopcartItem;
import cn.hqb.pets.vo.item.TItemVo;
import cn.hqb.pets.vo.shopcart.TShopcartVo;

public interface ShopcartService {
	
	Long insertShopcart(TShopcart shopcart);
	
	TShopcartVo getShopcartByUserId(Long id);
	
	int insertItem(TShopcartItem item);
	
	int updateShopcartItem(TShopcartItem item);
	
	int getCountByUserId(Long id);
	
	int deleteShopcartItem(Long id);
	
	int deleteShopcartItemBatch(String ids);
	
}
