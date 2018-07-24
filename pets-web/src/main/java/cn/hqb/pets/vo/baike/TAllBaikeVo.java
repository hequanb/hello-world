package cn.hqb.pets.vo.baike;

import java.io.Serializable;
import java.util.List;

import cn.hqb.pets.comm.Page;
import cn.hqb.pets.pojo.baike.TBaike;

/**
 * @author hequanbin
 *	百科首页扩展类,返回用
 */
public class TAllBaikeVo implements Serializable {

	private List<TBaike> dogList;
	
	private List<TBaike> catList;
	
	private List<TBaike> otherList;

	public List<TBaike> getDogList() {
		return dogList;
	}

	public void setDogList(List<TBaike> dogList) {
		this.dogList = dogList;
	}

	public List<TBaike> getCatList() {
		return catList;
	}

	public void setCatList(List<TBaike> catList) {
		this.catList = catList;
	}

	public List<TBaike> getOtherList() {
		return otherList;
	}

	public void setOtherList(List<TBaike> otherList) {
		this.otherList = otherList;
	}

}
