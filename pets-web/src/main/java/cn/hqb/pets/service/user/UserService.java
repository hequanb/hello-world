package cn.hqb.pets.service.user;

import cn.hqb.pets.comm.Result;
import cn.hqb.pets.pojo.user.TUser;
import cn.hqb.pets.vo.user.TUserVo;

public interface UserService {
	
	Result usernameIsExisted(String username);
	
	Result emailIsExisted(String email);
	
	Result phoneIsExisted(String phone);
	
	Result regist(TUser user);
	
	//寻思良久,还是再controller去封装结果吧,不然不能共用
	Result activate(String code);
	
	TUser login(TUserVo userVo);
	
	Result editMyInfo(TUser user);
	
}
