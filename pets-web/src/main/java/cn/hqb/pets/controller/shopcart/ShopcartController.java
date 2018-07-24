package cn.hqb.pets.controller.shopcart;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
import cn.hqb.pets.pojo.shopcart.TShopcart;
import cn.hqb.pets.pojo.shopcart.TShopcartItem;
import cn.hqb.pets.pojo.user.TUser;
import cn.hqb.pets.service.shopcart.ShopcartService;
import cn.hqb.pets.vo.shopcart.TShopcartItemVo;
import cn.hqb.pets.vo.shopcart.TShopcartVo;

@Controller
@RequestMapping("/shopcart")
public class ShopcartController extends BaseController{
	
	@Autowired
	private ShopcartService shopcartService;
	
	private static ObjectMapper mapper = new ObjectMapper();

	private static Result result = new Result();

	@RequestMapping(value="/toMyShopcart")
	public String toMyShopcart(){
		return "shopcart/shopcart";
	}
	
	/**
	* @throws Exception   
	* @Title: buyNow  
	* @Description: 立刻购买,判断是否登录,有登录就根据userId去查找购物车,
	* 				如果有购物车,检查购物车内是否含有此商品,
	* 				若含有该商品直接修改数量,若没有,则插入该商品
	* @param @param request
	* @param @param response
	* @param @param id 物品ID
	* @param @param count 物品数量
	* @return void 
	* @throws  
	*/ 
	@RequestMapping(value="/buyNow",method= RequestMethod.POST)
	public void buyNow(HttpServletRequest request, HttpServletResponse response, @RequestParam("id") Long id, @RequestParam("count") Long count) throws Exception{
		TUser user = (TUser) request.getSession().getAttribute("user");
		if(null == user){
			result.setCode("100");
			result.setMsg("你还未登录,请先登录!");
		}else{
			TShopcartVo shopcartVo = shopcartService.getShopcartByUserId(user.getId());
			Long cartId = null;
			List<TShopcartItem> itemList = null;
			if(null == shopcartVo){
				TShopcart shopcart = new TShopcart();
				shopcart.setUserId(user.getId());
				shopcart.setStatus((byte)1);
				shopcartService.insertShopcart(shopcart);
				cartId = shopcart.getId();
				itemList = new ArrayList<TShopcartItem>();
			}else{
				cartId = shopcartVo.getCartId();
				itemList = shopcartVo.getItemList();
			}
			//判断购物车是否含有此条目
			TShopcartItem item =  null;
			int i = 0;
			for (TShopcartItem tShopcartItem : itemList) {
				if(id.equals(tShopcartItem.getItemId())){
					item = tShopcartItem;
					item.setCount(tShopcartItem.getCount()+count);
					break;
				}
			}
			if(null == item){
				item = new TShopcartItem();
				item.setCartId(cartId);
				item.setCount(count);
				item.setItemId(id);
				item.setStatus((byte)1);
				i = shopcartService.insertItem(item);
			}else{
				i = shopcartService.updateShopcartItem(item);
			}
			if(i > 0){
				result.setCode("0");
				result.setMsg("添加购物车成功!");
			}else{
				result.setCode("100");
				result.setMsg("添加购物车失败!");
			}
		}
		String json = mapper.writeValueAsString(result);
		super.printOutMsg(response, json);
	}
	
	/**  
	* @Title: getShopcartData  
	* @Description: 返回购物车资料,Layui数据表格
	* @param @param request    
	* @return void 
	* @throws  
	*/ 
	@RequestMapping(value = "/getShopcartData", method = RequestMethod.GET)
	@ResponseBody
	public LayuiTableData getShopcartData(HttpServletRequest request){
		TUser user = (TUser) request.getSession().getAttribute("user");
		LayuiTableData table = new LayuiTableData();
		if(null == user){
			table.setCode("300");
			table.setMsg("您还未登录,请先进行登录!");
			table.setData(new ArrayList());
			table.setCount(0);
			return table;
		}else{ 
			Long userId = user.getId();
			int count = shopcartService.getCountByUserId(userId);
			if(count == 0){
				table.setCode("200");
				table.setMsg("没有数据!");
				table.setData(new ArrayList());
				table.setCount(0);
				return table;
			}
			//转格式
			List<TShopcartItemVo> data = new ArrayList<TShopcartItemVo>();
			TShopcartVo vo = shopcartService.getShopcartByUserId(userId);
			List<TShopcartItem> list = vo.getItemList();
			if(Utils.isListEmpty(list)){
				table.setCode("200");
				table.setMsg("没有数据!");
				table.setData(new ArrayList());
				table.setCount(0);
				return table;
			}
			table.setCount(count);
			table.setCode("0");
			table.setMsg("请求成功!");
			for (TShopcartItem tShopcartItem : list) {
				TShopcartItemVo itemVo = new TShopcartItemVo();
				itemVo.setSciId(tShopcartItem.getId());
				itemVo.setItemId(tShopcartItem.getItemId());
				itemVo.setCount(tShopcartItem.getCount());
				itemVo.setImage(tShopcartItem.getItem().getImage());
				itemVo.setNum(tShopcartItem.getItem().getNum());
				itemVo.setTitle(tShopcartItem.getItem().getTitle());
				itemVo.setStandard(tShopcartItem.getItem().getStandard());
				itemVo.setPrice(tShopcartItem.getItem().getPrice());
				itemVo.setSubTotal(Utils.mul(tShopcartItem.getCount(), tShopcartItem.getItem().getPrice()));
				data.add(itemVo);
			}
			table.setData(data);
			return table;
		}			
	}
	
	@RequestMapping(value="deleteShopcartItem",method= RequestMethod.POST)
	public void deleteShopcartItem(HttpServletResponse response, Long id) throws Exception{
		result.setCode("100");
		result.setMsg("删除失败!");
		int num = shopcartService.deleteShopcartItem(id);
		if(num > 0){
			result.setCode("0");
			result.setMsg("移除成功!");
		}
		String json = mapper.writeValueAsString(result);
		super.printOutMsg(response, json);
	}
	
	@RequestMapping(value="deleteShopcartItemBatch",method= RequestMethod.POST)
	public void deleteShopcartItemBatch(HttpServletResponse response, String ids) throws Exception{
		result.setCode("100");
		result.setMsg("删除失败!");
		int num = shopcartService.deleteShopcartItemBatch(ids);
		if(num > 0){
			result.setCode("0");
			result.setMsg("移除成功!");
		}
		String json = mapper.writeValueAsString(result);
		super.printOutMsg(response, json);
	}
	
	@RequestMapping(value="updateShopcartItem",method= RequestMethod.POST)
	public void updateShopcartItem(HttpServletResponse response, TShopcartItemVo vo) throws Exception{
		result.setCode("100");
		result.setMsg("修改失败!");
		TShopcartItem item = new TShopcartItem();
		item.setId(vo.getSciId());
		item.setCount(vo.getCount());
		int num = shopcartService.updateShopcartItem(item);
		if(num > 0){
			result.setCode("0");
			result.setMsg("修改成功!");
		}
		String json = mapper.writeValueAsString(result);
		super.printOutMsg(response, json);
	}
	
}
