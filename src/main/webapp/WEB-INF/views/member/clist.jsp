<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<section>
	<table width="700" align="center">
		<tr>
			<td>제목</td>
			<td>작성일</td>
			<td>답변여부</td>
		</tr>
		
		<c:forEach items="${clist}" var="cvo">
		<tr>
			<td><a href="ccontent?id=${cvo.id}">${cvo.title}</a></td>
			<td>${cvo.writeday}</td>
			<td></td>
		</tr>
		</c:forEach>
	</table>

</section>

</body>
</html>