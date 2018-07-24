package cn.hqb.pets.service.impl.user;

import javax.mail.internet.AddressException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.mysql.jdbc.Util;

import cn.hqb.pets.comm.Result;
import cn.hqb.pets.comm.Utils;
import cn.hqb.pets.dao.mapper.user.TUserMapper;
import cn.hqb.pets.pojo.user.TUser;
import cn.hqb.pets.service.user.UserService;
import cn.hqb.pets.vo.user.TUserVo;

@Transactional
@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private TUserMapper userMapper;
	
	private static Result result = new Result();
	
	public Result usernameIsExisted(String username) {
		Result result = new Result();
		result.setCode("100");
		result.setMsg("此账号已被使用!");
		Boolean isExisted = userMapper.usernameIsExisted(username);
		if(!isExisted){
			result.setCode("0");
			result.setMsg("此账号可以使用!");
		}
		return result;
	}

	public Result emailIsExisted(String email) {
		Result result = new Result();
		result.setCode("100");
		result.setMsg("此邮箱已被使用");
		Boolean isExisted = userMapper.emailIsExisted(email);
		if(!isExisted){
			result.setCode("0");
			result.setMsg("此邮箱可以使用!");
		}
		return result;
	}

	public Result phoneIsExisted(String phone) {
		Result result = new Result();
		result.setCode("100");
		result.setMsg("此手机号码已被使用");
		Boolean isExisted = userMapper.phoneIsExisted(phone);
		if(!isExisted){
			result.setCode("0");
			result.setMsg("此手机号码可以使用!");
		}
		return result;
	}

	public Result regist(TUser user) {
		result.setCode("100");
		result.setMsg("注册失败");
		user.setState(0);
		//邮件激活码
		String uuid = Utils.getUUID()+Utils.getUUID();
		user.setCode(uuid);
		int num = userMapper.insert(user);
		if(num > 0){
			try {
				Utils.sendMail(user.getEmail(), user.getCode());
				result.setCode("0");
				result.setMsg("恭喜你,注册成功,请到邮箱进行激活!");
			}  catch (Exception e) {
				result.setCode("100");
				result.setMsg("邮箱错误!");
				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly(); 
				e.printStackTrace();
			}
		}
		return result;
	}

	/**  
	* @Title: activate  
	* @Description: 激活,根据激活码 查找 username,若存在,清空code并将status设置1
	* @param @param code
	* @param @return    
	* @throws  
	*/ 
	public Result activate(String code) {
		result.setCode("100");
		result.setMsg("激活失败,验证码错误或者用户不存在!");
		TUser user = userMapper.findUserByCode(code);
		if(null != user){
			//将状态设为1并清空code
			user.setCode("");
			user.setState(1);
			int num = userMapper.updateById(user);
			if(num > 0){
				result.setCode("0");
				result.setMsg("激活成功,请登录!");
			}
		}
		return result;
	}

	public TUser login(TUserVo userVo) {
		TUser user = new TUser();
		user.setUsername(userVo.getUsername());
		user.setPassword(userVo.getPassword());
		TUser existUser = userMapper.login(user);
		return existUser;
	}

	public Result editMyInfo(TUser user) {
		Result result = new Result();
		result.setCode("100");
		result.setMsg("昵称修改失败!");
		int i = userMapper.updateById(user);
		if(i > 0){
			result.setCode("0");
			result.setMsg("昵称修改成功!");
		}
		return result;
	}

}
