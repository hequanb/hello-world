package cn.hqb.pets.comm;

import java.io.Serializable;
import java.util.List;

public class LayUITreeData implements Serializable {

	private String name;//显示的值,必填
	
	private long id;//隐藏的值,必填
	
	private long parentId;
	
	private int sortOrder;
	
	private Boolean isParent;
	
	private Boolean spread;
	
	private boolean checked;//默认是否选中，true为选中，false与不填都为不选中 （选填）
	
	private boolean disabled;//bool  是否可用，true为不可用，false与不填都为可用 （选填）
	
	private List children;//json数组  节点的子节点数组，结构与此节点一致，（必填）如果无子节点则必须为 data:[]

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getParentId() {
		return parentId;
	}

	public void setParentId(long parentId) {
		this.parentId = parentId;
	}

	public int getSortOrder() {
		return sortOrder;
	}

	public void setSortOrder(int sortOrder) {
		this.sortOrder = sortOrder;
	}

	public Boolean getIsParent() {
		return isParent;
	}

	public void setIsParent(Boolean isParent) {
		this.isParent = isParent;
	}

	public Boolean getSpread() {
		return spread;
	}

	public void setSpread(Boolean spread) {
		this.spread = spread;
	}

	public boolean isChecked() {
		return checked;
	}

	public void setChecked(boolean checked) {
		this.checked = checked;
	}

	public boolean isDisabled() {
		return disabled;
	}

	public void setDisabled(boolean disabled) {
		this.disabled = disabled;
	}

	public List getChildren() {
		return children;
	}

	public void setChildren(List children) {
		this.children = children;
	}

	
}
