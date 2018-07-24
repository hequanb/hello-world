package cn.hqb.pets.dao.mapper.itemCat;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.hqb.pets.pojo.itemCat.TItemCat;

public interface TItemCatMapper {

	List<TItemCat> selectLeafCat();
	
	List<TItemCat> getItemCatByParentId(@Param("parentId") Long parentId);
	
	TItemCat getItemCatById(@Param("id")Long id);
	
	int updateItemCatById(TItemCat tItemCat);
	
	int deleteItemCatById(@Param("id")Long id);
	
	int insertItemCatByParentId(TItemCat tItemCat);
	
	int deleteById(@Param("id")Long id);
	
	Boolean isParent(@Param("id")Long id);
	
	int countLeafByParentId(@Param("parentId")Long parentId);
	
}
