package com.techblog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class likedDao 
{
	Connection con;
	
	public likedDao(Connection con) {
		this.con = con;
	}

	public boolean insertLike(int pid,int uid)
	{
		boolean f=false;
		try {
			String q="insert into liked(pid,uid) values(?,?)";
			PreparedStatement psmt=con.prepareStatement(q);
			psmt.setInt(1, pid);
			psmt.setInt(2, uid);
			
			psmt.executeUpdate();
			f=true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}
	
	
	public int countLike(int pid)
	{
		int count=0;
		String q="select count(*) from liked where pid=?";
		try {
			PreparedStatement psmt=con.prepareStatement(q);
			psmt.setInt(1, pid);
			
			ResultSet rs=psmt.executeQuery();
			while(rs.next())
			{
				count=rs.getInt("count(*)");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return count;
	}
	
	
	public boolean isLikedByUser(int pid,int uid)
	{
		boolean f=false;
		try {
			String q="select * from liked where pid=? and uid=?";
			
			PreparedStatement psmt=con.prepareStatement(q);
			psmt.setInt(1, pid);
			psmt.setInt(2, uid);
			
			ResultSet rs=psmt.executeQuery();
			
			if(rs.next())
			{
				f=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return f;
	}
	
	
	
	public boolean deleteLike(int pid,int uid)
	{
		boolean f=false;
		String q="delete from liked where pid=? and uid=?";
		
		try {
			PreparedStatement psmt=con.prepareStatement(q);
			psmt.setInt(1, pid);
			psmt.setInt(2, uid);
			
			psmt.executeUpdate();
			f=true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return f;
	}
}
