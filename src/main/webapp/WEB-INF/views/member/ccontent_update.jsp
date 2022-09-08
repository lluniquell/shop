<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	section{
	width:1000px;
	heigth:500px;
	margin:auto;
	text-align:center;
	margin-top:60px;
	}	
</style>
</head>
<body>
	<section>
		<form method="post" action="ccontent_update_ok">
		<input type="hidden" name="id" value="${cvo.id}">
		<span>${cvo.id}</span>		
		<h2 align="center"> 1:1 상담하기</h2>
		<div><input type="text" name="title" value="${cvo.title}"></div>
		<div><textarea cols="40" name="content">${cvo.content}</textarea></div>
		<div><input type="submit" value="수정"></div>
	</form>
	</section>

</body>
</html>