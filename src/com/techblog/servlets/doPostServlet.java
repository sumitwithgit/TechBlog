package com.techblog.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.techblog.dao.postdao;
import com.techblog.entities.User;
import com.techblog.entities.posts;
import com.techblog.helper.Helper;
import com.techblog.helper.connectionProvider;

/**
 * Servlet implementation class doPostServlet
 */
@WebServlet("/doPostServlet")
@MultipartConfig
public class doPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public doPostServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		int cid=Integer.parseInt(request.getParameter("cid"));
		String title=request.getParameter("pTitle");
		String content=request.getParameter("pContent");
		String code=request.getParameter("pCode");
		Part part=request.getPart("pic");
		String image=part.getSubmittedFileName();
		
		
//		getting current user id
		HttpSession session=request.getSession();
		
		User user=(User) session.getAttribute("currentUser");
		
		posts p=new posts(title, content, code, image, null, cid, user.getId());
		postdao pdao=new postdao(connectionProvider.getConnection());
		if(pdao.savePost(p)) {
			String path = request.getRealPath("/") + "blog_pics" + File.separator + image;
			Helper.saveFile(part.getInputStream(), path);
			out.write("done");
		}else {
			out.write("error");
		}
	}

}
