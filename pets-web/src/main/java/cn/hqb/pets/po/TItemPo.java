package cn.hqb.pets.po;

import java.io.Serializable;

import cn.hqb.pets.pojo.item.TItem;

public class TItemPo extends TItem implements Serializable {
	
	private String cName;

	public String getcName() {
		return cName;
	}

	public void setcName(String cName) {
		this.cName = cName;
	}

}
