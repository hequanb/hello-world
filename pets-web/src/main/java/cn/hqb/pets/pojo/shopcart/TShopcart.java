package cn.hqb.pets.pojo.shopcart;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class TShopcart implements Serializable {
	
	private Long id;
	
	private Long userId;
	
	private Byte status;
	
	private Date created;
	
	private List<TShopcartItem> items;
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
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

	public List<TShopcartItem> getItems() {
		return items;
	}

	public void setItems(List<TShopcartItem> items) {
		this.items = items;
	}

	
}
