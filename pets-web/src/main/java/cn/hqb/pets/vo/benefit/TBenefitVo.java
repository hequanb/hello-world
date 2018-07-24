package cn.hqb.pets.vo.benefit;

import java.io.Serializable;
import java.util.List;

import cn.hqb.pets.pojo.shopcart.TShopcartItem;

public class TBenefitVo implements Serializable {
	
	private Integer paymentType;//支付类型,0全,1在线支付,2货到付款
	
	private Integer timeType;//时间类型.1 一周内, 2 一月内, 3 三月内

	public Integer getPaymentType() {
		return paymentType;
	}

	public void setPaymentType(Integer paymentType) {
		this.paymentType = paymentType;
	}

	public Integer getTimeType() {
		return timeType;
	}

	public void setTimeType(Integer timeType) {
		this.timeType = timeType;
	}
	
}
