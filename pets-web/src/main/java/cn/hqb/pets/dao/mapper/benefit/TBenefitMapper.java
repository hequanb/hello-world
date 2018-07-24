package cn.hqb.pets.dao.mapper.benefit;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.hqb.pets.po.TItemPo;
import cn.hqb.pets.pojo.baike.TBaike;
import cn.hqb.pets.pojo.item.TItem;
import cn.hqb.pets.pojo.order.TOrderItem;
import cn.hqb.pets.vo.baike.TBaikeVo;
import cn.hqb.pets.vo.benefit.TBenefitItemVo;
import cn.hqb.pets.vo.benefit.TBenefitVo;
import cn.hqb.pets.vo.item.TItemVo;

public interface TBenefitMapper {
	
	String getBenefit(TBenefitVo vo);
	
	List<TOrderItem> getDetailBenefit(TBenefitItemVo vo);
	
	int getDetailCount(TBenefitItemVo vo);
	
}
