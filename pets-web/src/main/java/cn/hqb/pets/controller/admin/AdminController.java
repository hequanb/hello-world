package cn.hqb.pets.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import cn.hqb.pets.comm.LayuiTableData;
import cn.hqb.pets.comm.Result;
import cn.hqb.pets.controller.BaseController;
import cn.hqb.pets.enums.ResultEnums;
import cn.hqb.pets.po.TItemPo;
import cn.hqb.pets.pojo.admin.TAdmin;
import cn.hqb.pets.pojo.item.TItem;
import cn.hqb.pets.pojo.itemCat.TItemCat;
import cn.hqb.pets.pojo.order.TOrderItem;
import cn.hqb.pets.pojo.user.TUser;
import cn.hqb.pets.service.admin.AdminService;
import cn.hqb.pets.service.benefit.BenefitService;
import cn.hqb.pets.service.item.ItemService;
import cn.hqb.pets.service.itemCat.ItemCatService;
import cn.hqb.pets.vo.benefit.TBenefitItemVo;
import cn.hqb.pets.vo.benefit.TBenefitVo;

@Controller
@RequestMapping("/admin")
public class AdminController extends BaseController{

	@Autowired
	private ItemService itemService;
	@Autowired
	private BenefitService benefitService;
	@Autowired
	private AdminService adminService;
	
	private static ObjectMapper mapper = new ObjectMapper();
	
	@RequestMapping("/index")
	public String index(){
		return "adminIndex";
	}
	
	@RequestMapping("/toAddItem")
	public String toAddItem(){
		return "admin/addItem";
	}
	
	@RequestMapping("/toGetItemList")
	public String toGetItemList(){
		return "admin/itemList";
	}
	
	
	/**
	 * @param response
	 * @param itemPo
	 * @return test2
	 * @throws Exception
	 * 编辑商品页面
	 */
	@RequestMapping("toEditItem/{id}")
	public String toEditItem(Model model, @PathVariable(value= "id")long id){
		TItem item = itemService.getItemById(id);
		model.addAttribute("item", item);
		return "admin/editItem";
	}
	
	@RequestMapping("toSetItemCat")
	public String toSetItemCat(){
		return "admin/setItemCat";
	}
	
	@RequestMapping("/benefit/toDetailBenefit")
	public String toDetailBenefit(){
		return "admin/detailBenefit";
	}
	
	@RequestMapping(value = "/benefit/benefitInTime", method = RequestMethod.GET)
	public String benefitInTime(){
		return "admin/benefitAllInTime";
	}
	
	@RequestMapping(value = "/benefit/getBenefit", method = RequestMethod.GET)
	public void getBenefit(HttpServletResponse response, TBenefitVo vo) throws Exception{
		String payment = benefitService.getBenefit(vo);
		String json = mapper.writeValueAsString(payment);
		super.printOutMsg(response, json);
	}
	
	@RequestMapping(value = "/benefit/getDetailBenefit", method = RequestMethod.GET)
	public void getDetailBenefit(HttpServletResponse response, TBenefitItemVo vo) throws Exception{
		LayuiTableData ltb = benefitService.getDetailBenefit(vo);
		String json = mapper.writeValueAsString(ltb);
		super.printOutMsg(response, json);
	}
	
	@RequestMapping("adminLogin")
	public String adminLogin(){
		return "reglog/adminLogin";
	}
	
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public void login(HttpServletRequest request, HttpServletResponse response, TAdmin admin) throws Exception{
		Result result = new Result();
		TAdmin existAdmin = adminService.login(admin);
		if(existAdmin != null){
			request.getSession().setAttribute("admin", existAdmin);
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
	
	@RequestMapping(value="adminLogout")
	public void adminLogout(HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.getSession().removeAttribute("admin");
		response.sendRedirect("/pets-web/admin/index");
	}
	
}
