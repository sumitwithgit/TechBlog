package com.techblog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.techblog.entities.User;
import com.techblog.entities.categories;
import com.techblog.entities.posts;

public class postdao
{
	Connection con;

	public postdao(Connection con) {
		this.con = con;
	}
	
	public ArrayList<categories> getAllcategories()
	{
		ArrayList<categories> clist=new ArrayList<categories>();
		try {
			String query="SELECT * FROM categories";
			Statement st=this.con.createStatement();
			
			ResultSet rs=st.executeQuery(query);
			while(rs.next())
			{
				categories c = new categories();
				
				int cid=rs.getInt("cid");
				String name=rs.getString("name");
				String description=rs.getString("description");
				
				c.setCid(cid);
				c.setName(name);
				c.setDescription(description);
				
				
				clist.add(c);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return clist;
	}
	
	
	
	public boolean savePost(posts p)
	{
		boolean f=false;
		try {
			String q="insert into posts(pTitle,pContent,pCode,pPic,cid,uid) values(?,?,?,?,?,?)";
			PreparedStatement psmt=con.prepareStatement(q);
			psmt.setString(1,p.getpTitle());
			psmt.setString(2, p.getpContent());
			psmt.setString(3, p.getpCode());
			psmt.setString(4, p.getpPic());
			psmt.setInt(5, p.getCid());
			psmt.setInt(6, p.getUid());
			
			psmt.executeUpdate();
			
			f=true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return f;
	}
	
	
	public ArrayList<posts> getAllPost()
	{
		ArrayList<posts> plist=new ArrayList<posts>();
		try {
			String q="select * from posts order by pid desc";
			Statement st=con.createStatement();
			ResultSet rs=st.executeQuery(q);
			while(rs.next())
			{
				posts p=new posts();
				p.setPid(rs.getInt("pid"));
				p.setpTitle(rs.getString("pTitle"));
				p.setpContent(rs.getString("pContent"));
				p.setpCode(rs.getString("pCode"));
				p.setpPic(rs.getString("pPic"));
				p.setpDate(rs.getTimestamp("pDate"));
				p.setCid(rs.getInt("cid"));
				p.setUid(rs.getInt("uid"));
				
				plist.add(p);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return plist;
	}
	
	
	
	public ArrayList<posts> getPostById(int cid)
	{
		ArrayList<posts> plist=new ArrayList<posts>();
		try {
			String q="select * from posts where cid=?";
			PreparedStatement psmt=con.prepareStatement(q);
			psmt.setInt(1, cid);
			
			ResultSet rs=psmt.executeQuery();
			while(rs.next())
			{
				posts p=new posts();
				p.setPid(rs.getInt("pid"));
				p.setpTitle(rs.getString("pTitle"));
				p.setpContent(rs.getString("pContent"));
				p.setpCode(rs.getString("pCode"));
				p.setpPic(rs.getString("pPic"));
				p.setpDate(rs.getTimestamp("pDate"));
				p.setUid(rs.getInt("uid"));
				
				
				plist.add(p);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return plist;
	}
	
	public posts getPostByPostId(int postId)
	{
		posts post=null;
		String q="select * from posts where pid=?";
		try {
			PreparedStatement psmt=con.prepareStatement(q);
			psmt.setInt(1, postId);
			
			ResultSet rs=psmt.executeQuery();
			while(rs.next())
			{
				post=new posts();
				post.setPid(rs.getInt("pid"));
				post.setpTitle(rs.getString("pTitle"));
				post.setpContent(rs.getString("pContent"));
				post.setpCode(rs.getString("pCode"));
				post.setpPic(rs.getString("pPic"));
				post.setpDate(rs.getTimestamp("pDate"));
				post.setCid(rs.getInt("cid"));
				post.setUid(rs.getInt("uid"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return post;
	}
	
	
	
}
