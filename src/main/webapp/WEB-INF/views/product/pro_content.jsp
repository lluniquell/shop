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
      margin-top:70px;
    }
    section #a1 {
      width:1000px;
      height:500px;
    }
    section #a1 #left {
      width:500px;
      height:500px;
      float:left;
      text-align:center;
    }
    section #a1 #right {
      width:500px;
      height:500px;
      float:right;
    }
    section #right div {
      margin-top:28px;
    }
    section #right div:first-child {
      margin-top:0px;
    }
    section #right #title {
      font-size:24px;
    }
    section #right #price {
      font-size:20px;
      color:red;
      font-weight:900;
    }
    section #right #juk {
      color:blue;
    }
    section #right #bae {
      font-size:20px;
      
    }
    section #right #su #spinner {
      width:140px;
      outline:none;  /* input type="text" 의 외곽선밖 없애기 */
    }
    section #right #etc .btn { /* span태그 wish,cart,바로구매 */
      width:100px;
      height:30px;
      border:1px solid #cccccc;
      display:inline-block;
      padding-top:5px;
      text-align:center;
      cursor:pointer;
    }
    section #a2 {
      clear:both; /* float기능 해제 */
      width:1000px;
      margin-bottom:30px;
    }
    section #cart_msg {
      position:absolute;
      visibility:hidden;
      width:150px;
      height:80px;
      border:1px solid #cccccc;
      background:white;
      padding-top:22px;
      padding-left:22px;
    }
  </style>
  <script src="http://code.jquery.com/jquery-latest.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script> 
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script>
    $(function()
    {
    	 $("#spinner").spinner(
    	 {
    		 min:1,
    		 max:10,
    		 spin:function(e,ui) // 아래위로가는 버튼 클릭시 실행
    		 {
    			 var total=parseInt(${ pvo.price - ( pvo.price*(pvo.halin/100) )  }*ui.value); 
    			                   // 할인금액을 뺀 상품금액   *  수량
    			 total=new Intl.NumberFormat().format(total); // 자바스크립트에 , 넣기
    			 document.getElementById("tot").innerText=total+"원";
    			 
    			 // 적립금 변경
    			 var juk_tot=parseInt(${pvo.juk}*ui.value);
    			 juk_tot=new Intl.NumberFormat().format(juk_tot);
    			 document.getElementById("juk_in").innerText=juk_tot+"원";
    		 }
    	 });
    	 
    	 
    });
    function wish_add()  // 사용자 아이디, 상품코드를 wish테이블에 저장
    {
    	if(confirm("wish테이블에 상품을 추가할까요?")) // 확인(true), 취소(false)
    	{
    		var chk=new XMLHttpRequest();
        	chk.onload=function()
        	{
        		//alert(chk.responseText);
        		if(chk.responseText=="0")
        			alert("wish테이블에 저장");
        		else
        			alert("내부 오류발생");
        	}
        	chk.open("get","wish_add?pcode=${pvo.pcode}");
        	chk.send();
    	}	
    	
    	
    }
    
    function cart_add()  // 사용자 아이디, 상품코드,수량 cart테이블에 저장
    {
    	var x=event.clientX-100;
    	var y=event.clientY-100; 
    	var chk=new XMLHttpRequest();
    	var su=document.pro.su.value;
    	chk.onload=function()
    	{
    		if(chk.responseText=="0")
    		{
    			document.getElementById("cart_msg").style.left=x+"px";
    			document.getElementById("cart_msg").style.top=y+"px";
    			document.getElementById("cart_msg").style.visibility="visible";
    			/* if(confirm("장바구니로 이동하시겠습니가?"))
    			{
    				location="../product/cart_view";
    			}	 */
    		}	
    		else
    		{
    			alert("내부 오류");
    		}	
    	}
    	chk.open("get","cart_add?pcode=${pvo.pcode}&su="+su);
    	chk.send();
    }
    
    function pro_submit()
    {
    	document.pro.submit();
    }
  </script>
