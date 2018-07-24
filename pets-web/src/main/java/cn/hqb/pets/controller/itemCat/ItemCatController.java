package cn.hqb.pets.controller.itemCat;

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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import cn.hqb.pets.comm.LayUITreeData;
import cn.hqb.pets.comm.LayUIXTreeData;
import cn.hqb.pets.comm.LayuiTableData;
import cn.hqb.pets.comm.Result;
import cn.hqb.pets.controller.BaseController;
import cn.hqb.pets.enums.ResultEnums;
import cn.hqb.pets.po.TItemPo;
import cn.hqb.pets.pojo.item.TItem;
import cn.hqb.pets.pojo.itemCat.TItemCat;
import cn.hqb.pets.service.item.ItemService;
import cn.hqb.pets.service.itemCat.ItemCatService;
import cn.hqb.pets.vo.item.TItemVo;

@Controller
@RequestMapping("/itemCat")
public class ItemCatController extends BaseController{
	
	private static ObjectMapper mapper = new ObjectMapper();

	private static Result result = new Result();
	
	@Autowired
	private ItemCatService itemCatService;
	
	/**
	 * @param response
	 * @throws Exception
	 * 获得所有叶子结点
	 */
	@RequestMapping("/selectLeafCat")
	public void selectLeafCat(HttpServletResponse response) throws Exception{
        List<TItemCat> list = itemCatService.selectLeafCat();
        String result = mapper.writeValueAsString(list);
        super.printOutMsg(response, result);
	}
	
	/** 
     * 根据父ID,得到模块树列表 
     * 最外层,0
	 * @throws Exception 
     */  
	@RequestMapping("/getAllCategories")
    public void getAllTreeNodesByParentId(Long parentId, HttpServletResponse response) throws Exception{  
        List<TItemCat> categories = itemCatService.getCatByParentId(parentId); //通过父ID,得到下面的数据节点集合  
        List<LayUITreeData> treeDatas = null;  
        if(null != categories && categories.size() > 0){  
        	treeDatas = new ArrayList<LayUITreeData>();  
            for (TItemCat category : categories) {  
            	LayUITreeData treeData = getTreeNodeByModuleNew(category); //分别得到每个节点下的子节点集合  
                treeDatas.add(treeData);  
            }  
        }  
        String json = mapper.writeValueAsString(treeDatas);
        super.printOutMsg(response, json);
    }  
	
    /** 
     * 递归模块树 
     * @param module 
     * @return 
     */  
    public LayUITreeData getTreeNodeByModuleNew(TItemCat tItemCat){  
    	LayUITreeData treeData = new LayUITreeData();  
    	treeData.setId(tItemCat.getId());
    	treeData.setName(tItemCat.getName());
    	treeData.setSortOrder(tItemCat.getSortOrder());
    	treeData.setSpread(true);
    	treeData.setIsParent(tItemCat.getIsParent());
    	treeData.setParentId(tItemCat.getParentId());
          
        List<TItemCat> categories = itemCatService.getCatByParentId(tItemCat.getId());   //得到子节点集合  
        List<LayUITreeData> treeDatas = new ArrayList<LayUITreeData>();  
        for (TItemCat category : categories) {
        	LayUITreeData node = getTreeNodeByModuleNew(category);
        	treeDatas.add(node);
		}
        treeData.setChildren(treeDatas);//添加封装好数据的子节点集合  
        return treeData;  
    }  
    
	@RequestMapping(value= "editItemCat", method= RequestMethod.POST)
	public void editItemCat(@RequestBody TItemCat tItemCat,HttpServletResponse response) throws Exception{
		result.setCode(ResultEnums.ERROR);
		result.setMsg("修改类目失败");
		if(null != tItemCat){
			int num = itemCatService.editItemCatById(tItemCat);
			if(num > 0){
				result.setCode(ResultEnums.SUCCESS);
				result.setMsg("修改类目成功");
			}
		}
		String json = mapper.writeValueAsString(result);
		super.printOutMsg(response, json);
	}
	
