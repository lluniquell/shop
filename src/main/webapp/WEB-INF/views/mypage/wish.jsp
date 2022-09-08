<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>     
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
 <c:set var="size" value="${list.size() }"/>
 <c:if test="${size <=5}">
   <c:set var="he" value="600"/>
 </c:if>
 <c:if test="${size > 5}">
   <c:set var="he" value="${(size-5)*100+600}"/>
 </c:if>

 <style>
   section {
     width:1000px;
     height:${he}px;
     margin:auto;
     margin-bottom:50px;
   }
   section tr:first-child td {
     border-top:2px solid #cccccc;
     border-bottom:1px solid #cccccc;
     height:35px;
    
   }
   section tr td {
     border-bottom:1px solid #cccccc;
   }
   
   section tr:last-child td {
     border-bottom:2px solid #cccccc;
   }
   
   section #delbtn {
     width:180px;
     height:30px;
     border:1px solid #D941C5;
     color:white;
     background:#D941C5;
     font-weight:900;
     cursor:pointer;
   }
   section #delbtn2 {
     width:60px;
     height:30px;
     border:1px solid #D941C5;
     color:white;
     background:#D941C5;
     font-weight:900;
     cursor:pointer;
   }
   section #mvbtn, section #gumaebtn {
     width:180px;
     height:30px;
     border:1px solid #D941C5;
     color:#D941C5;
     background:white;
     font-weight:900;
     cursor:pointer;
   }
 </style>
 <script>
   function maincheck(ck) // ck=> true, false
   {
	   
	   var len=document.getElementsByClassName("subchk").length;
	   if(ck)  // main이 체크가 되면
	   {  // class='subchk'를 checked속성을 true
		   for(i=0;i<len;i++)
		   {
			   document.getElementsByClassName("subchk")[i].checked=true;
		   }	   
	   }	 
	   else
	   {
		   for(i=0;i<len;i++)
		   {
			   document.getElementsByClassName("subchk")[i].checked=false;
		   }
	   }	    
   }
   function subcheck()
   {
	   var chk=0;
	   // 체크박스의 항목이 전부 체크 되었느냐를 확인
	   var len=document.getElementsByClassName("subchk").length;
	   // 하나씩 체크하기
	   for(i=0;i<len;i++)
	   {
		   if(document.getElementsByClassName("subchk")[i].checked)
			   chk++;
	   }	
	   
	   if(chk==len)
	   {
		   document.getElementById("mainchk").checked=true;
	   }	
	   else
	   {
		   document.getElementById("mainchk").checked=false;
	   }	   
   }
   
   function select_del()
   {
	   // 체크된 상품을 삭제 => 체크된 상품의 wish.id를 전송
	   // 삭제할 id들을 구분자를 통해 문자열의 형태로 만든다 => 11,33,22,
	   var len=document.getElementsByClassName("subchk").length;
	   var str="";
	   for(i=0;i<len;i++)
	   {
		   if(document.getElementsByClassName("subchk")[i].checked) // 삭제체크가 되었다면
		      str=str+document.getElementsByClassName("subchk")[i].value+",";
	   }
	   //alert(str);
	   location="select_del?delid="+str;    // delid=삭제할id
   }
   function move_cart()
   {
	   var pcode=""; // 하나이상이 존재
	   // 체크박스가 체크된 곳의 인덱스와    hidden의 index는 같다 => hidden의 value값을 pcode변수에 저장 ,구분자
	   // pcode="p010101002,p010105006,p010105007,"
	   // pcode값 생성
	   var len=document.getElementsByClassName("subchk").length;
	   for(i=0;i<len;i++)
	   {
		   if(document.getElementsByClassName("subchk")[i].checked)
			   pcode=pcode+document.getElementsByClassName("pcode")[i].value+",";
	   }	    
	   //alert(pcode);
	   location="move_cart?pcode="+pcode;
   }
   
   function gumae()
   {
	   // 선택되어진 상품의 pcode, 수량을  콤마로 구분하여 하나의 문자열로 생성
	   var pcode="";
	   var su="";
	   
	   var subchk=document.getElementsByClassName("subchk");  
	   var len=subchk.length; // 상품의 리스트 갯수
	   //alert(len);
	   for(i=0;i<len;i++)
	   {
		   if(subchk[i].checked)
		   {
			   pcode=pcode+document.getElementsByClassName("pcode")[i].value+",";
			   su=su+"1,";
		   }	   
	   }
	   //alert(pcode);
	   //alert(su);
	   
	   location="../product/pro_gumae?gchk=1&pcode="+pcode+"&su="+su;
   }
 </script>
</head>
<body> <!-- wish.jsp -->
   <section>
     <table width="900" align="center" cellspacing="0">
       <caption> <h3> 나의 wish </h3>
       <tr align="center">
         <td> <input type="checkbox" onclick="maincheck(this.checked)" style="width:20px;height:20px;" id="mainchk"> </td>
         <td> 상품이미지 </td>
         <td> 상품명 </td>
         <td> 상품가격 </td>
         <td> 날짜 </td>
         <td> 삭제하기 </td>
       </tr>
       
     <c:forEach items="${list}" var="wvo">
       <input type="hidden" class="pcode" value="${wvo.pcode}">
       <tr align="center">
         <td> <input type="checkbox" class="subchk" onclick="subcheck()" value="${wvo.id}"> </td>
         <td> <img src="../resources/img/${wvo.pimg}"  width="70" height="70" style="border:1px solid #cccccc;padding:5px;"> </td>
         <td> ${wvo.title} </td>
         <td> <fmt:formatNumber value="${wvo.price}"/>원 </td>
         <td> ${wvo.writeday} </td>
         <td> <input type="button" id="delbtn2" value="삭제" onclick="location='wish_del?id=${wvo.id}'"> </td>
       </tr>
     </c:forEach>
       <tr height="80">
         <td colspan="6" align="center">
          <input type="button" id="delbtn" value="선택삭제" onclick="select_del()"> 
          <input type="button" id="mvbtn" value="장바구니이동" onclick="move_cart()">
          <input type="button" id="gumaebtn" value="상품구매" onclick="gumae()">
         </td>
       </tr>
     </table>
   </section>
</body>
</html>






