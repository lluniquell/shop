<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>     
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
      margin-top:50px;
    }
    
    section #review {
      width:1000px;
      /* height:500px; */
      margin-bottom:30px;
      margin-top:20px;
    }
    section #review .pers div {
      padding-top:5px; /* 사용자별 상품평의 div 태그의 간격 조절 */
    }
    section #inq {
      width:1000px;
      margin-bottom:30px;
      margin-top:20px;
    }
    section #an {
      width:1000px;
      margin-bottom:30px;
      margin-top:20px;
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
    	if(confirm("wish리스트에 상품을 추가할까요?")) // 확인(true), 취소(false)
    	{
    		var chk=new XMLHttpRequest();
        	chk.onload=function()
        	{
        		//alert(chk.responseText);
        		if(chk.responseText=="0")
        			alert("wish리스트에 저장");
        		else
        			alert("내부 오류발생");
        	}
        	chk.open("get","wish_add?pcode=${pvo.pcode}");
        	chk.send();
    	}	
    	
    	
    }
    
    function cart_add()  // 사용자 아이디, 상품코드,수량 cart테이블에 저장
    {
    	var x=event.clientX-75;
    	var y=event.clientY-120; 
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
  </form>
    <div id="pcmenu">
      <ul>
        <li class="pcsub" onclick="change_sub(0)"> <a href="#a2">상품상세</a> </li><li class="pcsub" onclick="change_sub(1)"> <a href="#review">상품평</a> </li><li class="pcsub" onclick="change_sub(2)"> <a href="#ing">상품문의</a> </li><li class="pcsub" onclick="change_sub(3)"> <a href="#an">배송/교환/반품안내</a> </li>
      </ul>
    </div>
    <script>
     function change_sub(n)
     {
    	 // 배경색 #f7f7f7, 밑줄 생기기
    	 var pcsub=document.getElementsByClassName("pcsub");
    	 var len=pcsub.length;
    	 for(i=0;i<len;i++)
    	 {
    		 pcsub[i].style.background="#f7f7f7";
    		 pcsub[i].style.borderBottom="1px solid #cccccc";
    	 }	 
    	 // 선택된 li  배경색 : white, 밑줄 X
    	 pcsub[n].style.background="white";
		 pcsub[n].style.borderBottom="none";
     }
     
     function pcmenu_stop() // 스크롤이 특정값이 될경우 #pcmenu를 position:fixed , relative로 변경 
     {
    	 var top=document.documentElement.scrollTop;
    	 if(top>710)
    	{
    		 document.getElementById("pcmenu").style.position="fixed";
    		 document.getElementById("pcmenu").style.top="0px";
    	} else {
    		 document.getElementById("pcmenu").style.position="relative";
    	}
     }
     window.onscroll=pcmenu_stop;
     
     function qwrite(){
    	 document.getElementById("qlayer").style.visibility="visible";
    	 position_chg();
     }
     
     function position_chg()
     {
    	 var x=innerWidth; // 브라우저 가로
    	 var y=innerHeight; // 브라우저 세로
    	 var left=(x/2)-220; // 220은 레이어/2
    	 var top=(y/2)-125+document.documentElement.scrollTop; // 125는 레이어/2
    	 document.getElementById("qlayer").style.left=left+"px";
    	 document.getElementById("qlayer").style.top=top+"px";
     }
     window.onresize=position_chg;
    </script>
    <style>    
      section #pcmenu {
        width:1000px;
        height:60px;
        margin:auto;
        position:relative;
      }
      section #pcmenu ul {
        padding-left:0px;
      }
      section #pcmenu ul li {
        list-style-type:none;
        display:inline-block;
        width:243px;
        height:38px;
        text-align:center;
        border:1px solid #cccccc;
        border-top:3px solid #cccccc;
        padding-top:12px;
        margin-left:0px;
        border-right:none;
        background:#f7f7f7;
        cursor:pointer;
       }
      section #pcmenu ul li:last-child {
        border-right:1px solid #cccccc;
      }
      section #pcmenu ul li:first-child {
        background:white;
        border-bottom:none;
      }  
      section #qlayer {
      position:absolute;
      visibility:hidden;
      width:440px;
      heigth:250px;
      border:1px solid #cccccc;
      background:white;      
      }
      
      section article {
      border-top:2px solid #cccccc;
      padding-top:50px;
      }
      
      section #qq{
      border:1px solid #888888;
      background:#888888;
      color:white;
      }
      
      section #qq2{
      border:1px solid blue;
      background:blue;
      color:white;
      }
      
      section #qtable td{
       height*:30px;
       
      }
            
    </style>
    
    <article id="a2"> <!-- 제품 상세 -->
      <img src="../resources/img/${pvo.cimg}" width="1000"> 
    </article>
   <c:if test="${!empty rlist }"> 
    <article id="review"> <!--  상품평  : pro_content요청시  review테이블에서 현재 상품pcode의 내용을 전부 가져오기-->
       <h2> 상 품 평 </h2>
       <div class="pers">
         <!-- 총별점 출력하는 부분 -->
         <c:forEach begin="1" end="${chong_star}">
          <img src="../resources/main/star1.png">
         </c:forEach>
         <c:forEach begin="1" end="${5-chong_star}">
          <img src="../resources/main/star2.png">
         </c:forEach>
   
         <!-- 사용자별 상품평 출력하기 -->
         <c:forEach items="${rlist}" var="rvo">
          <div style="margin-top:30px;"> ${fn:substring(rvo.userid,0,4)}** </div>
          <!-- 
               ${ fn:substring(rvo.userid,0,4)      }
           -->
          <div> 
            <c:forEach begin="1" end="${rvo.star}">
             <img src="../resources/main/star1.png" width="15">
            </c:forEach>
            <c:forEach begin="1" end="${5-rvo.star}">
             <img src="../resources/main/star2.png" width="15">
            </c:forEach>
          </div>
          <div> <b> ${rvo.title} </b></div>
          <div> ${rvo.content}</div>
          <p>
         </c:forEach>
         
       </div>
    </article>
   </c:if>
    <article id="inq">  <!-- 상품문의 -->
     <h2>상품 문의 <span style="font-size:13px" onclick="qwrite()">문의하기</span></h2>
	   <c:forEach items="${qlist}" var="qvo">
		<table width="900" style="border-top:2px solide #cccccc" align="center">
			<!-- 질문인지 답변이지 출력 -->
			<c:if test="${qvo.seq==1}">
			<span id="qq">질문</span>
			</c:if>
			<c:if test="${qvo.seq==2}">
			<span id="qq2">답변</span>
			</c:if>
			<tr>
				<td width="700">${qvo.email}</td>
				<td>${qvo.writeday}</td>
			</tr>
			<tr>
				<td colspan="2">
				${qvo.ptitle}
				</td>
			</tr>
			<tr>
				<td colspan="2">
				${qvo.content}
				</td>
			</tr>
		</table>
	   </c:forEach>  
    </article>
    <article id="an">  <!-- 배송/교환/안내 -->
    
    </article>
    
    <div id="cart_msg"> <!-- 레이어 -->
       장바구니로 이동!! <p>
       <input type="button" value="이동" onclick="location='../mypage/cart'">
       <input type="button" value="계속쇼핑" onclick="document.getElementById('cart_msg').style.visibility='hidden'">
    </div>
    
    <div id="qlayer"> <!-- 문의하기 레이어 -->
    	<form method="post" action="qwrite_ok">
    	<input type="hidden" name="seq" value="1">
    	<input type="hidden" name="pcode" value="${pvo.pcode}">
    	<table width="500" align="center">
    		<caption><h3>상품 문의</h3></caption>
    		<tr>
    			<td>상품정보</td>
    			<td><input type="text" name="ptitle" value="${pvo.title}" readonly style="border:none;outline:none;font-size:15px"></td>
    		</tr>
    		<tr>
    			<td>문의내용</td>
    			<td><textarea cols="30" rows="6" name="content"></textarea></td>
    		</tr>
    		<tr>
    			<td colspan="2" align="center">
    				<input type="submit" value="문의작성">
    				<input type="button" value="취소">
    				
    			</td>
    		</tr>
    	</table>
    	</form>
    </div>
  </section>
</body>
</html>