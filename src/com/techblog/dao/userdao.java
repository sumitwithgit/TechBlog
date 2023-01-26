package com.techblog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.techblog.entities.User;
import com.techblog.helper.connectionProvider;

public class userdao
{
	private Connection con;

	public userdao(Connection con) {
		this.con = con;
	}
	
//	save user function
	public boolean saveUser(User user)
	{
		boolean f=false;
		try {
			String q="insert into user(name,email,password,gender,about) values(?,?,?,?,?)";
			PreparedStatement psmt=this.con.prepareStatement(q);
			psmt.setString(1, user.getName());
			psmt.setString(2, user.getEmail());
			psmt.setString(3, user.getPassword());
			psmt.setString(4, user.getGender());
			psmt.setString(5, user.getAbout());
			
			psmt.executeUpdate();
			f=true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}
	
//	function for user login
	public User getUserByEmailAndPassword(String email,String password)
	{
		User user=null;
		String query="select * from user where email=? and password=?";
		try {
			PreparedStatement psmt=con.prepareStatement(query);
			psmt.setString(1, email);
			psmt.setString(2, password);
			
			ResultSet rs=psmt.executeQuery();
			
			if(rs.next()) {
				user =new User();
				user.setId(rs.getInt("id"));
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("email"));
				user.setPassword(rs.getString("password"));
				user.setGender(rs.getString("gender"));
				user.setAbout(rs.getString("about"));
				user.setDatetime(rs.getTimestamp("datetime"));
				user.setProfile(rs.getString("profile"));
				}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return user;
	}


	public boolean updateUser(User user)
	{
		boolean f=false;
		try {
			String q="update user set name=?, password=?, about=?, profile=? where id=?";
			PreparedStatement psmt=con.prepareStatement(q);
			psmt.setString(1, user.getName());
			psmt.setString(2, user.getPassword());
			psmt.setString(3, user.getAbout());
			psmt.setString(4, user.getProfile());
			psmt.setInt(5, user.getId());
			
			psmt.executeUpdate();
			f=true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}
	
	
	
	public User getUserByUserId(int userid)
	{
		User user=new User();
		try {
			String q="select * from user where id=?";
			PreparedStatement psmt=con.prepareStatement(q);
			psmt.setInt(1, userid);
			
			ResultSet rs=psmt.executeQuery();
			
			while(rs.next())
			{
				user.setId(rs.getInt("id"));
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("email"));
				user.setPassword(rs.getString("password"));
				user.setGender(rs.getString("gender"));
				user.setAbout(rs.getString("about"));
				user.setDatetime(rs.getTimestamp("datetime"));
				user.setProfile(rs.getString("profile"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return user;
	}
}
