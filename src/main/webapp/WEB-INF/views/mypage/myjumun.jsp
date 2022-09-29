<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
 <style>
   section {
     width:1000px;
     height:600px;
     margin:auto;
     margin-top:50px;
   }
  section tr:first-child td {
    height:40px;
    border-top:2px solid #cccccc;
  }
  section td {
    border-bottom:1px solid #cccccc;
    padding-top:7px;
    padding-bottom:7px;
  }
  section tr:last-child td {
    border-bottom:2px solid #cccccc;
  }
 </style>
</head>
<body> <!-- myjumun.jsp -->
  <section>
    <table width="980" align="center" cellspacing="0">
      <caption> <h3> 주 문 내 역</h3> </caption>
      <tr align="center">
        <td> 주문 일자 </td>
        <td> 상품 </td>
        <td> 상품 제목 </td>
        <td> 수량 </td>
        <td> 결제 금액 </td>
        <td> 상 태 </td>
        <td> 변 경 </td>
        <td> 상품평 </td>
      </tr>
      
     <c:forEach items="${list}" var="gvo">
      <tr align="center">
        <td> ${gvo.writeday} </td>
        <td> <img src="../resources/img/${gvo.pimg}" width="70" height="70"> </td>
        <td> ${gvo.title} </td>
        <td> ${gvo.su}개 </td>
        <td> <fmt:formatNumber value="${gvo.chong}" pattern="#,###"/>원 </td>
        <!-- state관련 if -->
        <c:if test="${gvo.state==0}">
         <c:set var="state" value="결제완료"/>
        </c:if>
        <c:if test="${gvo.state==1}">
         <c:set var="state" value="취소신청"/>
        </c:if>
        <c:if test="${gvo.state==2}">
         <c:set var="state" value="취소완료"/>
        </c:if>
        <c:if test="${gvo.state==3}">
         <c:set var="state" value="배송중"/>
        </c:if>
        <c:if test="${gvo.state==4}">
         <c:set var="state" value="배송완료"/>
        </c:if>
        <c:if test="${gvo.state==5}">
         <c:set var="state" value="반품신청"/>
        </c:if>
        <c:if test="${gvo.state==6}">
         <c:set var="state" value="반품완료"/>
        </c:if>
        <c:if test="${gvo.state==7}">
         <c:set var="state" value="교환신청"/>
        </c:if>
        <c:if test="${gvo.state==8}">
         <c:set var="state" value="교환완료"/>
        </c:if>
        <td> ${state} </td>
        <td> 
          <!-- 취소신청버튼 -->
         <c:if test="${gvo.state==0}">  
          <input type="button" value="취소신청" onclick="location='change_state?state=1&id=${gvo.id}'"> <br>  <!-- state를 1로 변경 -->
         </c:if>
          <!-- 취소철회버튼 -->
         <c:if test="${gvo.state==1}">
          <input type="button" value="취소철회" onclick="location='change_state?state=0&id=${gvo.id}'"> <br>  <!-- state를 0로 변경 -->
         </c:if>
          <!-- 반품신청버튼 -->
         <c:if test="${gvo.state==3 || gvo.state==4}"> 
          <input type="button" value="반품신청" onclick="location='change_state?state=5&id=${gvo.id}'"> <br>   <!-- state를 5로 변경 -->
         </c:if>
          <!-- 교환신청버튼 -->
         <c:if test="${gvo.state==0 || gvo.state==1 || gvo.state==3 || gvo.state==4}">
          <input type="button" value="교환신청"  onclick="location='change_state?state=7&id=${gvo.id}'"> <br>    <!-- state를 7로 변경 -->
         </c:if>
        </td>
        <td>
          <c:if test="${gvo.state==4}"> 
             <c:if test="${gvo.hugi==0}">
               <input type="button" value="상품평쓰기" onclick="location='review?pcode=${gvo.pcode}&gid=${gvo.id}'">
             </c:if>
             <c:if test="${gvo.hugi==1}">
               <input type="button" value="상품평보기">
             </c:if>
          </c:if> 
          <c:if test="${gvo.state!=4}"> 
           <input type="button" value="상품평쓰기" disabled>
          </c:if> 
        </td>
      </tr>
     </c:forEach> 
      
    </table>
  </section>
</body>
</html>