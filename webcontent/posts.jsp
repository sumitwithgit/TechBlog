<%@page import="com.techblog.dao.likedDao"%>
<%@page import="com.techblog.entities.posts"%>
<%@page import="java.util.List"%>
<%@page import="com.techblog.helper.connectionProvider"%>
<%@page import="com.techblog.dao.postdao"%>
<div class="row">
	<%
	postdao pdao = new postdao(connectionProvider.getConnection());
	int cid = Integer.parseInt(request.getParameter("cid"));

	List<posts> post = null;
	if (cid == 0) {
		post = pdao.getAllPost();
	} else {
		post = pdao.getPostById(cid);
	}
	if(post.size()==0)
	{
		out.write("<h3 class='display-3 text-center'>No Post in this category.</h3>");
		return;
	}
	for (posts p : post) {
	%>
	<div class="col-md-6 mt-2">
		<div class="card" >
			<img class="card-img-top d-flex" src="blog_pics/<%=p.getpPic()%>"
				alt="Card image cap" style="object-fit: cover; height: 300px;">
			<div class="card-body">
				<b class="card-title"><%=p.getpTitle()%></b>
				<p class="card-text"><%=p.getpContent()%></p>
			</div>
			<div class="card-footer primary-background text-center">
						
				<a href="#" class="btn btn-outline-light"><i class="fa fa-thumbs-o-up"></i><span class="likeCounter"> 10</span></a>
				<a href="viewFullPost.jsp?post_id=<%=p.getPid() %>" class="btn btn-outline-light">Read More</a>
				<a href="#" class="btn btn-outline-light"><i class="fa fa-comment-o"></i> 20</a>
			</div>
		</div>
	</div>
	<%
	}
	%>
</div>