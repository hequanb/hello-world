package cn.hqb.pets.service.itemCat;

import java.util.List;

import cn.hqb.pets.pojo.itemCat.TItemCat;

public interface ItemCatService {

	List<TItemCat> selectLeafCat();
	
	List<TItemCat> getCatByParentId(Long parentId);
	
	int editItemCatById(TItemCat tItemCat);
	
	int insertItemCatByParentId(TItemCat tItemCat);
	
	TItemCat getItemCatById(Long id);
	
	int deleteItemCat(TItemCat tItemCat);
	
	List<TItemCat> getFirstCat();
	
}
