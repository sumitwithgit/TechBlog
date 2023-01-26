package com.techblog.entities;

public class categories 
{
	private int cid;
	private String name;
	private String description;
	public categories(int cid, String name, String description) {
		this.cid = cid;
		this.name = name;
		this.description = description;
	}
	public categories() {
	}
	public categories(String name, String description) {
		this.name = name;
		this.description = description;
	}
	public int getCid() {
		return cid;
	}
	public void setCid(int cid) {
		this.cid = cid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	
	
	
}
