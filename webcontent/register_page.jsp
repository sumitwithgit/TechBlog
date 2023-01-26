<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page errorPage="Error_page.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register Page</title>
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
	<%@include file="navbar.jsp"%>
	<main class="d-flex align-items-center primary-background"
		style="padding: 40px;">
		<div class=" container">
			<div class="col-md-4 offset-md-4">
				<div class="card">
					<div class="card-header text-center primary-background text-white">
						<span class="fa fa-user-plus fa-3x"></span>
						<h5>Registration Form</h5>
					</div>
					<div class="card-body">
						<form action="registerServlet" method="post" id="regForm">
							<div class="form-group">
								<label for="userName">User Name</label> <input type="text"
									class="form-control" id="userName" name="userName"
									aria-describedby="emailHelp" placeholder="Enter User Name">
							</div>


							<div class="form-group">
								<label for="exampleInputEmail1">Email address</label> <input
									type="email" class="form-control" id="exampleInputEmail1"
									aria-describedby="emailHelp" placeholder="Enter email"
									name="userEmail"> <small id="emailHelp"
									class="form-text text-muted">We'll never share your
									email with anyone else.</small>
							</div>


							<div class="form-group">
								<label for="exampleInputPassword1">Password</label> <input
									type="password" class="form-control" id="exampleInputPassword1"
									placeholder="Password" name="userPassword">
							</div>

							<div class="form-group">
								<label for="gender">Gender</label> &nbsp;&nbsp;&nbsp;&nbsp; <input
									type="radio" name="gender" value="male" id="male"> <label
									for="male">Male</label> &nbsp; <input type="radio"
									name="gender" value="female" id="female"> <label
									for="female">Female</label>
							</div>

							<div class="form-group">
								<label for="about">About</label>
								<textarea rows="3" cols="" name="about" class="form-control"
									placeholder="Write something about yourself"></textarea>
							</div>

							<div class="form-check">
								<input type="checkbox" class="form-check-input" id="Check"
									name="check"> <label class="form-check-label"
									for="Check">Agree Terms And Conditions</label>
							</div>
							<div class="container text-center" id="loader"
								style="display: none;">
								<span class="fa fa-refresh fa-spin fa-3x"></span>
								<h4>Please wait...</h4>

							</div>
							<button id="submit-btn" type="submit"
								class="btn btn-primary mt-2">Submit</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</main>




	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
	<script type="text/javascript" src="js/myscript.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script type="text/javascript">
		 $(document).ready(function() {
			$('#regForm').on('submit',function(event){
				event.preventDefault();
				
				let form=new FormData(this);
				let check=document.getElementById("Check");
				
				$('#submit-btn').hide();
				$('#loader').show();
				
				
				if(check.checked==true)
					{
					
							$.ajax({
								url:"registerServlet",
								type:'post',
								data:form,
								success:function(data, textStatus, jqXHR){
									console.log(data);
									$('#loader').hide();
									$('#submit-btn').show();
									if(data.trim()==='done')
										{
										swal({
											  title: "Registration Successfully!!!",
											  text: "We are Redirecting to Login Page.",
											  icon: "success",
											  button: "Done...!",
											}).then((value)=>{
												window.location="login.jsp"
											});
										}
									else
											{
											swal({
												  title: "Something Went Wrong...!!!Try Again.",
												  text: "We are Redirecting to Registration Page Again.",
												  icon: "warning",
												  buttons: true,
												  dangerMode: true,
												}).then((value)=>{
													window.location="register_page.jsp";
												})
											} 
								},
								error:function(jqXHR, textStatus, errorThrown){
									console.log(jqXHR);
									$('#loader').hide();
									$('#submit-btn').show();
									swal({
										  title: "Something Went Wrong...!!!Try Again.",
										  text: "We are Redirecting to Registration Page Again.",
										  icon: "warning",
										  buttons: true,
										  dangerMode: true,
										}).then((value)=>{
											window.location="register_page.jsp";
										})
								},
								processData:false,
								contentType:false
							})
					}else{
						alert("Please Agree Terms and Conditions...!!!");
						$('#submit-btn').show();
						$('#loader').hide();
						
					}
			})
		});
	</script>


</body>
</html>