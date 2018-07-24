package cn.hqb.pets.pojo.baike;

import java.io.Serializable;
import java.util.Date;

import org.apache.ibatis.type.Alias;

public class TBaike implements Serializable {

	private Long id;
	
	private String name;
	
	private String temp;
	
	private String original;
	
	private String illness;
	
	private String lifetime;
	
	private String price;
	
	private String typeArticle;
	
	private String tempArticle;
	
	private String image;
	
	private Integer cid;

    private Integer status;

    private Date created;

    private Date updated;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTemp() {
		return temp;
	}

	public void setTemp(String temp) {
		this.temp = temp;
	}

	public String getOriginal() {
		return original;
	}

	public void setOriginal(String original) {
		this.original = original;
	}

	public String getIllness() {
		return illness;
	}

	public void setIllness(String illness) {
		this.illness = illness;
	}

	public String getLifetime() {
		return lifetime;
	}

	public void setLifetime(String lifetime) {
		this.lifetime = lifetime;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getTypeArticle() {
		return typeArticle;
	}

	public void setTypeArticle(String typeArticle) {
		this.typeArticle = typeArticle;
	}

	public String getTempArticle() {
		return tempArticle;
	}

	public void setTempArticle(String tempArticle) {
		this.tempArticle = tempArticle;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public Integer getCid() {
		return cid;
	}

	public void setCid(Integer cid) {
		this.cid = cid;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Date getCreated() {
		return created;
	}

	public void setCreated(Date created) {
		this.created = created;
	}

	public Date getUpdated() {
		return updated;
	}

	public void setUpdated(Date updated) {
		this.updated = updated;
	}

}
