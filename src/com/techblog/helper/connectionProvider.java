package com.techblog.helper;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class connectionProvider 
{
	private static Connection con;
	public static Connection getConnection()
	{
		try {
			if(con==null)
			{
				Class.forName("com.mysql.cj.jdbc.Driver");
				con=DriverManager.getConnection("jdbc:mysql://localhost:3306/techblog","root","12345678");
			}
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		
		return con;
	}
}
