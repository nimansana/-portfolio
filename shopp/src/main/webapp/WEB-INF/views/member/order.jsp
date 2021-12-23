<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="../include/header.jsp" %>

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
					<h1 class="page-header">주문하기</h1>
					<hr>
	            </div>
	            <!-- /.panel-heading -->
	            <div class="panel-body" align=center>
	            	<form id="actionForm" action="order" method="post">
	            		<c:forEach items="${info }" var="info">
			                <table class="table table-striped table-bordered table-hover updateMember">
			                	<tr><th colspan=2 style="text-align:center; background:gray; font-size:larger; color:white;">고객 정보</th></tr>
		                        <tr>
		                            <th>아이디</th>
		                        	<td><input type="text" name="userid" value="${info.userid }" readonly></td>
		                        </tr>
		                        <tr>
		                        	<th>이 름</th>
		                        	<td><input type="text" name="userName" value="${info.userName }" readonly></td>
		                       	</tr>
		                        <tr>
		                        	<th>주 소</th>
		                        	<td><input type="text" name="address" value="${info.address }"></td>
		                        </tr>
		                        <tr>
		                        	<th>전 화</th>
		                        	<td><input type="text" name="phone" value="${info.phone }"></td>
		                        </tr>
		                        <tr>
		                        	<th>이메일</th>
		                        	<td><input type="text" name="email" value="${info.email }"></td>	
		                        </tr>
		                        <tr><th colspan=2 style="text-align:center; background:gray; font-size:larger; color:white;">배송 정보</th></tr>
								<tr>
		                        	<th>이 름</th>
		                        	<td><input type="text" name="orderName" placeholder="이름" /></td>
		                       	</tr>
		                        <tr>
		                        	<th>주 소</th>
		                        	<td><input type="text" name="orderAddress" placeholder="주소"></td>
		                        </tr>
		                        <tr>
		                        	<th>전 화</th>
		                        	<td><input type="text" name="orderPhone" placeholder="전화번호"></td>
		                        </tr>
			                </table>
			                <input type="hidden" name="state" value="" />
			                <input type="hidden" name="totalprice" value="1234" />
			                <input type="hidden" name="bno" value="${board.bno }" />
		                </c:forEach>
		                	<button type="submit" data-oper="modify" class="btn btn-default">주문하기</button>
		                	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
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
$(document).ready(function(){
	$('button').on("click",function(e){
		if(operation==='modify'){
			console.log("submit clicked");
			formObj.submit();
		}
		formObj.submit();
	});
});

</script>
<%@include file="../include/footer.jsp" %>
            