<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html lang="en">
<head>	
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<meta name="description" content="" />
	<meta name="author" content="" />
	<title>Simple Sidebar - Start Bootstrap Template</title>
	<link href="/resources/vendor/bootstrap/css/bootstrap.css" rel="stylesheet" />
	<link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
	<!-- Core theme CSS (includes Bootstrap)-->
	<link href="/resources/css/styles.css" rel="stylesheet" />
	<link href="/resources/css/styles2.css" rel="stylesheet" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js" crossorigin="anonymous"></script>
	<script src="/resources/vendor/jquery/jquery.js"></script>
	
	
<style>
	table{
		border-collapse:collapse;
	}
	select {
		font-family: "Noto Sansf KR", sans-serif;
		font-size: 1rem;
		font-weight: 400;
		line-height: 1.5;
		
		color: #444;
		background-color: #fff;
		
		padding: 0.6em 1.4em 0.5em 0.8em;
		margin: 0;
		
		border: 1px solid #aaa;
		border-radius: 0.5em;
		box-shadow: 0 1px 0 1px rgba(0, 0, 0, 0.04);
}
a{
	text-decoration:none;
}
a:link {color:black;}
a:hover { 
	color: skyblue;
	text-decoration:underline; 
}
a:visited{color:gray;}
.aaa{
	padding:0 100px 0 100px;
}

</style>

</head>
<body>
<div class="d-flex" id="wrapper">
	<!-- Sidebar-->
	<div class="border-end bg-white" id="sidebar-wrapper">
		<div class="sidebar-heading border-bottom bg-light"><a href="/"><input type="image" src="/resources/img/logo.png"/></a></div>
		<div class="list-group list-group-flush">
			<a class="list-group-item list-group-item-action list-group-item-light p-3" href="#!">인기상품</a>
			<a class="list-group-item list-group-item-action list-group-item-light p-3 types" href="/product/list">SHOP</a>
			<a class="list-group-item list-group-item-action list-group-item-light p-3 categories" href="#!">menu2</a>
			<a class="list-group-item list-group-item-action list-group-item-light p-3 categories" href="#!">menu3</a>
			<a class="list-group-item list-group-item-action list-group-item-light p-3" href="/notice/list">공지사항</a>
			<a class="list-group-item list-group-item-action list-group-item-light p-3" href="/qna_board/list">QnA</a>
		</div>
	</div>
	<div id="page-content-wrapper">
		<table height=150px class="headerTable">
			<tr height=50px>
				<sec:authorize access="isAnonymous()">
					<td colspan=4 align=right><a href="/customLogin">[로그인]</a></td>
					<td colspan=2 align=left><a href="/member/joinMember">[회원가입]</a></td>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
					<td colspan=4 align=right><b><sec:authentication property="principal.member.userName"/>님</b> 환영합니다.</td>
					<td colspan=2 align=left><a href="/customLogout">&nbsp; &nbsp;[로그아웃]</a></td>
				</sec:authorize>
			</tr>
			<tr height=100px align=center>
				<td width=10%>
					<!-- <button class="btn btn-primary" id="sidebarToggle">Toggle Menu</button> -->
					<input type="image" src="/resources/img/Hamburger_icon.svg.png" width=30% id="sidebarToggle"/>
				</td>
				<td width=10%>
					<a href="/">
						<input type="image" src="/resources/img/logo.png"/>
					</a>
				</td>
				<td width=5%></td>
				<td width=60%>
					<div class=search>
						<div class="input-group">
							<select>
								<option>전체</option>
								<option>cat1</option>
								<option>cat2</option>
								<option>cat3</option>
				 			</select>
                    		<input class="form-control" type="text" placeholder="Search for..." aria-label="Search for..." aria-describedby="btnNavbarSearch" />
                    		<button class="btn btn-primary" id="btnNavbarSearch" type="button"><i class="fas fa-search"></i></button>
                		</div>
			 		</div>
				</td>
				<td width=15%>
					<sec:authorize access="isAuthenticated()">
						<a href="/member/getMember?userid=<sec:authentication property="principal.member.userid"/>">
							<input type="image" src="/resources/img/mypage.png" width=80px/><input type="image" src="/resources/img/cart.jpg" width=80px/>
						</a>
					</sec:authorize>
				</td>
			</tr>
		</table>

	<hr width=100%/>
	<!-- /.header -->
<!-- /검색창 -->
<script>
$(".types").on("click",function(e){
	if(
}
</script>
