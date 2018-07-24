package cn.hqb.pets.comm;

import java.io.Serializable;
import java.util.List;

public class LayuiTableData implements Serializable {
	
	private String code; //0 成功,200 失败,404 找不到
	
	private String msg;
	
	private int count;
	
	private List data;
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public List getData() {
		return data;
	}
	public void setData(List data) {
		this.data = data;
	}
	
}
