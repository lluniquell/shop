<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
<style>
 /* 검색창 만들기 끝 */
    #image {
       width:1300px;
       height:300px;
       background:red;
       margin:auto;
    }
    
    #image #outer {
       width:1300px;
       height:300px;
       overflow:hidden;  
    }
    #image #inner {
       width:6600px;
       height:300px;
    }
    
    section {
       width:1000px;
       height:900px;
       margin:auto;
    }
    section #ar2, #ar3, #ar4 {
       width:1000px;
       height:280px;      
       margin:auto;
       font-size:17px;
    }
    
  
   section #ar2 table, #ar3 table,  #ar4 table{
        border-collapse:collapse;
        }
  
   section #ar2 td , #ar3 td, #ar4 td {
     width:190px;
     height:190px;
     padding:15px;
     vertical-align:top;
    

   }
   section #ar2 td:hover ,#ar3 td:hover, #ar4 td:hover {
     border:1px solid #D941C5;
   }
   section #ar2 td div ,#ar3 td div, #ar4 td div {
     margin-top:5px;
   }
 
   section #ar2 #baeprice ,#ar3 #baeprice,#ar4 #baeprice {
     font-size:12px;
   }
   section #ar2 #title, #ar3 #title, #ar4 #title {
     font-size:15px;
   }
  
   section #ar2 s , #ar3 s, #ar3 s { /* 할인전 금액 */
     color:grey;
   }
    
    
   
    section #ar5 {
       width:1000px;
       height:200px;
       background:#BDBDBD;
       margin:auto;
    }

</style>
<script>
  $(function()
  {
	  // 슬라이드 그림 움직이기
	  function mainmove()
	  {
	    ss=setInterval(function()
	    {
	    	$("#image #inner").animate(
 		    {
 		    	marginLeft:"-1300px"
 		    },2000,function()
 		           {
 		    	       $("#image #inner").css("margin-left","0px");
 		    	       $("#image #inner img").eq(0).insertAfter($("#image #inner img").eq(4));
 		           });
	    },4000);
	  }
	  mainmove();
	  
	  $("#image #outer").mouseover(function()
	  {
		  clearInterval(ss);
	  });
	  $("#image #outer").mouseout(function()
	  {
		  mainmove();
	  });
  });
  
 function content_view(pcode){
	 location="../product/pro_content?pcode="+pcode;
 }
