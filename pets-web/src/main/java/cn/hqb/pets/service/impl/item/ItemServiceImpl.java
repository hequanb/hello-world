package cn.hqb.pets.service.impl.item;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.hqb.pets.comm.LayuiTableData;
import cn.hqb.pets.comm.Page;
import cn.hqb.pets.dao.mapper.item.TItemMapper;
import cn.hqb.pets.po.TItemPo;
import cn.hqb.pets.pojo.item.TItem;
import cn.hqb.pets.service.item.ItemService;
import cn.hqb.pets.vo.item.TItemVo;

@Transactional
@Service
public class ItemServiceImpl implements ItemService {

	@Autowired
	private TItemMapper itemMapper;
	
	public int insertItem(TItem item) {
		//插入商品,首先补全信息:状态status
		item.setStatus((byte) 1);
		//模拟目录ID
		int result = itemMapper.insert(item);
		return result;
	}

	public LayuiTableData getItemList(TItemVo vo) {
		LayuiTableData tableData = new LayuiTableData();
		//可能不为列表查询,后续修改
		int count = itemMapper.getCount();
		vo.setTotal(count);
		int firstResult = vo.getFirstResult();
		vo.setFirstResult(firstResult);
		vo.setIsDel(0);
		List<TItemPo> list = itemMapper.getAllItem(vo);
		if(count > 0 && null != list){
			tableData.setCount(count);
			tableData.setData(list);
			tableData.setMsg("成功");
			tableData.setCode("0");
		}else{
			tableData.setMsg("请求失败!");
			tableData.setCode("200");
			tableData.setCount(0);
			tableData.setData(null);
		}
		return tableData;
	}
	
	public TItem getItemById(long id) {
		return itemMapper.getItemById(id);
	}
	
	public int updateItem(TItem tItem){
		return itemMapper.updateById(tItem);
	}

	public int deleteItem(long id) {
		TItem item = new TItem();
		item.setId(id);
		return itemMapper.deleteById(item);
	}

	/**  
	* @Title: getNewestItems  
	* @Description: 获取8个最新的商品
	* @param @return    
	* @return List<TItem> 
	* @throws  
	*/ 
	public List<TItem> getNewestItems(){
		return itemMapper.getNewestItemsByNum(8);
	}

	/**  
	* @Title: getItemDetailById  
	* @Description: 查看商品详情,
	* @param @param id
	* @param  
	* @throws  
	*/ 
	public TItem getItemDetailById(long id) {
		return itemMapper.getItemDetailById(id);
	}

	public List<TItem> getItemListNew() {
		return itemMapper.getItemListNew();
	}

	
	/**  
	* @Title: getItemsByCatId  
	* @Description: TODO
	* @param @param id
	* @param @return    
	* @throws  
	*/ 
	public List<TItemPo> getItemsByCatId(TItemVo vo) {
		return itemMapper.getItemsByCatId(vo);
	}
	
}
