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
		width:80%;
	}
	.panel-heading{
		width:80%;
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
					<h1 class="page-header">정보 수정</h1>
					<hr>
				</div>
				<!-- /.panel-heading -->
				<div class="panel-body" align=center>
					<form id="actionForm" action="modify" method="post">
						<c:forEach items="${info }" var="info">
							<table class="table table-striped table-bordered table-hover updateMember">
								<tr>
									<th>아이디</th>
									<td><input type="text" name="userid" value="${info.userid }" readonly></td>
								</tr>
								<tr>
									<th>비밀번호</th>
									<td><input type="password" name="userpw" <%-- value="${info.userpw }" --%> width=100% class="pw" id="pw1"></td>
								</tr>
								<tr>
									<th>비밀번호 확인</th>
									<td>
										<input type="password" width=100% class="pw" id="pw2">
										<span id="alert-insert" style="display: inline-block;">비밀번호를 입력하세요.</span>
										<span id="alert-success" style="display: none; color:green;">비밀번호가 일치합니다.</span>
										<span id="alert-danger" style="display: none; color: #d92742; font-weight: bold; ">비밀번호가 일치하지 않습니다.</span>
									</td>
								</tr>                        
								<tr>
					              	<th>이 름</th>
					              	<td><input type="text" name="userName" value="${info.userName }" readonly></td>
								</tr>
								<tr>
									<th>주 소</th>
									<td>
		                        		<input type="text" name="address1" id="sample4_postcode" placeholder="우편번호">
										<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
										<input type="text" name="address2" id="sample4_roadAddress" placeholder="도로명주소">
										<input type="text" name="address3" id="sample4_jibunAddress" placeholder="지번주소">
										<span id="guide" style="color:#999;display:none"></span>
										<input type="text" name="address4" id="sample4_detailAddress" placeholder="상세주소">
										<input type="text" name="address5" id="sample4_extraAddress" placeholder="참고항목">
		                        	</td>
								</tr>
								<tr>
									<th>전 화</th>
									<td><input type="text" name="phone" value="${info.phone }"></td>
								</tr>
								<tr>
									<th>이메일</th>
									<td><input type="text" name="email" value="${info.email }"></td>	
								</tr>
								<tr>
									<th>권한</th>
									<td>
										<input id="whatAuth" type="hidden" value="${info.auth }">
										<select class="authBox" name="auth">
											<option value="ROLE_ADMIN">ROLE_ADMIN</option>
											<option value="ROLE_USER">ROLE_USER</option>
										</select>
									</td>
								</tr>
							</table>
						</c:forEach>
						<button type="submit" data-oper="modify" class="btn btn-default">수정</button>
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
if($('#whatAuth').val()=="ROLE_ADMIN"){
	$('.authBox option[value=ROLE_ADMIN]').prop('selected', 'selected').change();
}else{
	$('.authBox option[value=ROLE_USER]').prop('selected', 'selected').change();
}
$(document).ready(function(){
	$('button').on("click",function(e){
		if(operation==='modify'){
			console.log("submit clicked");
			formObj.submit();
		}
		formObj.submit();
	});
//	비밀번호 일치 여부 확인
	 $('.pw').focusout(function () {
	        var pwd1 = $("#pw1").val();
	        var pwd2 = $("#pw2").val();
	  
	        if ( pwd1 != '' && pwd2 == '' ) {
				null
	        } else if (pwd1 != "" || pwd2 != "") {
	            if (pwd1 == pwd2) {
	                $("#alert-insert").css('display', 'none');
	                $("#alert-success").css('display', 'inline-block');
	                $("#alert-danger").css('display', 'none');
					$("#regBtn").css('display', 'inline-block');

	            } else {
	                $("#alert-insert").css('display', 'none');
	                $("#alert-danger").css('display', 'inline-block');
	                $("#alert-success").css('display', 'none');
	                $("#regBtn").css('display', 'none');
	            }
	        }
	    });
});

</script>
<%@include file="../include/footer.jsp" %>
            