	/**
	 * @param tItemCat
	 * @param response
	 * 在某个ID下插入一个目录,这个新目录的ID是自动生成,而传进来的ID则作为parentId
	 * 注意:isParent状态要更新
	 * @throws Exception 
	 */
	@RequestMapping(value= "addItemCat", method= RequestMethod.POST)
	public void addItemCat(@RequestBody TItemCat tItemCat,HttpServletResponse response) throws Exception{
		if(null == tItemCat){
			result.setCode(ResultEnums.ERROR);
			result.setMsg("插入类目失败");
		}else{
			int num = itemCatService.insertItemCatByParentId(tItemCat);
			if(num > 0){
				//成功插入新类目的话,检查父类目的isParent状态,并修改
				if(!tItemCat.getIsParent()){
					TItemCat itemCat = itemCatService.getItemCatById(tItemCat.getId());
					TItemCat newItemCat = itemCat;
					newItemCat.setIsParent(true);
					int num2 = itemCatService.editItemCatById(newItemCat);
					if(num2 > 0){
						result.setCode(ResultEnums.SUCCESS);
						result.setMsg("插入类目成功");
					}
				}
			}
		}
		String json = mapper.writeValueAsString(result);
		super.printOutMsg(response, json);
	}
	
	@RequestMapping(value= "deleteItemCat", method= RequestMethod.POST)
	public void deleteItemCat(@RequestBody TItemCat tItemCat,HttpServletResponse response) throws Exception{
		if(null == tItemCat){
			result.setCode(ResultEnums.ERROR);
			result.setMsg("删除类目失败");
		}else{
			int num = itemCatService.deleteItemCat(tItemCat);
			if(num > 0){
				result.setCode(ResultEnums.SUCCESS);
				result.setMsg("删除类目成功");
			}
		}
		String json = mapper.writeValueAsString(result);
		super.printOutMsg(response, json);
	}
	
	/**
	 * @throws JsonProcessingException   
	* @Title: getFirstCat  
	* @Description: 获得所有一级目录,用于显示总导航
	* @param @param response    
	* @return void 
	* @throws  
	*/ 
	@RequestMapping(value="getFirstCat")
	public void getFirstCat(HttpServletResponse response) throws JsonProcessingException{
		List<TItemCat> list = itemCatService.getFirstCat();
		String json = mapper.writeValueAsString(list);
		super.printOutMsg(response, json);
	}
	
	/** 
     * 根据父ID,菜单用
     * 最外层,0
	 * @throws Exception 
     */  
	@RequestMapping("/getAllCategoriesNew")
    public void getAllCategoriesNew( HttpServletResponse response) throws Exception{  
        List<TItemCat> categories = itemCatService.getCatByParentId((long) 1); //通过父ID,得到下面的数据节点集合  
        StringBuffer str = new StringBuffer();
        if(null != categories && categories.size() > 0){  
            for (TItemCat category : categories) {  
            	str.append("<li class=\"layui-nav-item\">");
            	str.append("<a href=\"javascript:;\">").append(category.getName()).append("</a>");
            	str.append("<dl class=\"layui-nav-child\">");
            	str.append(getTreeNodeByModuleNewForCat(category)); //分别得到每个节点下的子节点集合  
            	str.append("</dl>");
            	str.append("</li>");
            }  
        } 
        String json = mapper.writeValueAsString(str);
        super.printOutMsg(response, json);
    }  
	
	/** 
     * 递归模块树 
     * @param module 
     * @return 
     */  
    public StringBuffer getTreeNodeByModuleNewForCat(TItemCat tItemCat){  
    	StringBuffer str = new StringBuffer();
        List<TItemCat> categories = itemCatService.getCatByParentId(tItemCat.getId());   //得到子节点集合  
        for (TItemCat category : categories) {
        	str.append("<dd><a href=\"/pets-web/item/getItemListByCat?cid=").append(category.getId()).append("\">");
        	str.append(category.getName());
        	str.append("</a></dd>");
        	StringBuffer strBuffer = getTreeNodeByModuleNewForCat(category);
        	str.append(strBuffer);
		}
        return str;  
    }  
}