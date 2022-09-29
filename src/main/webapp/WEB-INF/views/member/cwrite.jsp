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
	
	input{
	width:304px;
	}
	
</style>
</head>
<body>
	<section>
		<form method="post" action="cwrite_ok">
		<h2 align="center"> 1:1 상담하기</h2>
		<div><input type="text" name="title" placeholder="제목"></div><br>
		<div><textarea cols="40" rows="5" name="content"></textarea></div><p>
		<div><input type="submit" value="문의"></div><br><p>
	</form>
	</section>

</body>
</html>