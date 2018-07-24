package cn.hqb.pets.vo.order;

import java.io.Serializable;

import cn.hqb.pets.comm.Page;
import cn.hqb.pets.pojo.order.TOrder;

/**
 * @author hequanbin
 *	订单后台扩展类,包含页资料,返回用
 */
public class TAdminOrderVo extends Page<TOrder> implements Serializable {
	
	private String orderId;
	
	private String payment;
	
	private Integer paymentType;
	
	private Integer status;
	
	private int firstResult;//第一个查询位置

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getPayment() {
		return payment;
	}

	public void setPayment(String payment) {
		this.payment = payment;
	}

	public Integer getPaymentType() {
		return paymentType;
	}

	public void setPaymentType(Integer paymentType) {
		this.paymentType = paymentType;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public void setFirstResult(int firstResult) {
		this.firstResult = firstResult;
	}
}
