package cn.hqb.pets.controller.baike.admin;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import cn.hqb.pets.comm.LayuiTableData;
import cn.hqb.pets.comm.Result;
import cn.hqb.pets.controller.BaseController;
import cn.hqb.pets.model.order.OrderModel;
import cn.hqb.pets.pojo.baike.TBaike;
import cn.hqb.pets.pojo.order.TOrder;
import cn.hqb.pets.pojo.order.TOrderItem;
import cn.hqb.pets.pojo.user.TUser;
import cn.hqb.pets.service.baike.BaikeService;
import cn.hqb.pets.service.order.OrderService;
import cn.hqb.pets.vo.item.TItemVo;
import cn.hqb.pets.vo.order.TAdminOrderVo;
import cn.hqb.pets.vo.order.TOrderVo;

@Controller
@RequestMapping("/admin/baike")
public class AdminBaikeController extends BaseController {
	
	@Autowired
	private BaikeService baikeService;
	
	private static ObjectMapper mapper = new ObjectMapper();
	
	@RequestMapping(value = "toAddBaike", method = RequestMethod.GET)
	public String toAddBaike(){
		return "admin/addBaike";
	}
	
	@RequestMapping(value = "toGetBaikeList", method = RequestMethod.GET)
	public String toGetBaikeList(){
		return "admin/baikeList";
	}
	
	@RequestMapping(value = "toEditBaike", method = RequestMethod.GET)
	public String toEditBaike(Model model, Long id){
		TBaike baike = baikeService.getBaikeById(id);
		model.addAttribute("baike", baike);
		return "admin/editBaike";
	}
	
	@RequestMapping(value = "addBaike", method = RequestMethod.POST)
	public void addBaike(HttpServletResponse response, @RequestBody TBaike baike) throws Exception{
		Result result = baikeService.insert(baike);
		String json = mapper.writeValueAsString(result);
		super.printOutMsg(response, json);
	}

	@RequestMapping(value = "deleteBaike", method = RequestMethod.POST)
	public void deleteBaike(HttpServletResponse response, Long id) throws Exception{
		Result result = baikeService.delete(id);
		String json = mapper.writeValueAsString(result);
		super.printOutMsg(response, json);
	}
	
	@RequestMapping(value = "editBaike", method = RequestMethod.POST)
	public void editBaike(HttpServletResponse response, @RequestBody TBaike baike) throws Exception{
		Result result = baikeService.update(baike);
		String json = mapper.writeValueAsString(result);
		super.printOutMsg(response, json);
	}
	
}
