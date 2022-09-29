<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
 <style>
   section {
     width:1000px;
     margin:auto;
   }
   section td {
     width:270px;
     height:300px;
     padding:15px;
     vertical-align:top;
     border:1px solid #dddddd;
   }
   section td:hover {
     border:1px solid #D941C5;
   }
   section td div {
     margin-top:5px;
   }
   section #img {
   
   }
   section #baeprice {
     font-size:12px;
   }
   section #title {
     font-size:15px;
   }
   section #price {
     font-size:17px;
     color:red;
   }
   section #price s { /* 할인전 금액 */
     color:grey;
   }
   section #baeday {
     font-size:12px;
   }
 </style>
 <script>
   function content_view(pcode)
   {
	   location="../product/pro_content?pcode="+pcode;
   }
 </script>
</head>
<body>  <!-- pro_list.jsp -->
  <section> <!-- 상품을 30개 출력 -->
   <c:set var="i" value="0"/>
  
   <table align="center" cellspacing="15">
    <tr>
    	<c:if test="${empty klist}">
    	<br>
    	${keyword} 로 검색된 상품이 없습니다.<p>
    	빠른 시일내에 준비하도록 하겠습니다.
    	</c:if>    
    	
    <c:forEach items="${klist}" var="kvo"> 
    	
       <td onclick="content_view('${kvo.pcode}')"> <!-- 그림, 배송비, 상품명, 가격(할인이 있는경우는 할인가격표시) , 배송일--> 
         <div id="img"> <img src="../resources/img/${kvo.pimg}" width="270" height="270"> </div> <!-- 그림 -->
         <div id="baeprice">
          <c:if test="${kvo.baesong == 0}">
                      무료배송
          </c:if> 
          <c:if test="${kvo.baesong != 0}">
            <fmt:formatNumber value="${kvo.baesong}"/>원
          </c:if>
         </div> <!-- 배송비 -->
         <div id="title"> ${kvo.title} </div> <!-- 상품명 -->
         <div id="price">
          <c:if test="${kvo.halin != 0}"> <!-- 할인율이 0이 아닌경우 -->
           ${kvo.halin}% <s> <fmt:formatNumber value="${kvo.price}"/>원 </s> <br>
           <fmt:formatNumber value="${ kvo.price - ( kvo.price*(kvo.halin/100) )  }" pattern=",000"/>원
          </c:if>
          <c:if test="${kvo.halin == 0}"> <!-- 할인율이 0인 경우 -->
           <fmt:formatNumber value="${kvo.price}"/>원
          </c:if>
         </div> <!-- 가격 -->
         <c:choose>
          <c:when test="${kvo.yoil == 1}">
            <c:set var="yo" value="일요일"/>
          </c:when>
          <c:when test="${kvo.yoil == 2}">
            <c:set var="yo" value="월요일"/>
          </c:when>
          <c:when test="${kvo.yoil == 3}">
            <c:set var="yo" value="화요일"/>
          </c:when>
          <c:when test="${kvo.yoil == 4}">
            <c:set var="yo" value="수요일"/>
          </c:when>
          <c:when test="${kvo.yoil == 5}">
            <c:set var="yo" value="목요일"/>
          </c:when>
          <c:when test="${kvo.yoil == 6}">
            <c:set var="yo" value="금요일"/>
          </c:when>
          <c:when test="${kvo.yoil == 7}">
            <c:set var="yo" value="토요일"/>
          </c:when>
         </c:choose>
         <div id="baeday"> ${yo} : ${kvo.baeday2} 도착예정 </div> <!-- 배송일 -->
       </td>
     <c:set var="i" value="${i+1}"/>
     <c:if test="${i%3 == 0}"> 
     </tr>       
     <tr> 
     </c:if>
    </c:forEach>
     </tr>
   </table>
  </section>
</body>
</html>






