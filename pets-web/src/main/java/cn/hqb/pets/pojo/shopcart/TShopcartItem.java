package cn.hqb.pets.pojo.shopcart;

import java.io.Serializable;
import java.util.Date;

import cn.hqb.pets.pojo.item.TItem;

public class TShopcartItem implements Serializable {
	
	private Long id;
	
	private Long cartId;
	
	private Long itemId;

	private Long count;
	
	private Byte status;
	
	private Date created;
	
	private Date updated;
	
	private TItem item;

	public TItem getItem() {
		return item;
	}

	public void setItem(TItem item) {
		this.item = item;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getCartId() {
		return cartId;
	}

	public void setCartId(Long cartId) {
		this.cartId = cartId;
	}

	public Long getCount() {
		return count;
	}

	public void setCount(Long count) {
		this.count = count;
	}

	public Byte getStatus() {
		return status;
	}

	public void setStatus(Byte status) {
		this.status = status;
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
	
	public Long getItemId() {
		return itemId;
	}

	public void setItemId(Long itemId) {
		this.itemId = itemId;
	}

}