</head>
<body> <!-- pro_content.jsp -->
  <section>
   <form name="pro" method="post" action="pro_gumae">
    <input type="hidden" name="gchk" value="0">
    <input type="hidden" name="pcode" value="${pvo.pcode}">
    <article id="a1">
      <div id="left"> <img src="../resources/img/${pvo.pimg}" width="400"> </div>
      <div id="right">
        <div id="title"> ${pvo.title}</div> <!-- 상품명 -->
        <div id="star">  </div>  <!-- 별점 -->
        <div id="price"> 
          <c:if test="${pvo.halin != 0}"> <!-- 할인율이 0이 아닌경우 -->
           ${pvo.halin}% <s> <fmt:formatNumber value="${pvo.price}"/>원 </s> <br>
           <span id="tot"><fmt:formatNumber value="${ pvo.price - ( pvo.price*(pvo.halin/100) )  }" pattern=",000"/>원</span>
          </c:if>
          <c:if test="${pvo.halin == 0}"> <!-- 할인율이 0인 경우 -->
           <span id="tot"><fmt:formatNumber value="${pvo.price}"/>원</span>
          </c:if>
        </div> <!-- 가격  -->
        <div id="juk"> 
          적립금 : <span id="juk_in"> <fmt:formatNumber value="${pvo.juk }"/>원 </span>
        </div>   <!-- 적립금 -->
        
         <c:choose>
          <c:when test="${pvo.yoil == 1}">
            <c:set var="yo" value="일요일"/>
          </c:when>
          <c:when test="${pvo.yoil == 2}">
            <c:set var="yo" value="월요일"/>
          </c:when>
          <c:when test="${pvo.yoil == 3}">
            <c:set var="yo" value="화요일"/>
          </c:when>
          <c:when test="${pvo.yoil == 4}">
            <c:set var="yo" value="수요일"/>
          </c:when>
          <c:when test="${pvo.yoil == 5}">
            <c:set var="yo" value="목요일"/>
          </c:when>
          <c:when test="${pvo.yoil == 6}">
            <c:set var="yo" value="금요일"/>
          </c:when>
          <c:when test="${pvo.yoil == 7}">
            <c:set var="yo" value="토요일"/>
          </c:when>
         </c:choose>
        <div id="bae">  ${yo} : ${pvo.baeday2} 도착예정 </div>   <!-- 배송관련 -->
        <div id="made"> ${pvo.made} </div>  <!-- 제조사 -->
        <div id="su"> 
          <input type="text" id="spinner" name="su" value="1" readonly>
        </div> <!-- 수량 -->
        <div id="etc"> 
         <!-- wish관련 -->
         <c:if test="${userid != null}"> <!-- 로그인을 한 경우 -->
           <c:if test="${wishcnt == 0}"> <!-- wish테이블에 존재하지 않는경우 -->
            <span class="btn" onclick="wish_add()"> wish </span>
           </c:if>
           <c:if test="${wishcnt == 1}"> <!-- wish테이블에 존재하는 경우 -->
            <span class="btn" onclick="location='wish_cancel?pcode=${pvo.pcode}'"> wish취소 </span>
           </c:if>
         </c:if>
         <c:if test="${userid == null}"> 
          <span class="btn" onclick="alert('로그인을 하세요')"> wish </span> 
         </c:if>  
         <!-- 장바구니 관련 -->  
         <c:if test="${userid != null}">
          <span class="btn" onclick="cart_add()"> 장바구니 </span>
         </c:if>
         <c:if test="${userid == null}"> 
          <span class="btn" onclick="alert('로그인을 하세요')"> 장바구니 </span> 
         </c:if>  
         
          <span class="btn" onclick="pro_submit()"> 바로구매 </span>
        </div>   <!-- 위시, 장바구니, 구매 -->
      </div>
    </article>
    <article id="a2">
      <img src="../resources/img/${pvo.cimg}" width="1000"> 
    </article>
    
    </form>
    
    <div id="cart_msg">
       장바구니로 이동!! <p>
       <input type="button" value="이동" onclick="location='../product/cart_view'">
       <input type="button" value="계속쇼핑" onclick="document.getElementById('cart_msg').style.visibility='hidden'">
    </div>
  </section>
</body>
</html>