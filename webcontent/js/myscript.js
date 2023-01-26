function doLike(pid,uid){
	console.log(pid+" "+uid);
	const d={
		uid:uid,
		pid:pid,
		operation:'like'
	}
	
	$.ajax({
		url:"likeServlet",
		data:d,
		success:function(data, textStatus, jqXHR){
			console.log(data);
			if(data.trim=='true')
			{
				let c=$(".likeCounter").html();
				c++;
				$('.likeCounter').html(c);
			}
		},
		error:function(jqXHR, textStatus, errorThrown){
			console.log(data);
		}
	})
}