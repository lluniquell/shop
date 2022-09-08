<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
       height:800px;
       margin:auto;
    }
    section #ar2 {
       width:1000px;
       height:200px;
       background:#FFB2F5;
       margin:auto;
    }
    section #ar3 {
       width:1000px;
       height:200px;
       background:#B2CCFF;
       margin:auto;
    }
    section #ar4 {
       width:1000px;
       height:200px;
       background:#FFC19E;
       margin:auto;
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
      <article id="ar2"> 최신상품 5개</article> <!-- 최신 상품 -->
      <article id="ar3"> 인기상품 5개 </article> <!-- 인기 상품 -->
      <article id="ar4"> 특가상품 5개 </article> <!-- 특가 상품 -->
      <article id="ar5"> 이벤트 상품 5개 </article> <!-- 이벤트상품 -->
    </section>
  