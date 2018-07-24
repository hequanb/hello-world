package cn.hqb.pets.comm;

import java.io.Serializable;
import java.util.List;

public class Page<T> implements Serializable {

	/*
	 * 
	 * 
	 * 
	 * */
	
	private int page;//当前页码
	
	private int limit;//每页多少条
	
	private int total;//记录总数
	
	private int totalPage;//总页数
	
	private List<T> data;

	public Page() {};
	
	public Page(int limit) {
		this.limit = limit;
	}
	
	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getLimit() {
		return limit;
	}

	public void setLimit(int limit) {
		this.limit = limit;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public List<T> getData() {
		return data;
	}

	public void setData(List<T> data) {
		this.data = data;
	}
	
	/**
	 *  第一条记录=(当前页面-1)*页面大小
	 */
	public int getFirstResult(){
		int firstResult = ( getPage()-1 ) * getLimit();
		if (firstResult >= getTotal()) {
			firstResult = 0;
		}
		return firstResult; 
	}

}
