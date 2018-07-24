package cn.hqb.pets.controller.user;

import java.io.IOException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import cn.hqb.pets.comm.Result;
import cn.hqb.pets.controller.BaseController;
import cn.hqb.pets.enums.ResultEnums;
import cn.hqb.pets.pojo.user.TUser;
import cn.hqb.pets.service.user.UserService;
import cn.hqb.pets.vo.user.TUserVo;

@Controller
@RequestMapping("/user")
public class UserController extends BaseController{

	@Autowired
	private UserService userService;
	
	private static ObjectMapper mapper = new ObjectMapper();

	private static Result result = new Result();
	
	@RequestMapping("/toLogin")
	public String toLogin(){
		return "reglog/login";
	}
	
	@RequestMapping("/toLoginAndRegist")
	public void toLoginAndRegist(HttpServletResponse response, @RequestParam(value = "hash", required = false) String hash) throws Exception{
		if(hash == null || hash == "") hash = "login";
		response.sendRedirect("/pets-web/user/toLogin#docDemoTabBrief="+hash);
	}
	
	@RequestMapping("/checkUserNameForAjax")
	public void checkUserNameForAjax(HttpServletResponse response,String username) throws Exception{
		result = userService.usernameIsExisted(username);
		String json = mapper.writeValueAsString(result);
		super.printOutMsg(response, json);
	}
	
	@RequestMapping("/checkEmailForAjax")
	public void checkEmailForAjax(HttpServletResponse response,String email) throws Exception{
		result = userService.emailIsExisted(email);
		String json = mapper.writeValueAsString(result);
		super.printOutMsg(response, json);
	}
	
	@RequestMapping("/checkPhoneForAjax")
	public void checkPhoneForAjax(HttpServletResponse response,String phone) throws Exception{
		result = userService.phoneIsExisted(phone);
		String json = mapper.writeValueAsString(result);
		super.printOutMsg(response, json);
	}
	
	@RequestMapping(value = "/regist", method = RequestMethod.POST)
	public void regist(@RequestBody TUser user,HttpServletResponse response) throws Exception{
		result = userService.regist(user);
		String json = mapper.writeValueAsString(result);
		super.printOutMsg(response, json);
	}
	
	@RequestMapping(value = "/activate",method = RequestMethod.GET)
	public String activate(Model model,@RequestParam(value = "code") String code){
		result = userService.activate(code);
		model.addAttribute(result);
		return "tips/tips";
	}
	
	@RequestMapping(value = "/tips")
	public String toTips(){
		return "tips/tips";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public void login(Model model, @RequestBody TUserVo userVo, HttpServletRequest request, HttpServletResponse response) throws Exception{
		TUser existUser = userService.login(userVo);
		if(existUser != null){
			if(userVo.getRemFlag()){
				 String loginInfo = userVo.getUsername()+","+userVo.getPassword();
	             Cookie userCookie=new Cookie("loginInfo",loginInfo); 
	             userCookie.setMaxAge(30*24*60*60);   //存活期为一个月 30*24*60*60
	             userCookie.setPath("/");
	             response.addCookie(userCookie); 
			}
			request.getSession().setAttribute("user", existUser);
			result.setCode(ResultEnums.SUCCESS);
			result.setMsg("登录成功!");
			String json = mapper.writeValueAsString(result);
			super.printOutMsg(response, json);
		}else{
			result.setCode(ResultEnums.ERROR);
			result.setMsg("账号或者密码不正确!");
			String json = mapper.writeValueAsString(result);
			super.printOutMsg(response, json);
		}
	}
	
	@RequestMapping(value="logout")
	public void logout(HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.getSession().invalidate();
		response.sendRedirect("/pets-web");
	}
	
	@RequestMapping(value="myInfo")
	public String myInfo(HttpServletRequest request, Model model)throws Exception{
		TUser existUser = (TUser)request.getSession().getAttribute("user");
		if(null == existUser){
			model.addAttribute("code", 100);
			model.addAttribute("msg", "您还没有登录");
		}else{
			model.addAttribute("code", 0);
			model.addAttribute("user", existUser);
		}
		return "reglog/myInfo";
	}
	
	@RequestMapping(value="editMyInfo", method=RequestMethod.POST)
	public void editMyInfo(HttpServletRequest request, HttpServletResponse response, String nickName)throws Exception{
		Result result = new Result();
		TUser existUser = (TUser)request.getSession().getAttribute("user");
		existUser.setNickName(nickName);
		TUser user = new TUser();
		user.setId(existUser.getId());
		user.setNickName(nickName);
		if(null == existUser || "".equals(existUser.getId()) || null == existUser.getId()){
			result.setCode("100");
			result.setMsg("您还没有登录");
		}else{
			result = userService.editMyInfo(user);
			if("0".equals(result.getCode())){
				request.getSession().setAttribute("user", existUser);
			}
		}
		String json = mapper.writeValueAsString(result);
		super.printOutMsg(response, json);
	}
	
}