</script>  
</head> 
    <div id="image"><!-- 그림슬라이드 -->
      <div id="outer">
        <div id="inner">
          <img src="../resources/main/1.png" width="1300" height="300"><img src="../resources/main/2.png" width="1300" height="300"><img src="../resources/main/3.png" width="1300" height="300"><img src="../resources/main/4.png" width="1300" height="300"><img src="../resources/main/5.png" width="1300" height="300">
        </div>
      </div>
    </div> 
    <section>           <!-- 현재페이지의 필요한 내용 -->  <!-- article는 section내의 하나의 항목 -->
      <article id="ar2"> 
     	 신상품
   		 <c:set var="i" value="0"/>
   <table align="center" cellspacing="15">
    <tr>
   		<c:forEach items="${nlist}" var="nvo">
   		
   		  <td onclick="content_view('${nvo.pcode}')"> <!-- 그림, 배송비, 상품명, 가격(할인이 있는경우는 할인가격표시) , 배송일--> 
         <div id="img"> <img src="../resources/img/${nvo.pimg}" width="150" height="150"> </div> <!-- 그림 -->
         <div id="baeprice">
          <c:if test="${nvo.baesong == 0}">
                      무료배송
          </c:if> 
          <c:if test="${nvo.baesong != 0}">
            <fmt:formatNumber value="${nvo.baesong}"/>원
          </c:if>
         </div> <!-- 배송비 -->
         <div id="title"> ${nvo.title} </div> <!-- 상품명 -->
         <div id="price">
          <c:if test="${nvo.halin != 0}"> <!-- 할인율이 0이 아닌경우 -->
           ${nvo.halin}% <s> <fmt:formatNumber value="${nvo.price}"/>원 </s> <br>
           <fmt:formatNumber value="${ nvo.price - ( nvo.price*(nvo.halin/100) )  }" pattern=",000"/>원
          </c:if>
          <c:if test="${nvo.halin == 0}"> <!-- 할인율이 0인 경우 -->
           <fmt:formatNumber value="${nvo.price}"/>원
          </c:if>
         </div> <!-- 가격 -->
         
       </td>

      <c:set var="i" value="${i+1}"/>
     <c:if test="${i%5 == 0}"> 
     </tr>       
     <tr> 
     </c:if>
    </c:forEach>
     </tr>
   </table>   
      </article> <!-- 최신 상품 -->
      <article id="ar3">
    	베스트
   		 <c:set var="i" value="0"/>
   <table align="center" cellspacing="15">
    <tr>
   		<c:forEach items="${mlist}" var="mvo">
   		
   		  <td onclick="content_view('${mvo.pcode}')"> <!-- 그림, 배송비, 상품명, 가격(할인이 있는경우는 할인가격표시) , 배송일--> 
         <div id="img"> <img src="../resources/img/${mvo.pimg}" width="150" height="150"> </div> <!-- 그림 -->
         <div id="baeprice">
          <c:if test="${mvo.baesong == 0}">
                      무료배송
          </c:if> 
          <c:if test="${mvo.baesong != 0}">
            <fmt:formatNumber value="${mvo.baesong}"/>원
          </c:if>
         </div> <!-- 배송비 -->
         <div id="title"> ${mvo.title} </div> <!-- 상품명 -->
         <div id="price">
          <c:if test="${mvo.halin != 0}"> <!-- 할인율이 0이 아닌경우 -->
           ${mvo.halin}% <s> <fmt:formatNumber value="${mvo.price}"/>원 </s> <br>
           <fmt:formatNumber value="${ mvo.price - ( mvo.price*(mvo.halin/100) )  }" pattern=",000"/>원
          </c:if>
          <c:if test="${mvo.halin == 0}"> <!-- 할인율이 0인 경우 -->
           <fmt:formatNumber value="${mvo.price}"/>원
          </c:if>
         </div> <!-- 가격 -->
         
       </td>

      <c:set var="i" value="${i+1}"/>
     <c:if test="${i%5 == 0}"> 
     </tr>       
     <tr> 
     </c:if>
    </c:forEach>
     </tr>
   </table>      
      
      
      </article> <!-- 인기 상품 -->
      <article id="ar4">
    	특가상품
   		 <c:set var="i" value="0"/>
   <table align="center" cellspacing="15">
    <tr>
   		<c:forEach items="${slist}" var="svo">
   		
   		  <td onclick="content_view('${svo.pcode}')"> <!-- 그림, 배송비, 상품명, 가격(할인이 있는경우는 할인가격표시) , 배송일--> 
         <div id="img"> <img src="../resources/img/${svo.pimg}" width="150" height="150"> </div> <!-- 그림 -->
         <div id="baeprice">
          <c:if test="${svo.baesong == 0}">
                      무료배송
          </c:if> 
          <c:if test="${svo.baesong != 0}">
            <fmt:formatNumber value="${svo.baesong}"/>원
          </c:if>
         </div> <!-- 배송비 -->
         <div id="title"> ${svo.title} </div> <!-- 상품명 -->
         <div id="price">
          <c:if test="${svo.halin != 0}"> <!-- 할인율이 0이 아닌경우 -->
           ${svo.halin}% <s> <fmt:formatNumber value="${svo.price}"/>원 </s> <br>
           <fmt:formatNumber value="${ svo.price - ( svo.price*(svo.halin/100) )  }" pattern=",000"/>원
          </c:if>
          <c:if test="${svo.halin == 0}"> <!-- 할인율이 0인 경우 -->
           <fmt:formatNumber value="${svo.price}"/>원
          </c:if>
         </div> <!-- 가격 -->
         
       </td>

      <c:set var="i" value="${i+1}"/>
     <c:if test="${i%5 == 0}"> 
     </tr>       
     <tr> 
     </c:if>
    </c:forEach>
     </tr>
   </table>      
         
   
     </article> <!-- 특가 상품 -->    
    </section>
  