<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="../include/adminHeader.jsp" %>

<style>
	.paging-div {
	  padding: 15px 0 5px 10px;
	  display: table;
	  margin-left: auto;
	  margin-right: auto;
	  text-align: center;
	}
 	.updateMember{
		width:50%;
	}
	.panel-heading{
		width:50%;
	}
	.updateMember th{
		text-align:right;
	}
</style>


<div class="aaa">
	<div class="row">
	    <div class="col-lg-12">
	    
			<div class="panel panel-default" align=center>
				<div class="panel-heading">
					<h1 class="page-header">관리자 모드</h1>
					<hr>
				</div>
			</div>
			<!-- /.panel -->	    
	    </div>
	    <!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->
</div>            
<%@include file="../include/footer.jsp" %>
            