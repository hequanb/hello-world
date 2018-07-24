package cn.hqb.pets.comm;

import java.io.Serializable;
import java.util.List;

public class LayUIXTreeData implements Serializable {

	private String title;//显示的值,必填
	
	private String value;//隐藏的值,必填
	
	private boolean checked;//默认是否选中，true为选中，false与不填都为不选中 （选填）
	
	private boolean disabled;//bool  是否可用，true为不可用，false与不填都为可用 （选填）
	
	private List data;//json数组  节点的子节点数组，结构与此节点一致，（必填）如果无子节点则必须为 data:[]

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
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

	public List getData() {
		return data;
	}

	public void setData(List data) {
		this.data = data;
	}
	
}
