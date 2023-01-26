<%@page import="com.techblog.dao.likedDao"%>
<%@page import="com.techblog.dao.userdao"%>
<%@page import="com.techblog.servlets.Message"%>
<%@page import="com.techblog.entities.categories"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.techblog.entities.posts"%>
<%@page import="com.techblog.helper.connectionProvider"%>
<%@page import="com.techblog.dao.postdao"%>
<%@page import="com.techblog.entities.User"%>
<%@page errorPage="Error_page.jsp"%>
<%
User user = (User) session.getAttribute("currentUser");
if (user == null) {
	response.sendRedirect("login.jsp");
}
%>
<%
int postId = Integer.parseInt(request.getParameter("post_id"));
postdao postdao = new postdao(connectionProvider.getConnection());
posts posts = postdao.getPostByPostId(postId);
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%=posts.getpTitle()%></title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css">
<link href="css/mystyle.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style type="text/css">
.banner-background {
	clip-path: polygon(50% 0%, 100% 0, 100% 86%, 55% 100%, 25% 88%, 0 100%, 0 0);
}
.postCode{
	font-size: 25px;
}
.postContent{
	font-size: 30px;
	font-weight: 400;
}
</style>
</head>
<body>
	<!-- navbar -->
	<nav
		class="navbar navbar-expand-lg navbar-dark primary-background mynavbar">
		<a class="navbar-brand" href="#"> <span class="fa fa-500px"></span>
			Lets Code
		</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="nav-link"
					href="index.jsp"><span class="fa fa-modx"></span> TechBlog <span
						class="sr-only">(current)</span> </a></li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"><span class="	fa fa-stack-overflow"></span>
						Programming Language </a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="#">Java Programming</a> <a
							class="dropdown-item" href="#">Python Programming</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="#">Web Developer</a>
					</div></li>
				<li class="nav-item"><a class="nav-link" href="#"><span
						class="fa fa-wechat"></span> Contact</a></li>
				<li class="nav-item"><a class="nav-link" type="button" href="#"
					data-toggle="modal" data-target="#do-post"><span
						class="fa fa-eyedropper"></span> Do Post</a></li>
			</ul>
			<a href="#" class="btn btn-outline-light" data-toggle="modal"
				data-target="#exampleModal"><span class="fa fa-user-circle"></span>
				<%=user.getName()%></a> &nbsp;&nbsp; <a href="logoutServlet"
				class="btn btn-outline-light"> <span class="fa fa-sign-out"></span>
				Logout
			</a>
		</div>
	</nav>
	<!-- navbar end -->


	<!-- main content of body -->



	<div class="container mt-3">
		<div class="row">
			<div class="col-md-6 offset-md-3">
				<div class="card">
					<div class="card-header primary-background text-white">
						<h4><%=posts.getpTitle()%></h4>
					</div>
					<div class="card-body">
						<img class="card-img-top" src="blog_pics/<%=posts.getpPic()%>"
							alt="Card image cap" style="height: 400px;object-fit:cover;"/>
						<div class="row my-3">
							<div class="col-md-7">
							<%
								userdao ud=new userdao(connectionProvider.getConnection());
								User u=(User)ud.getUserByUserId(posts.getUid());
							%>
								<p><a href="#!"><%=u.getName() %></a> has posted.</p>
							</div>
							<div class="col-md-5">
								<p><%=posts.getpDate().toLocaleString() %></p>
							</div>
						</div>
						<p class="postContent"><%=posts.getpContent()%></p>
						<div class="postCode">
							<pre><%=posts.getpCode()%></pre>
						</div>
					</div>
					<div class="card-footer primary-background text-center">
						
						<a href="#"  class="btn btn-outline-light">
						<i class="fa fa-thumbs-o-up"></i><span class="likeCounter"> 10</span></a>
						
						<a href="#" class="btn btn-outline-light"><i class="fa fa-comment-o"></i> 20</a>
					</div>
				</div>
			</div>

		</div>
	</div>

	<!-- end of the body -->



	<!-- Profile Modal -->

	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header primary-background text-white">
					<h5 class="modal-title" id="exampleModalLabel">Welcome,
						TechBlog</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="container text-center">
						<img alt="defaultpic" src="pics/<%=user.getProfile()%>"
							style="border-radius: 50%; width: 150px; height: 150px;">
						<h5 class="modal-title" id="exampleModalLabel"><%=user.getName()%></h5>
						<br>
						<div class="profile-detail">
							<table class="table table-striped">
								<tbody>
									<tr>
										<th scope="row">User ID :</th>
										<td><%=user.getId()%></td>
									</tr>
									<tr>
										<th scope="row">Name :</th>
										<td><%=user.getName().toUpperCase()%></td>
									</tr>
									<tr>
										<th scope="row">Email :</th>
										<td><%=user.getEmail()%></td>
									</tr>
									<tr>
										<th scope="row">Gender :</th>
										<td><%=user.getGender().toUpperCase()%></td>
									</tr>
									<tr>
										<th scope="row">Status :</th>
										<td><%=user.getAbout()%></td>
									</tr>
									<tr>
										<th scope="row">Registered :</th>
										<td><%=user.getDatetime()%></td>
									</tr>
								</tbody>
							</table>
						</div>


						<!-- profile edit -->
						<div class="profile-edit" style="display: none;">
							<h5>You Can Edit Now...</h5>
							<form action="editServlet" method="post"
								enctype="multipart/form-data">
								<table class="table">
									<tr>
										<td>ID :</td>
										<td><%=user.getId()%></td>
									</tr>
									<tr>
										<td>Email :</td>
										<td><%=user.getEmail()%></td>
									</tr>
									<tr>
										<td>Name :</td>
										<td><input type="text" value="<%=user.getName()%>"
											class="form-control" name="userName" /></td>
									</tr>
									<tr>
										<td>Password :</td>
										<td><input type="password"
											value="<%=user.getPassword()%>" class="form-control"
											name="userPassword" /></td>
									</tr>
									<tr>
										<td>Gender :</td>
										<td><%=user.getGender().toUpperCase()%></td>
									</tr>
									<tr>
										<td>Status :</td>
										<td><textarea name="about" class="form-control" rows="3"><%=user.getAbout()%></textarea></td>
									</tr>
									<tr>
										<td>Change Profile :</td>
										<td><input type="file" name="newPic" class="form-control" /></td>
									</tr>
								</table>
								<div class="container">
									<button class="btn btn-outline-primary">Save</button>
								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<button id="edit-profile-btn" type="button" class="btn btn-primary">Edit</button>
				</div>
			</div>
		</div>
	</div>

	<!-- end of the modal -->

	<!-- do post modal -->

	<!-- Modal -->
	<div class="modal fade" id="do-post" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header primary-background text-white">
					<h5 class="modal-title" id="exampleModalLabel">Provide Details</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="doPostServlet" method="post" id="doPost"
						enctype="multipart/form-data">

						<div class="form-group">
							<select class="form-control" name="cid">
								<option selected="selected" disabled="disabled">---Select
									Category---</option>
								<%
								postdao pdao = new postdao(connectionProvider.getConnection());
								ArrayList<categories> list = pdao.getAllcategories();
								for (categories c : list) {
								%>
								<option value="<%=c.getCid()%>"><%=c.getName()%></option>
								<%
								}
								%>
							</select>
						</div>


						<div class="form-group">
							<input type="text" class="form-control"
								placeholder="Enter Post Title" name="pTitle" />
						</div>
						<div class="form-group">
							<textarea rows="4" class="form-control"
								placeholder="Enter Content" name="pContent"></textarea>
						</div>
						<div class="form-group">
							<textarea rows="4" class="form-control"
								placeholder="Enter Code(if any)" name="pCode"></textarea>
						</div>
						<div class="form-group">
							<label for="file">Select Pic : </label> <input type="file"
								name="pic" id="file" />
						</div>
						<div class="container text-center">
							<button type="submit" class="btn btn-outline-primary">Post</button>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-outline-secondary"
						data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>



	<!-- do post modal end -->

	<%
	Message m = (Message) session.getAttribute("msg");
	if (m != null) {
	%>
	<div class="alert <%=m.getCssClass()%>" role="alert"><%=m.getContent()%></div>


	<%
	session.removeAttribute("msg");
	}
	%>




	<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/myscript.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

	<script type="text/javascript">
		$(document).ready(function() {
			let editStatus = false;

			$('#edit-profile-btn').click(function() {
				if (editStatus == false) {
					$('.profile-detail').hide();
					$('.profile-edit').show();
					editStatus = true;
					$(this).text("Back");
				} else {
					$('.profile-detail').show();
					$('.profile-edit').hide();
					editStatus = false;
					$(this).text("Edit");
				}
			})
		})
	</script>

	<!-- do post -->
	<script type="text/javascript">
		$(document).ready(function(){
			$('#doPost').on('submit',function(event){
				event.preventDefault();
				console.log("you have submitted ..............")
				let form=new FormData(this);
				
				$.ajax({
					url:"doPostServlet",
					type:"post",
					data:form,
					success:function(data,textStatus,jqXHR){
						console.log(data);
						if(data.trim()==='done')
						{
						swal({
							  title: "Uploaded Successfully!!!",
							  text: "ThankYou.",
							  icon: "success",
							  button: "Done...!",
							}).then((value)=>{
								window.location="profile.jsp"
							});
						}
					else
							{
							swal({
								  title: "Something Went Wrong...!!!Try Again.",
								  text: "You Should Try Again.",
								  icon: "warning",
								  buttons: true,
								  dangerMode: true,
								}).then((value)=>{
									window.location="profile.jsp";
								})
							}
					},
					error:function(jqXHR,textStatus,errorThrown){
						console.log(data);
						swal({
							  title: "Something Went Wrong...!!!Try Again.",
							  text: "You Should Try Again.",
							  icon: "warning",
							  buttons: true,
							  dangerMode: true,
							}).then((value)=>{
								window.location="profile.jsp";
							})
					},
					processData:false,
					contentType:false
				})
				
			})
		});
		
	</script>




</body>
</html>