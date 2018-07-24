package cn.hqb.pets.service.impl.benefit;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.hqb.pets.comm.LayuiTableData;
import cn.hqb.pets.comm.Page;
import cn.hqb.pets.dao.mapper.benefit.TBenefitMapper;
import cn.hqb.pets.dao.mapper.item.TItemMapper;
import cn.hqb.pets.po.TItemPo;
import cn.hqb.pets.pojo.item.TItem;
import cn.hqb.pets.pojo.order.TOrderItem;
import cn.hqb.pets.service.benefit.BenefitService;
import cn.hqb.pets.service.item.ItemService;
import cn.hqb.pets.vo.benefit.TBenefitItemVo;
import cn.hqb.pets.vo.benefit.TBenefitVo;
import cn.hqb.pets.vo.item.TItemVo;

@Transactional
@Service
public class BenefitServiceImpl implements BenefitService {

	@Autowired
	private TBenefitMapper benefitMapper;

	public String getBenefit(TBenefitVo vo) {
		String payment = benefitMapper.getBenefit(vo);
		return payment;
	}
	
	public LayuiTableData getDetailBenefit(TBenefitItemVo vo) {
		LayuiTableData tableData = new LayuiTableData();
		int count = benefitMapper.getDetailCount(vo);
		List<TOrderItem> list = benefitMapper.getDetailBenefit(vo);
		if(count > 0 && null != list){
			tableData.setCount(count);
			tableData.setData(list);
			tableData.setMsg("成功");
			tableData.setCode("0");
		}else{
			tableData.setMsg("没有数据!");
			tableData.setCode("200");
			tableData.setCount(0);
			tableData.setData(null);
		}
		return tableData;
	}
	
}
