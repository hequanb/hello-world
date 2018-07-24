package cn.hqb.pets.service.item;

import java.util.List;

import cn.hqb.pets.comm.LayuiTableData;
import cn.hqb.pets.comm.Page;
import cn.hqb.pets.po.TItemPo;
import cn.hqb.pets.pojo.item.TItem;
import cn.hqb.pets.vo.item.TItemVo;

public interface ItemService {
	
	int insertItem(TItem item);
	
	LayuiTableData getItemList(TItemVo tItemVo);
	
	List<TItem> getItemListNew();
	
	TItem getItemById(long id);
	
	int updateItem(TItem tItem);
	
	int deleteItem(long id);
	
	List<TItem> getNewestItems();
	
	TItem getItemDetailById(long id);
	
	List<TItemPo> getItemsByCatId(TItemVo vo);
	
}
