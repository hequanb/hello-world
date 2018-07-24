package cn.hqb.pets.service.benefit;

import java.util.List;

import cn.hqb.pets.comm.LayuiTableData;
import cn.hqb.pets.pojo.order.TOrderItem;
import cn.hqb.pets.vo.benefit.TBenefitItemVo;
import cn.hqb.pets.vo.benefit.TBenefitVo;

public interface BenefitService {
	
	String getBenefit(TBenefitVo vo);
	
	LayuiTableData getDetailBenefit(TBenefitItemVo vo);
	
}
