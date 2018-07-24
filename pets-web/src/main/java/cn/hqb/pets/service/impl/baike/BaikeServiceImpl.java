package cn.hqb.pets.service.impl.baike;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.hqb.pets.comm.LayuiTableData;
import cn.hqb.pets.comm.Page;
import cn.hqb.pets.comm.Result;
import cn.hqb.pets.dao.mapper.baike.TBaikeMapper;
import cn.hqb.pets.dao.mapper.item.TItemMapper;
import cn.hqb.pets.po.TItemPo;
import cn.hqb.pets.pojo.baike.TBaike;
import cn.hqb.pets.pojo.item.TItem;
import cn.hqb.pets.service.baike.BaikeService;
import cn.hqb.pets.service.item.ItemService;
import cn.hqb.pets.vo.baike.TAllBaikeVo;
import cn.hqb.pets.vo.baike.TBaikeVo;
import cn.hqb.pets.vo.item.TItemVo;
import cn.hqb.pets.vo.order.TAdminOrderVo;

@Transactional
@Service
public class BaikeServiceImpl implements BaikeService {

	@Autowired
	private TBaikeMapper baikeMapper;

	public Result insert(TBaike baike) {
		Result result = new Result();
		result.setCode("100");
		result.setMsg("插入百科信息失败!");
		int i = baikeMapper.insert(baike);
		if(i > 0){
			result.setCode("0");
			result.setMsg("插入百科信息成功!");
		}
		return result;
	}

	public LayuiTableData getBaikeList(TBaikeVo vo) {
		LayuiTableData tableData = new LayuiTableData();
		Integer count = baikeMapper.getCount(vo);
		vo.setTotal(count);
		int firstResult = vo.getFirstResult();
		vo.setFirstResult(firstResult);
		List<TBaikeVo> list = baikeMapper.getBaike(vo);
		if(count > 0 && null != list){
			tableData.setCount(count);
			tableData.setData(list);
			tableData.setMsg("成功");
			tableData.setCode("0");
		}else{
			tableData.setMsg("暂无数据!");
			tableData.setCode("200");
			tableData.setCount(0);
			tableData.setData(null);
		}
		return tableData;
	}

	public Result delete(Long id) {
		Result result = new Result();
		result.setCode("100");
		result.setMsg("删除百科信息失败!");
		int i = baikeMapper.delete(id);
		if(i > 0){
			result.setCode("0");
			result.setMsg("删除百科信息成功!");
		}
		return result;
	}
	
	public TBaike getBaikeById(Long id) {
		TBaike baike = baikeMapper.getBaikeById(id);
		return baike;
	}

	public Result update(TBaike baike) {
		Result result = new Result();
		result.setCode("100");
		result.setMsg("修改百科信息失败");
		int i = baikeMapper.update(baike);
		if(i > 0){
			result.setCode("0");
			result.setMsg("修改百科信息成功!");
		}
		return result;
	}
	
	public TAllBaikeVo getAllBaike() {
		TAllBaikeVo vo = new TAllBaikeVo();
		List<TBaike> list = baikeMapper.getBaikeNew();
		List<TBaike> dogList = new ArrayList<TBaike>();
		List<TBaike> catList = new ArrayList<TBaike>();
		List<TBaike> otherList = new ArrayList<TBaike>();
		for (TBaike baike : list) {
			if(0 == baike.getCid()){
				dogList.add(baike);
			}else if(1 == baike.getCid()){
				catList.add(baike);
			}else{
				otherList.add(baike);
			}
		}
		vo.setDogList(dogList);
		vo.setCatList(catList);
		vo.setOtherList(otherList);
		return vo;
	}

	public List<TBaike> getKindOfBaike(Integer cid) {
		List<TBaike> list = baikeMapper.getBaikeByCid(cid);
		return list;
	}

}
