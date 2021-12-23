<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@include file="../include/header.jsp" %>

<style>
.uploadResult{
	width:100%;
	background:gray;
}
.uploadResult ul{
	display:flex;
	flex-flow:row;
	justify-content:center;
	align-items:center;
}
.uploadResult ul li{
	list-style:none;
	padding:10px;
}
.uploadResult ul li img{
	width:100px;
}
.uploadResult ul li span{
	color:white;
}
.bigPictureWrapper{
	position:absolute;
	display:none;
	justify-content:center;
	align-items:center;
	top:0%;
	width:100%;
	height:100%;
	background:gray;
	z-index:100;
	background:rgba(255,255,255,0.5);
}
.bigPicture{
	position:relative;
	display:flex;
	justify-content:center;
	align-items:center;
}
.bigPicture img{
	width:600px;
}
</style>

<div class="aaa">
	<div class="row">
	    <div class="col-lg-12">
	        <div class="panel panel-default">
				<h1 class="page-header">공지 사항</h1>
	        	<hr>
	            <!-- /.panel-heading -->
	            <div class="panel-body">
	            
	            	<form role="form" action="/notice/register" method="post">
	            	
	            		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
	            		
	            		<div class="form-group">
	            			<label>Title</label>
	            			<input class="form-control" name="title">
	            		</div>
	            		<div class="form-group">
	            			<label>Text area</label>
	            			<textarea class="form-control" rows="3" name="content"></textarea>
	            		</div>
	            		<div class="form-group">
	            			<label>Writer</label>
	            			<input class="form-control" name="writer"
	            				value='<sec:authentication property="principal.username"/>' readonly="readonly">
	            		</div>
	            		<hr>
	            		<button type="submit" class="btn btn-default" onmouseover="this.style.background='#46C6C6';">작성</button>
						<button type="reset" class="btn btn-default reset" onmouseover="this.style.background='#E16A9D';">취소</button>
	            	</form>
	                                
	            </div>
	            <!-- /.panel-body -->
	        </div>
	        <!-- /.panel -->
	    </div>
	    <!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->
</div>

<script>
$(document).ready(function(e){
	$(".reset").on("click",function(e){
		alert("글 작성이 취소 되었습니다.");
		history.back();
	})
});
</script>

<%@include file="../include/footer.jsp" %>
            