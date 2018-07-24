package cn.hqb.pets.dao.mapper.item;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.hqb.pets.po.TItemPo;
import cn.hqb.pets.pojo.item.TItem;
import cn.hqb.pets.vo.item.TItemVo;

public interface TItemMapper {
	
	int insert(TItem item);
	
	List<TItemPo> getAllItem(TItemVo itemVo);
	
	int getCount();
	
	int getDelCount();
	
	TItem getItemById(Long id);
	
	int updateById(TItem tItem);
	
	int deleteById(TItem tItem);
	
	List<TItem> getNewestItemsByNum(@Param("num") int num);
	
	TItem getItemDetailById(Long id);
	
	int updateItemNumBatch(List<TItem> list);
	
	List<TItem> getItemListNew();
	
	List<TItemPo> getItemsByCatId(TItemVo itemVo);
	
}
