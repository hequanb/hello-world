package cn.hqb.pets.dao.mapper.user;

import org.apache.ibatis.annotations.Param;

import cn.hqb.pets.pojo.user.TUser;
import cn.hqb.pets.vo.user.TUserVo;

public interface TUserMapper {
	
	Boolean usernameIsExisted(@Param("username") String username);
	
	Boolean emailIsExisted(@Param("email") String email);
	
	Boolean phoneIsExisted(@Param("phone") String phone);
	
	int insert(TUser user);
	
	TUser findUserByCode(@Param("code") String code);
	
	int updateById(TUser user);
	
	TUser login(TUser user);
	
}
