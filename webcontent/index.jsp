<%@page import="com.techblog.entities.categories"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.techblog.dao.postdao"%>
<%@page import="com.techblog.helper.connectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page errorPage="Error_page.jsp" %>
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
	<jsp:include page="navbar.jsp"></jsp:include>

	<!-- banner -->

	<div class="container-fluid m-0 p-0">
		<div class="jumbotron primary-background banner-background">
			<div class="container text-white">
				<h3 class="display-3">Welcome To TechBlog</h3>
				<p>A programming language is a system of notation for writing
					computer programs.[1] Most programming languages are text-based
					formal languages, but they may also be graphical. They are a kind
					of computer language. The description of a programming language is
					usually split into the two components of syntax (form) and
					semantics (meaning), which are usually defined by a formal
					language. Some languages are defined by a specification document</p>


				<button class="btn btn-outline-light">
					<span class="fa fa-paperclip"></span> Start! Its Free
				</button>
				<a href="login.jsp" class="btn btn-outline-light">
					<span class="fa fa-user-circle fa-spin"></span> Login
				</a>
			</div>
		</div>
	</div>

	<!-- cards -->
	
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