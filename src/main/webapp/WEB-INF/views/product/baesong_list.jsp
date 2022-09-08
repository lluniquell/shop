<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
 <style>
   #left { /* 수정 */
     float:left;
     width:50px;
     height:22px;
     border:1px solid #cccccc;
     text-align:center;
     color:blue;
     cursor:pointer;
   }
   #right { /* 선택 */
     float:right;
     width:50px;
     height:22px;
     border:1px solid blue;
     text-align:center;
     color:white;
     background:blue;
     cursor:pointer;
   }
   .outer {
     width:260px;
     height:130px;
     border:1px solid blue;
     padding:5px;
     margin-top:10px;
   }
   #chuga {
     width:200px;
     height:25px;
     border:1px solid blue;
     text-align:center;
     margin-left:30px;
     margin-top:10px;
   }
 </style>
  <script src="http://code.jquery.com/jquery-latest.js"></script>
 
 <script>
   $(function()
   {
	   var $ss=$(".sel");
	   $(".sel").click(function()
	   {
		   var n=$ss.index(this);
		   opener.$("#bname").text($(".name").eq(n).text());
		   opener.$("#bjuso").text($(".juso").eq(n).text());
		   opener.$("#bphone").text($(".phone").eq(n).text());
		   opener.$("#bchuga").text($(".chuga").eq(n).text());
		   
		   close(); // 오픈된 창 닫기
	   });
   });
   /*
   function change(n) // 현재 창의 주소를 부모창의 배송주소로 이동
   {
	   // 부모창의 요소 = 현재창의 요소;
	   opener.document.getElementById("bname").innerText=document.getElementsByClassName("name")[n].innerText;
	   opener.document.getElementById("bjuso").innerText=document.getElementsByClassName("juso")[n].innerText;
	   opener.document.getElementById("bphone").innerText=document.getElementsByClassName("phone")[n].innerText;
	   opener.document.getElementById("bchuga").innerText=document.getElementsByClassName("chuga")[n].innerText;
   }
   */
    
 </script>
</head>
<body>
 <h2 align="center"> 배송 주소록 </h2>
 <c:set var="i" value="0"/>
 <c:forEach items="${list}" var="bvo">
  <div class="outer">
    <div class="name"> ${bvo.name}</div>
    <div class="juso"> ${bvo.juso}  ${bvo.juso_etc}</div>
    <div class="phone"> ${bvo.phone}</div>
    <c:if test="${bvo.chuga == 0}">
      <c:set var="chuga" value="문 앞"/>
    </c:if>
    <c:if test="${bvo.chuga == 1}">
      <c:set var="chuga" value="직접받고 부재시 문 앞"/>
    </c:if>
    <c:if test="${bvo.chuga == 2}">
      <c:set var="chuga" value="경비실"/>
    </c:if>
    <c:if test="${bvo.chuga == 3}">
      <c:set var="chuga" value="택배함"/>
    </c:if>
    <div class="chuga"> ${chuga}</div>
    <div> 
      <div id="left" onclick="edit(${bvo.id})"> 수정 </div>
      <div id="right" class="sel"> 선택 </div>  <%-- onclick="change(${i})" --%>
    </div>
  </div>
  <c:set var="i" value="${i+1}"/>
 </c:forEach>
  <div id="chuga" onclick="location='juso_add'"> 주소록 추가 </div>
  
  <form name="editform" method="post" action="baesong_edit">
    <input  type="hidden" name="id">
  </form>
  <script>
   function edit(id)
   {
	   document.editform.id.value=id;
	   document.editform.submit();
   }
  </script>
</body>
</html>