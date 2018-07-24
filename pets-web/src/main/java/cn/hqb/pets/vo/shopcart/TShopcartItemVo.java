package cn.hqb.pets.vo.shopcart;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;

import cn.hqb.pets.pojo.shopcart.TShopcartItem;

/**  
* @ClassName: TShopcartItemVo  
* @Description: 购物车条目拓展类,用在"我的购物车"
* @author hequanbin  
* @date 2018年2月23日  
*    
*/ 
public class TShopcartItemVo implements Serializable {
			
	private Long sciId;
	
	private Long itemId;
	
	private Long count;
	
	private String image;
	
	private String title;
	
	private Double price;
	
	private String standard;
	
	private Double subTotal;//小计
	
	private Integer num;

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public Long getSciId() {
		return sciId;
	}

	public void setSciId(Long sciId) {
		this.sciId = sciId;
	}

	public Long getItemId() {
		return itemId;
	}

	public void setItemId(Long itemId) {
		this.itemId = itemId;
	}

	public Long getCount() {
		return count;
	}

	public void setCount(Long count) {
		this.count = count;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public String getStandard() {
		return standard;
	}

	public void setStandard(String standard) {
		this.standard = standard;
	}

	public String toString() {
		return "TShopcartItemVo [sciId=" + sciId + ", itemId=" + itemId + ", count=" + count + ", image=" + image
				+ ", title=" + title + ", price=" + price + ", standard=" + standard + "]";
	}
	
	public void setSubTotal(Double subTotal) {
		this.subTotal = subTotal;
	}

	public Double getSubTotal() {
		return subTotal;
	}

}
