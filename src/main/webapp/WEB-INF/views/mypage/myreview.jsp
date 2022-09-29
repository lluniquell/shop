<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
 <style>
   section {
     width:1000px;
     margin:auto;
     margin-top:70px;
     margin-bottom:80px;
   }
   
   section table caption {
     text-align:left;
   }
   section table th {
     border-top:2px solid #cccccc;
     border-bottom:1px solid #cccccc;
   }
   section table td {
     border-bottom:1px solid #cccccc;
   }
   section table tr:last-child td {
     border-bottom:2px solid #cccccc;
   }
 </style>
</head>
<body>
   <section>
     <table width="900" align="center" cellspacing="0">
       <caption> <h3> 나의 상품평 </h3> </caption>
       <tr height="60">
        <th> 상 품 </th>
        <th> 별 점 </th>  
        <th> 한줄 평 </th>
        <th> 작성일자 </th>  
        <th> 수정/삭제 </th>
       </tr>
      <c:forEach items="${rlist}" var="rvo">
       <tr align="center" height="70">
        <td>  
          ${rvo.ptitle}<br>
          <img src="../resources/img/${rvo.pimg}" width="50" height="50">
        </td>
        <td> 
            <c:forEach begin="1" end="${rvo.star}">
             <img src="../resources/main/star1.png" width="15">
            </c:forEach>
            <c:forEach begin="1" end="${5-rvo.star}">
             <img src="../resources/main/star2.png" width="15">
            </c:forEach>
        </td>
        <td> ${rvo.title} </td>
        <td> ${rvo.writeday} </td>
        <td>
          <input type="button" value="수정하기" onclick="location='review_update?id=${rvo.id}'">
          <input type="button" value="삭제하기" onclick="location='review_del?id=${rvo.id}&gid=${rvo.gid}'">
        </td> 
       </tr>      
      </c:forEach>
     </table>
   </section>
</body>
</html>







