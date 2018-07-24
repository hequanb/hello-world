package cn.hqb.pets.vo.order;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import cn.hqb.pets.pojo.order.TOrderItem;
import cn.hqb.pets.pojo.shopcart.TShopcartItem;

/**  
* @ClassName: TOrderVo  
* @Description: 订单拓展类
* @author hequanbin  
* @date 2018年2月23日  
*    
*/ 
public class TMyOrderVo implements Serializable {
			
	private Long id;
	
	private Long orderId;
	
	private Double payment;
	
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
	
	private String receiverName;
	
	private String receiverPhone;
	
	private String receiverZip;
	
	private String receiverAddress;
	
	private List<TOrderItem> list;
	
	private Long itemCount;

	public Long getItemCount() {
		return itemCount;
	}

	public void setItemCount(Long itemCount) {
		this.itemCount = itemCount;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getOrderId() {
		return orderId;
	}

	public void setOrderId(Long orderId) {
		this.orderId = orderId;
	}

	public Double getPayment() {
		return payment;
	}

	public void setPayment(Double payment) {
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

	public String getReceiverName() {
		return receiverName;
	}

	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}

	public String getReceiverPhone() {
		return receiverPhone;
	}

	public void setReceiverPhone(String receiverPhone) {
		this.receiverPhone = receiverPhone;
	}

	public String getReceiverZip() {
		return receiverZip;
	}

	public void setReceiverZip(String receiverZip) {
		this.receiverZip = receiverZip;
	}

	public String getReceiverAddress() {
		return receiverAddress;
	}

	public void setReceiverAddress(String receiverAddress) {
		this.receiverAddress = receiverAddress;
	}
	public List<TOrderItem> getList() {
		return list;
	}

	public void setList(List<TOrderItem> list) {
		this.list = list;
	}

}
