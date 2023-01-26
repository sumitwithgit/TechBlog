<%@page import="com.techblog.entities.categories"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.techblog.helper.connectionProvider"%>
<%@page import="com.techblog.dao.postdao"%>
<%@page import="com.techblog.servlets.Message"%>
<%@page import="com.techblog.entities.User"%>
<%@page errorPage="Error_page.jsp"%>
<%
User user = (User) session.getAttribute("currentUser");
if (user == null) {
	response.sendRedirect("login.jsp");
}
%>



<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css">
<link href="css/mystyle.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style type="text/css">
.banner-background {
	clip-path: polygon(50% 0%, 100% 0, 100% 86%, 55% 100%, 25% 88%, 0 100%, 0 0);
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
				
				<li class="nav-item active" ><a class="nav-link" type="button" href="#"
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


	<main>
		<div class="container ">
			<div class="row mt-4">
				<div class="col-md-4">
					<div class="list-group">

						<a href="#" onclick="getPost(0,this)"
							class="list-group-item list-group-item-action active c-link">All
							Posts </a>
						<%
						postdao p = new postdao(connectionProvider.getConnection());
						ArrayList<categories> clist = p.getAllcategories();
						for (categories cc : clist) {
						%>
						<a href="#" onclick="getPost(<%=cc.getCid()%>,this)"
							class="list-group-item list-group-item-action c-link"><%=cc.getName()%></a>
						<%
						}
						%>
					</div>
				</div>
				<div class="col-md-8">
					<div class="container text-center" id="loader">
						<i class="fa fa-refresh fa-4x fa-spin"></i>
						<h3>Loading...</h3>
					</div>
					<div class="container-fluid" id="showPost"></div>
				</div>
			</div>
		</div>
	</main>



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


	<!-- loading post using ajax -->
	<script type="text/javascript">
		function getPost(catId,temp){
			$(".c-link").removeClass('active');
			
			
			$.ajax({
				url:"posts.jsp",
				data:{cid:catId},
				success:function(data, textStatus, jqHXR){
					$("#loader").hide();
					$("#showPost").html(data);
					$(temp).addClass('active');
				}
			})
		}
	
		$(document).ready(function(){
			let allPostRef=$('.c-link')[0];
			getPost(0,allPostRef);
		});	
	</script>


</body>
</html>