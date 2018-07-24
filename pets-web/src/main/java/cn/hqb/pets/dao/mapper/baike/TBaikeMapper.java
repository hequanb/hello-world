package cn.hqb.pets.dao.mapper.baike;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.hqb.pets.po.TItemPo;
import cn.hqb.pets.pojo.baike.TBaike;
import cn.hqb.pets.pojo.item.TItem;
import cn.hqb.pets.vo.baike.TBaikeVo;
import cn.hqb.pets.vo.item.TItemVo;

public interface TBaikeMapper {
	
	int insert(TBaike baike);
	
	int delete(@Param("id") Long id);
	
	int update(TBaike baike);
	
	Integer getCount(TBaikeVo vo);
	
	List<TBaikeVo> getBaike(TBaikeVo vo);
	
	List<TBaike> getBaikeNew();
	
	TBaike getBaikeById(@Param("id")Long id);
	
	List<TBaike> getBaikeByCid(@Param("cid")Integer cid);
	
	
}
