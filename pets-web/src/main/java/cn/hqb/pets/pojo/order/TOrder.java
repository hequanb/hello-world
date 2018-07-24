package cn.hqb.pets.pojo.order;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class TOrder implements Serializable {
	private Long id;
	
	private String orderId;
	
	private String payment;
	
	private Integer paymentType;
	
	private Integer status;
	
	private String shippingCode;
	
	private Date created;
	
	private Date updated;
	
	private Date paid;
	
	private Date consigned;
	
	private Date end;
	
	private Date closed;
	
	private Long userId;
	
	private String buyerMessage;
	
	private String buyerNick;
	
	private String buyerRate;

	private List<TOrderItem> itemList;
	
	private TOrderExpress express;
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

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

	public String getShippingCode() {
		return shippingCode;
	}

	public void setShippingCode(String shippingCode) {
		this.shippingCode = shippingCode;
	}

	public Date getCreated() {
		return created;
	}

	public void setCreated(Date created) {
		this.created = created;
	}

	public Date getUpdated() {
		return updated;
	}

	public void setUpdated(Date updated) {
		this.updated = updated;
	}

	public Date getPaid() {
		return paid;
	}

	public void setPaid(Date paid) {
		this.paid = paid;
	}

	public Date getConsigned() {
		return consigned;
	}

	public void setConsigned(Date consigned) {
		this.consigned = consigned;
	}

	public Date getEnd() {
		return end;
	}

	public void setEnd(Date end) {
		this.end = end;
	}

	public Date getClosed() {
		return closed;
	}

	public void setClosed(Date closed) {
		this.closed = closed;
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

	public String getBuyerNick() {
		return buyerNick;
	}

	public void setBuyerNick(String buyerNick) {
		this.buyerNick = buyerNick;
	}

	public String getBuyerRate() {
		return buyerRate;
	}

	public void setBuyerRate(String buyerRate) {
		this.buyerRate = buyerRate;
	}
	
	public List<TOrderItem> getItemList() {
		return itemList;
	}

	public void setItemList(List<TOrderItem> itemList) {
		this.itemList = itemList;
	}

	public TOrderExpress getExpress() {
		return express;
	}

	public void setExpress(TOrderExpress express) {
		this.express = express;
	}

}
