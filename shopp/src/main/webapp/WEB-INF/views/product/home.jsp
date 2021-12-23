<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script src="/resources/vendor/jquery/jquery.js"></script>
    
<%@include file="../include/header.jsp" %>
<link rel="stylesheet" type="text/css" href="/resources/slick/slick.css">
<link rel="stylesheet" type="text/css" href="/resources/slick/slick-theme.css">

<style type="text/css">
    * {
      box-sizing: border-box;
    }

    .slider {
        width: 50%;
        margin: 100px auto;
    }

    .slick-slide {
      margin: 0px 20px;
    }

    .slick-slide img {
      width: 100%;
    }

    .slick-prev:before,
    .slick-next:before {
      color: black;
    }
    .slick-slide {
      transition: all ease-in-out .3s;
      opacity: .2;
    }
    
    .slick-active {
      opacity: .5;
    }

    .slick-current {
      opacity: 1;
    }
    .titleType{
    	margin:0 0 -50px 50px;
    }
    .slick-slider{
    	margin-bottom:5%;
    }
    .slick-list{
    	height:120%;
    }
    .center button {
		box-shadow: rgba(30, 22, 54, 0.4) 0 0px 0px 0px inset;
	}
</style>
<h3 class="titleType">OUTER</h3>
  <section class="center slider" style="height:25%; width:90%; text-align:center">
  	<h1><br><br>OUTER</h1>
  	<c:forEach items="${typeA }" var="typeA">
    	<div align=center>
    		<a href="/product/get?bno=${typeA.bno }"><img src="/resources/upload/2021/${typeA.uuid }_${typeA.filename}" /></a>
			<b>${typeA.title }</b>
    	</div>
	</c:forEach>
  </section>
  <br><br>
<hr>
<h3 class="titleType">TOP</h3>
  <section class="center slider" style="height:20%; width:90%;">
  	<h1><br><br>TOP</h1>
  	<c:forEach items="${typeB }" var="typeB">
    	<div align=center>
    		<img src="/resources/upload/2021/${typeB.uuid }_${typeB.filename}" />
			<b>${typeB.title }</b>
    	</div>
	</c:forEach>
  </section>
<hr>
<h3 class="titleType">PANTS</h3>
  <section class="center slider" style="height:20%; width:90%;">
  	<h1><br><br>PANTS</h1>
  	<c:forEach items="${typeC }" var="typeC">
  		<img src="/resources/upload/2021/${typeC.uuid }_${typeC.filename}" />
    	<div align=center>
			<b>${typeC.title }</b>
    	</div>
	</c:forEach>
  </section>
  
  
  
  
  <script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
  <script src="/resources/slick/slick.js" type="text/javascript" charset="utf-8"></script>
  <script type="text/javascript">
    $(document).on('ready', function() {
      $(".vertical-center-4").slick({
        dots: true,
        vertical: true,
        centerMode: true,
        slidesToShow: 4,
        slidesToScroll: 2
      });
      $(".vertical-center-3").slick({
        dots: true,
        vertical: true,
        centerMode: true,
        slidesToShow: 3,
        slidesToScroll: 3
      });
      $(".vertical-center-2").slick({
        dots: true,
        vertical: true,
        centerMode: true,
        slidesToShow: 2,
        slidesToScroll: 2
      });
      $(".vertical-center").slick({
        dots: true,
        vertical: true,
        centerMode: true,
      });
      $(".vertical").slick({
        dots: true,
        vertical: true,
        slidesToShow: 3,
        slidesToScroll: 3
      });
      $(".regular").slick({
        dots: true,
        infinite: true,
        slidesToShow: 3,
        slidesToScroll: 3
      });
      $(".center").slick({
        dots: true,
        infinite: true,
        centerMode: true,
        slidesToShow: 5,
        slidesToScroll: 3
      });
      $(".variable").slick({
        dots: true,
        infinite: true,
        variableWidth: true
      });
      $(".lazy").slick({
        lazyLoad: 'ondemand', // ondemand progressive anticipated
        infinite: true
      });
    });
</script>
 <%@include file="../include/footer.jsp" %>
	