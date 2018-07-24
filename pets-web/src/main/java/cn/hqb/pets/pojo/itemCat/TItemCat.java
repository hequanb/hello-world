package cn.hqb.pets.pojo.itemCat;

import java.io.Serializable;
import java.util.Date;

public class TItemCat implements Serializable {

	private Long id;
	
	private Long parentId;
	
	private String name;
	
	private Byte status;
	
	private Byte sortOrder;
	
	private Boolean isParent;
	
    private Date created;

    private Date updated;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getParentId() {
		return parentId;
	}

	public void setParentId(Long parentId) {
		this.parentId = parentId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Byte getStatus() {
		return status;
	}

	public void setStatus(Byte status) {
		this.status = status;
	}

	public Byte getSortOrder() {
		return sortOrder;
	}

	public void setSortOrder(Byte sortOrder) {
		this.sortOrder = sortOrder;
	}

	public Boolean getIsParent() {
		return isParent;
	}

	public void setIsParent(Boolean isParent) {
		this.isParent = isParent;
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

}
