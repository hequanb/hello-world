package cn.hqb.pets.service.impl.admin;

import javax.mail.internet.AddressException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.mysql.jdbc.Util;

import cn.hqb.pets.comm.Result;
import cn.hqb.pets.comm.Utils;
import cn.hqb.pets.dao.mapper.admin.TAdminMapper;
import cn.hqb.pets.dao.mapper.user.TUserMapper;
import cn.hqb.pets.pojo.admin.TAdmin;
import cn.hqb.pets.pojo.user.TUser;
import cn.hqb.pets.service.admin.AdminService;
import cn.hqb.pets.vo.user.TUserVo;

@Transactional
@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private TAdminMapper adminMapper;

	public TAdmin login(TAdmin admin) {
		TAdmin existAdmin = adminMapper.login(admin);
		return existAdmin;
	}

}
