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
					<h1 class="page-header">회원 가입</h1>
					<hr>
	            </div>
	            <!-- /.panel-heading -->
	            <div class="panel-body" align=center>
	            	<form id="actionForm" action="/member/joinMember" method="post">
		                <table class="table table-striped table-bordered table-hover updateMember">
	                        <tr>
	                            <th>아이디</th>
	                        	<td><div style="position:relative; width:30%"><input type="text" class="userid" name="userid" value="${userid}" placeholder="아이디" /><button class="isId btn btn-default pull-right">중복확인</button></div></td>
	                        </tr>
	                        <tr>
	                        	<th>비밀번호</th>
	                        	<td><input type="password" name="userpw" width=100% class="pw" id="pw1" placeholder="비밀번호"></td>
	                        </tr>
	                        <tr>
	                        	<th>비밀번호 확인</th>
	                        	<td>
	                        		<input type="password" width=100% class="pw" id="pw2" placeholder="비밀번호 확인">
	                        		<span id="alert-insert" style="display: inline-block; color: #d92742">비밀번호를 입력하세요.</span>
	                        		<span id="alert-success" style="display: none; color:green;">비밀번호가 일치합니다.</span>
	    							<span id="alert-danger" style="display: none; color: #d92742; font-weight: bold; ">비밀번호가 일치하지 않습니다.</span>
	    						</td>
	                        </tr>                        
	                        <tr>
	                        	<th>이 름</th>
	                        	<td><input type="text" name="userName" placeholder="이름" /></td>
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
	                        	<td><input type="text" name="phone" placeholder="전화번호"></td>
	                        </tr>
	                        <tr>
	                        	<th>이메일</th>
	                        	<td><input type="text" name="email" placeholder="이메일"></td>	
	                        </tr>
		                </table>
<!-- 		                <input type="hidden" name="enabled" value="1" />
		                <input type="hidden" name="authList" value="ROLE_USER" />
 -->	                	<button class="btn btn-default join">가입</button>
	                	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
	                	<input type="hidden" class="checkId" value="${isId }">
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
$(".isId").on("click",function(e){
	$("#actionForm").append("<input type='hidden' name='isId' value='1'>");
	$("#actionForm").submit();
})
$(".join").on("click",function(e){
	$("#actionForm").append("<input type='hidden' name='isId' value='a'>");
	$("#actionForm").submit();
})
</script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>  
<script>
$(document).ready(function(){
	console.log($(".checkId").val());
	(function(){
		if($(".checkId").val()==1){
			alert("중복된 아이디 입니다.");
		}else if($(".checkId").val()==2){
			alert("사용 가능한 아이디 입니다.");
		}
	})();
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
            