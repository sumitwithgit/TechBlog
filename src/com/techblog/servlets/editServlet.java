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

import org.apache.tomcat.util.http.fileupload.FileItem;

import com.techblog.dao.userdao;
import com.techblog.entities.User;
import com.techblog.helper.Helper;
import com.techblog.helper.connectionProvider;

/**
 * Servlet implementation class editServlet
 */
@WebServlet("/editServlet")
@MultipartConfig
public class editServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public editServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		String name = request.getParameter("userName");
		String password = request.getParameter("userPassword");
		String about = request.getParameter("about");

		Part part = request.getPart("newPic");
		String imageName = part.getSubmittedFileName();

		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("currentUser");
		user.setName(name);
		user.setPassword(password);
		user.setAbout(about);
		String oldpath = user.getProfile();
		user.setProfile(imageName);

		userdao udao = new userdao(connectionProvider.getConnection());
		if (udao.updateUser(user)) {

			String path = request.getRealPath("/") + "pics" + File.separator + imageName;
			boolean f;
			f = Helper.saveFile(part.getInputStream(), path);
			String pathOldFile = request.getRealPath("/") + "pics" + File.separator + oldpath;

			if (!pathOldFile.equals("default.png")) {
				Helper.deleteFile(pathOldFile);
			}
			if (f) {
				out.write("update successfully");
				Message msg = new Message("Profile Updated", "success", "alert-success");
				session.setAttribute("msg", msg);
			} else {
				out.write("file not saved.");
				Message msg = new Message("Something Went Wrong ! Try Again", "error", "alert-danger");
				session.setAttribute("msg", msg);
			}
		} else {
			out.write("something went wrong...");
			Message msg = new Message("Something Went Wrong ! Try Again", "error", "alert-danger");
			session.setAttribute("msg", msg);
		}
		response.sendRedirect("profile.jsp");
	}

}
