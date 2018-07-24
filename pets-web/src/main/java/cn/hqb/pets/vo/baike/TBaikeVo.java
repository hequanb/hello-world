package cn.hqb.pets.vo.baike;

import java.io.Serializable;

import cn.hqb.pets.comm.Page;
import cn.hqb.pets.pojo.baike.TBaike;

/**
 * @author hequanbin
 *	百科扩展类,包含页资料,返回用
 */
public class TBaikeVo extends Page<TBaike> implements Serializable {
	
	private String name;
		
	private Integer cid;
			
	private int firstResult;//第一个查询位置

	public void setFirstResult(int firstResult) {
		this.firstResult = firstResult;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getCid() {
		return cid;
	}

	public void setCid(Integer cid) {
		this.cid = cid;
	}
	
}
