package cn.hqb.pets.controller.item;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import cn.hqb.pets.comm.LayuiTableData;
import cn.hqb.pets.comm.Result;
import cn.hqb.pets.controller.BaseController;
import cn.hqb.pets.po.TItemPo;
import cn.hqb.pets.pojo.item.TItem;
import cn.hqb.pets.pojo.itemCat.TItemCat;
import cn.hqb.pets.service.item.ItemService;
import cn.hqb.pets.service.itemCat.ItemCatService;
import cn.hqb.pets.vo.item.TItemVo;

@Controller
@RequestMapping("/item")
public class ItemController extends BaseController{

	@Autowired
	private ItemService itemService;
	@Autowired
	private ItemCatService itemCatService;
	
	private static ObjectMapper mapper = new ObjectMapper();

	private static Result result = new Result();
	
	@RequestMapping("/itemList")
	public String getItemList(){
		return "admin/itemList";
	}
	
	@RequestMapping("/selectLeafCat")
	public void selectLeafCat(HttpServletResponse response) throws Exception{
        List<TItemCat> list = itemCatService.selectLeafCat();
        String result = mapper.writeValueAsString(list);
        super.printOutMsg(response, result);
	}
	
	@RequestMapping(value = "/addItem",method = RequestMethod.POST)
	public void addItem(@RequestBody TItem item, HttpServletResponse response) throws JsonProcessingException{        
		int num = itemService.insertItem(item);
		if(num > 0){
			result.setCode("0");
			result.setMsg("商品插入成功");
		} else {
			result.setCode("100");
			result.setMsg("商品插入失败");
		}
		String resultJson = mapper.writeValueAsString(result);
		super.printOutMsg(response, resultJson);
	}
	
	@RequestMapping(value="/uploadImage",method = RequestMethod.POST)
	@ResponseBody
	public Map uploadImage (@RequestParam("file") MultipartFile file,HttpServletRequest request) throws IllegalStateException, IOException{
		Map<String, Object> res = new HashMap<>();
		if (!file.isEmpty()) {
		    //上传文件路径
	        String path = "D:/EclipseSpringWorkSpace/pets-web/src/main/webapp/images/items";  
			//上传文件名
			StringBuffer name = new StringBuffer();
			String uuid = UUID.randomUUID().toString().replaceAll("-","");  
			name.append(uuid);
			String contentType=file.getContentType();
			String imageName=contentType.substring(contentType.indexOf("/")+1);  //获得文件后缀名称  
			name.append(".");
			name.append(imageName);
			File filepath = new File(path, name.toString());
			//判断路径是否存在，没有就创建一个
			if (!filepath.getParentFile().exists()) {
			    filepath.getParentFile().mkdirs();
			}
			
			//将上传文件保存到一个目标文档中
			File file1 = new File(path + File.separator + name);
			file.transferTo(file1);
			System.out.println(file1.getName());
			StringBuffer finalName = new StringBuffer();
			finalName.append("/items/").append(file1.getName());
			//返回的是一个url对象
			res.put("code", 0);
			res.put("url", finalName);
			return res;
		} else {
			res.put("code", 1);
		    return res;
		}	
	}
	
	@RequestMapping(value = "/getItemList")
	public void getItemList(HttpServletResponse response, TItemVo vo) throws Exception{
		LayuiTableData ltb = itemService.getItemList(vo);
		String json = mapper.writeValueAsString(ltb);
		super.printOutMsg(response, json);
	}
	
	@RequestMapping(value = "/editItem", method = RequestMethod.POST)
	public void editItem(@RequestBody TItem item,HttpServletResponse response) throws Exception{
		int num = itemService.updateItem(item);
		if(num > 0){
			result.setCode("0");
			result.setMsg("商品更新成功");
		} else {
			result.setCode("100");
			result.setMsg("商品更新失败");
		}
		String resultJson = mapper.writeValueAsString(result);
		super.printOutMsg(response, resultJson);
	}
	
	@RequestMapping(value = "/deleteItem",method = RequestMethod.POST)
	public void deleteItem(Long id, HttpServletResponse response) throws Exception {
		if( null == id){
			result.setCode("200");
			result.setMsg("错误!");
		}else{
			int num = itemService.deleteItem(id);
			if(num > 0){
				result.setCode("0");
				result.setMsg("商品删除成功");
			} else {
				result.setCode("100");
				result.setMsg("商品删除失败");
			}
		}
		String resultJson = mapper.writeValueAsString(result);
		super.printOutMsg(response, resultJson);
	}
	
	/**
	 * @throws Exception   
	* @Title: getNewestItems  
	* @Description: 获得最新的8个商品
	* @param @param response    
	* @return void 
	* @throws  
	*/ 
	@RequestMapping(value="getNewestItems")
	public void getNewestItems(HttpServletResponse response) throws Exception{
		List<TItem> list = itemService.getNewestItems();
		String json = mapper.writeValueAsString(list);
		super.printOutMsg(response, json);
	}
	
	/**  
	* @Title: showItemDetail  
	* @Description: 查看商品详情
	* @param @param id
	* @param @return    
	* @return TItem 
	* @throws  
	*/ 
	@RequestMapping(value = "showItemDetail")
	public String showItemDetail(Model model, @RequestParam(value="id", required=true) Long id){
		if(null == id){
			return null;
		}
		TItem item = itemService.getItemById(id);
		model.addAttribute("item", item);
		return "item/itemDetail";
	}
	
	@RequestMapping(value = "/getItemListNew")
	public void getItemListNew(HttpServletResponse response) throws Exception{
		List<TItem> list = itemService.getItemListNew();
		String json = mapper.writeValueAsString(list);
		super.printOutMsg(response, json);
	}
	
	/**
	 * @throws Exception   
	* @Title: getNewestItems  
	* @Description: 获得某个类目下的商品
	* @param @param response    
	* @return void 
	* @throws  
	*/ 
	@RequestMapping(value="getItemListByCat")
	public String getItemListByCat(Model model, TItemVo vo) throws Exception{
		model.addAttribute("cid", vo.getCid());
		return "item/itemList";
	}
	
	/**
	 * @throws Exception   
	* @Title: getNewestItems  
	* @Description:加载某个类目下的商品
	* @param @param response    
	* @return void 
	* @throws  
	*/ 
	@RequestMapping(value="loadItemListByCat")
	public void loadItemListByCat(HttpServletResponse response, @RequestBody TItemVo vo) throws Exception{
		List<TItemPo> list = itemService.getItemsByCatId(vo);
		List<String> brandList = new ArrayList<String>();
		List<String> newList = new  ArrayList<String>(); 
		Map map = new HashMap();
		map.put("list", list);
		map.put("cName", list.get(0).getcName());
		for (TItemPo tItemPo : list) {
			brandList.add(tItemPo.getBrand());
		}
		for (String brand:brandList) {
            if(!newList.contains(brand)){
                newList.add(brand);
            }
        }
		map.put("brandList", newList);
		String json = mapper.writeValueAsString(map);
		super.printOutMsg(response, json);
	}
	
}