package cn.hqb.pets.vo.item;

import java.io.Serializable;

import cn.hqb.pets.comm.Page;
import cn.hqb.pets.pojo.item.TItem;

/**
 * @author hequanbin
 *	商品扩展类,包含页资料,返回用
 */
public class TItemVo extends Page<TItem> implements Serializable {
	
	private String title;
	
	private String brand;
	
	private Integer cid;
	
	private String cname;
	
	private int isDel;//0表示没删除,1表示删除
	
	private int firstResult;//第一个查询位置

	public void setFirstResult(int firstResult) {
		this.firstResult = firstResult;
	}

	public int getIsDel() {
		return isDel;
	}

	public void setIsDel(int isDel) {
		this.isDel = isDel;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public Integer getCid() {
		return cid;
	}

	public void setCid(Integer cid) {
		this.cid = cid;
	}

	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}
	
}
