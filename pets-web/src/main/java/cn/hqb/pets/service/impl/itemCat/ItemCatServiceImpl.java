package cn.hqb.pets.service.impl.itemCat;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.hqb.pets.dao.mapper.itemCat.TItemCatMapper;
import cn.hqb.pets.pojo.itemCat.TItemCat;
import cn.hqb.pets.service.itemCat.ItemCatService;

@Transactional
@Service
public class ItemCatServiceImpl implements ItemCatService {

	@Autowired
	private TItemCatMapper itemCatMapper;
	
	public List<TItemCat> selectLeafCat() {
		List<TItemCat> list = itemCatMapper.selectLeafCat();
		return list;
	}

	public List<TItemCat> getCatByParentId(Long parentId) {
		List<TItemCat> list= itemCatMapper.getItemCatByParentId(parentId);
		return list;
	}

	public int editItemCatById(TItemCat tItemCat) {
		int result = itemCatMapper.updateItemCatById(tItemCat);
		return result;
	}

	public int insertItemCatByParentId(TItemCat tItemCat) {
		tItemCat.setStatus((byte)1);
		tItemCat.setIsParent(false);
		int result = itemCatMapper.insertItemCatByParentId(tItemCat);
		return result;
	}

	public TItemCat getItemCatById(Long id) {
		return itemCatMapper.getItemCatById(id);
	}

	/** 
     * 根据id删除记录,删除成功后,根据父ID查还有没有孩子
     * 有孩子isParent不变,没孩子isParent改为0
     */  
	public int deleteItemCat(TItemCat tItemCat) {
		int result1 = itemCatMapper.deleteById(tItemCat.getId());
		if(result1 > 0){
			//删除成功后,根据父ID查查还有没有孩子
			int leafCount = itemCatMapper.countLeafByParentId(tItemCat.getParentId());
			if(leafCount == 0){
				TItemCat ic = new TItemCat();
				ic.setId(tItemCat.getParentId());
				ic.setIsParent(false);
				int result2 = itemCatMapper.updateItemCatById(ic);
				if(result2 > 0){
					return 1;
				}
				return 0;
			}
			return 1;
		}
		return 0;
	}

	/**  
	* @Title: getFirstCat  
	* @Description: 获取一级目录,
	* @param @return    
	* @throws  
	*/ 
	public List<TItemCat> getFirstCat() {
		return itemCatMapper.getItemCatByParentId((long)1);
	}

}
