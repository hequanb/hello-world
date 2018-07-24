package cn.hqb.pets.comm;

import java.io.Serializable;
import java.util.Map;

public class Result implements Serializable {

	private String code; //0成功,100失败,404
	private String msg;
//	private Map data;
	private String data;//为了防止Long的精度丢失,还是使用String吧,例如orderId
//	private Object data;
	
	public Result() {
		
	}
	
	public String toString() {
		return "Result [code=" + code + ", msg=" + msg + ", data=" + data + "]";
	}

//	public Result(String code, String msg, String data) {
//		super();
//		this.code = code;
//		this.msg = msg;
//		this.data = data;
//	}
	public Result(String code, String msg, String data) {
		super();
		this.code = code;
		this.msg = msg;
		this.data = data;
	}
	
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
	public String getData() {
		return data;
	}
	public void setData(String data) {
		this.data = data;
	}
	
}
