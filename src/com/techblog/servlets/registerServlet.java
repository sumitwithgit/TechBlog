package com.techblog.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.techblog.dao.userdao;
import com.techblog.entities.User;
import com.techblog.helper.connectionProvider;

/**
 * Servlet implementation class registerServlet
 */
@WebServlet("/registerServlet")
@MultipartConfig
public class registerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public registerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		
		String checkbox=request.getParameter("check");
		if(checkbox==null)
		{
			out.write("<h1>Please check terms and conditions.</h1>");
		}else
		{
			String name=request.getParameter("userName");
			String email=request.getParameter("userEmail");
			String password=request.getParameter("userPassword");
			String gender=request.getParameter("gender");
			String about=request.getParameter("about");
			
//			out.write("Name : "+name+""
//					+ "email : "+email+""
//					+ "Password : "+password+""
//					+ "gender : "+gender+""
//					+ "about : "+about+"");
			
			//create a user class object
			User user=new User(name, email, password, gender, about);
			
		
			
			//create a userDao object
			userdao udao=new userdao(connectionProvider.getConnection());
			if(udao.saveUser(user))
			{
				out.write("done");
			}else
			{
				out.write("something went wroong..");
			}
		}
	}

}
