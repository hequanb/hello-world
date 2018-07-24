package cn.hqb.pets.service.impl.shopcart;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.hqb.pets.comm.Utils;
import cn.hqb.pets.dao.mapper.shopcart.TShopcartItemMapper;
import cn.hqb.pets.dao.mapper.shopcart.TShopcartMapper;
import cn.hqb.pets.pojo.shopcart.TShopcart;
import cn.hqb.pets.pojo.shopcart.TShopcartItem;
import cn.hqb.pets.service.shopcart.ShopcartService;
import cn.hqb.pets.vo.shopcart.TShopcartVo;

@Transactional
@Service
public class ShopcartServiceImpl implements ShopcartService {

	@Autowired
	private TShopcartMapper shopcartMapper;
	
	@Autowired
	private TShopcartItemMapper shopcartItemMapper;
	
	/**  
	* @Title: insertShopcart  
	* @Description: 插入一辆购物车,并放回它的主键
	* @param @param shopcart
	* @param @return    
	* @throws  
	*/ 
	public Long insertShopcart(TShopcart shopcart) {
		Long id = shopcartMapper.insertShopcart(shopcart);
		return id;
	}

	/**  
	* @Title: getShopcartById  
	* @Description: 返回购物车以及它的条目
	* @param @param id
	* @param @return    
	* @return TShopcartVo 
	* @throws  
	*/ 
	public TShopcartVo getShopcartByUserId(Long id){
		return shopcartMapper.getShopcartByUserId(id);
	}

	/**  
	* @Title: insertItem  
	* @Description: 单条插入购物车条目
	* @param @param item
	* @param @return    
	* @throws  
	*/ 
	public int insertItem(TShopcartItem item) {
		return shopcartItemMapper.insertItem(item);
	}

	/**  
	* @Title: updateShopcartItem  
	* @Description: 根据ID修改购物车条目
	* @param @param item
	* @param @return    
	* @throws  
	*/ 
	public int updateShopcartItem(TShopcartItem item) {
		return shopcartItemMapper.updateShopcartItem(item);
	}

	/**  
	* @Title: getCountByUserId  
	* @Description: 根据用户ID返回购物车条目数
	* @param @param id
	* @param @return    
	* @throws  
	*/ 
	public int getCountByUserId(Long id) {
		return shopcartMapper.getCountByUserId(id);
	}

	/**  
	* @Title: deleteShopcartItem  
	* @Description: 单个删除购物车条目
	* @param @param id
	* @param @return    
	* @throws  
	*/ 
	public int deleteShopcartItem(Long id) {
		return shopcartItemMapper.deleteShopcartItem(id);
	}

	/**  
	* @Title: deleteShopcartItemBatch  
	* @Description: 批量删除购物车条目
	* @param @param ids
	* @param @return    
	* @throws  
	*/ 
	public int deleteShopcartItemBatch(String ids) {
		List<Long> list = Utils.separateToList(ids, ",");
		return shopcartItemMapper.deleteShopcartItemBatch(list);
	}
	
}
