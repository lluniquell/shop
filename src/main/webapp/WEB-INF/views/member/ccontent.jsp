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
		<table align="center">
			<tr>
				<td>제목</td>
				<td>${cvo.title}</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>${cvo.content}</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="button" value="수정" onclick="location='ccontent_update?id=${cvo.id}'">
					<input type="button" value="삭제" onclick="location='ccontent_del?id=${cvo.id}'">
					
				</td>
			</tr>
		</table>
	
	</section>

</body>
</html>