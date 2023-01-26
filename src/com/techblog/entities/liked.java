package com.techblog.entities;

public class liked
{
	private int lid;
	private int pid;
	private int uid;
	public liked(int lid, int pid, int uid) {
		this.lid = lid;
		this.pid = pid;
		this.uid = uid;
	}
	public liked(int pid, int uid) {
		this.pid = pid;
		this.uid = uid;
	}
	public liked() {
	}
	public int getLid() {
		return lid;
	}
	public void setLid(int lid) {
		this.lid = lid;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public int getUid() {
		return uid;
	}
	public void setUid(int uid) {
		this.uid = uid;
	}
	
	
	
}
