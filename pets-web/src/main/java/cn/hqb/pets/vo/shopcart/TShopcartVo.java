package cn.hqb.pets.vo.shopcart;

import java.io.Serializable;
import java.util.List;

import cn.hqb.pets.pojo.shopcart.TShopcartItem;

public class TShopcartVo implements Serializable {

	private Long cartId;//购物车ID
	
	private Long userId;//用户ID
		
	private List<TShopcartItem> itemList;//
	
	public Long getCartId() {
		return cartId;
	}

	public void setCartId(Long cartId) {
		this.cartId = cartId;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public List<TShopcartItem> getItemList() {
		return itemList;
	}

	public void setItemList(List<TShopcartItem> itemList) {
		this.itemList = itemList;
	}

	public String toString() {
		return "TShopcartVo [cartId=" + cartId + ", userId=" + userId + ", itemList=" + itemList + "]";
	}
	
}
