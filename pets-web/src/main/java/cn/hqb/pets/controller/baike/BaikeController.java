package cn.hqb.pets.controller.baike;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import cn.hqb.pets.comm.LayuiTableData;
import cn.hqb.pets.comm.Result;
import cn.hqb.pets.comm.Utils;
import cn.hqb.pets.controller.BaseController;
import cn.hqb.pets.pojo.baike.TBaike;
import cn.hqb.pets.pojo.shopcart.TShopcart;
import cn.hqb.pets.pojo.shopcart.TShopcartItem;
import cn.hqb.pets.pojo.user.TUser;
import cn.hqb.pets.service.baike.BaikeService;
import cn.hqb.pets.service.shopcart.ShopcartService;
import cn.hqb.pets.vo.baike.TAllBaikeVo;
import cn.hqb.pets.vo.baike.TBaikeVo;
import cn.hqb.pets.vo.shopcart.TShopcartItemVo;
import cn.hqb.pets.vo.shopcart.TShopcartVo;

@Controller
@RequestMapping("/baike")
public class BaikeController extends BaseController{
	
	@Autowired
	private BaikeService baikeService;
	
	private static ObjectMapper mapper = new ObjectMapper();

	@RequestMapping(value="/toBaikeIndex")
	public String toBaikeIndex(){
		return "baike/baikeIndex";
	}
	
	@RequestMapping(value="/allDog")
	public String allDog(){
		return "baike/dog/allDog";
	}
	
	@RequestMapping(value="/allCat")
	public String allCat(){
		return "baike/dog/allCat";
	}
	
	@RequestMapping(value="/allOther")
	public String allOther(){
		return "baike/dog/allOther";
	}

	/**  
	* @Title: getBaikeList  
	* @Description: 后台的
	* @param @param response
	* @param @param vo
	* @param @throws Exception    
	* @return void 
	* @throws  
	*/ 
	@RequestMapping(value = "/getBaikeList")
	public void getBaikeList(HttpServletResponse response, TBaikeVo vo) throws Exception{
		LayuiTableData ltb = baikeService.getBaikeList(vo);
		String json = mapper.writeValueAsString(ltb);
		super.printOutMsg(response, json);
	}
	
	@RequestMapping(value="/getAllBaike")
	public void getAllBaike(HttpServletResponse response) throws Exception{
		TAllBaikeVo vo = baikeService.getAllBaike();
		String json = mapper.writeValueAsString(vo);
		super.printOutMsg(response, json);
	}
	
	@RequestMapping(value="/getBaikeDetail", method=RequestMethod.GET)
	public String getBaikeDetail(Model model, Long id){
		System.out.println(id);
		TBaike baike = baikeService.getBaikeById(id);
		model.addAttribute("baike", baike);
		return "baike/baikeDetail";
	}
	
	@RequestMapping(value="/getDogBaike")
	public void getDogBaike(HttpServletResponse response) throws Exception{
		List<TBaike> list = baikeService.getKindOfBaike(0);
		String json = mapper.writeValueAsString(list);
		super.printOutMsg(response, json);
	}
	
	@RequestMapping(value="/getCatBaike")
	public void getCatBaike(HttpServletResponse response) throws Exception{
		List<TBaike> list = baikeService.getKindOfBaike(1);
		String json = mapper.writeValueAsString(list);
		super.printOutMsg(response, json);
	}
	
	@RequestMapping(value="/getOtherBaike")
	public void getOtherBaike(HttpServletResponse response) throws Exception{
		List<TBaike> list = baikeService.getKindOfBaike(2);
		String json = mapper.writeValueAsString(list);
		super.printOutMsg(response, json);
	}
}
