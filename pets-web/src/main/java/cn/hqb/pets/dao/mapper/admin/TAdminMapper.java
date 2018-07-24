package cn.hqb.pets.dao.mapper.admin;

import org.apache.ibatis.annotations.Param;

import cn.hqb.pets.pojo.admin.TAdmin;

public interface TAdminMapper {
	
	TAdmin login(TAdmin admin);
	
}
