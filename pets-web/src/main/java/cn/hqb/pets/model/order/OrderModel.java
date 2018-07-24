package cn.hqb.pets.model.order;

import cn.hqb.pets.pojo.order.TOrderExpress;

/**  
* @ClassName: OrderModel  
* @Description: 用于接收订单页面数据 ,拓展了TOrderExpress
* @author hequanbin  
* @date 2018年3月4日  
*    
*/ 
public class OrderModel extends TOrderExpress{
	
	private String buyerMessage;
	
	private Integer paymentType;
	
	private Long userId;
	
	private String buyerNick;

	public String getBuyerNick() {
		return buyerNick;
	}

	public void setBuyerNick(String buyerNick) {
		this.buyerNick = buyerNick;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public String getBuyerMessage() {
		return buyerMessage;
	}

	public void setBuyerMessage(String buyerMessage) {
		this.buyerMessage = buyerMessage;
	}

	public Integer getPaymentType() {
		return paymentType;
	}

	public void setPaymentType(Integer paymentType) {
		this.paymentType = paymentType;
	}
	
}
