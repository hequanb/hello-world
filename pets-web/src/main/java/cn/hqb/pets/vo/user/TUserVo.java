package cn.hqb.pets.vo.user;

import java.io.Serializable;

import cn.hqb.pets.comm.Page;
import cn.hqb.pets.pojo.item.TItem;
import cn.hqb.pets.pojo.user.TUser;

/**
 * @author hequanbin
 *	商品扩展类,包含页资料,返回用
 */
public class TUserVo extends TUser implements Serializable {
	
	private Boolean remFlag;

	public Boolean getRemFlag() {
		return remFlag;
	}

	public void setRemFlag(Boolean remFlag) {
		this.remFlag = remFlag;
	}

}
