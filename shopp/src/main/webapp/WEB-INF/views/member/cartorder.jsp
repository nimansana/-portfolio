<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
		width:100%;
	}
	.panel-heading{
		width:100%;
	}
	.updateMember th{
		text-align:right;
	}
	.col-lg-12{
		text-align: center;
	}
	.cartWrap{
		float:left;
		width:400px;
		height:300px;
		border: 4px solid rgba(30, 22, 54, 0.4);
		border-radius: 4px;
		padding:10px;
		margin: 20px 40px 20px 40px;
	}
	.cartTitle{
		text-align:center;
		width:100%;
		font-size: larger;
		margin-bottom: 5px;
	}
	.move{
		font-size:smaller;
		padding:5px 10px 5px 10px;
	}
	.cartImg{
		display:relative;
		float:left;
		width:50%;
		margin-right: 5px;
	}
	.cartData{
		display:relative;
		float:right;
		width:40%;
	}
	.datas{
		text-align: left;
		margin-bottom: 20px;
	}
	.datapart{
		display: inline-block;
	}
	.orderpart{
		margin-top: 100px;
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
	            	<form id="actionForm" action="/member/ordercart" method="post">
	            		<div class="datapart">
		            		<c:forEach items="${info }" var="info" varStatus="status">
								<input type="hidden" name="price${status.index}" value="${info.price }"/>
								<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
		        				<div class="cartWrap">
		        					<div class="cartTitle">
		        						<c:set var="title" value="${info.title }"/>
		        						<c:set var="lenTitle" value="${fn:length(title) }" />
		        						${fn:substring(title,0,30) }<c:if test="${lenTitle > 30}">···</c:if>
		        					</div>
		        					<hr style="margin:0 0 10px 0;">
		        					<div class="cartBody">
		        						<div class="cartImg">
		        							<img src="/resources/upload/2021/${info.uuid }_${info.filename}" style="width:200px;height:200px;"/>
		        						</div>
		        						<div class="cartData">
		        							<div class="datas">
		        								판매자 : ${info.writer }
		        							</div>
		        							<div class="datas">
		        								가격 : ${info.price }
		        							</div>
		        							<div class="datas">
		        								재고 : ${info.stack }
		        							</div>
		        							<div class="datas">
		        								주문 갯수 <input type="text" name="quantity" class="quanin${status.index }" value="${info.quantity }" style="width:50px;" readonly>
		        							</div>
		        						</div>
		        					</div>
		        				</div>
			                </c:forEach>
			            </div>
			            <hr>
						<div class="orderpart">
		            		<h2>주문자 정보</h2>
		            		<hr>
		               		<table class="table table-striped table-bordered table-hover">
								<tr>
		                        	<th>이 름</th>
		                        	<td><input type="text" name="orderName" placeholder="이름" /></td>
		                       	</tr>
		                        <tr>
		                        	<th>주 소</th>
		                        	<td>
		                        		<input type="text" name="orderaddress1" id="sample4_postcode" placeholder="우편번호">
										<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
										<input type="text" name="orderaddress2" id="sample4_roadAddress" placeholder="도로명주소">
										<input type="text" name="orderaddress3" id="sample4_jibunAddress" placeholder="지번주소">
										<span id="guide" style="color:#999;display:none"></span>
										<input type="text" name="orderaddress4" id="sample4_detailAddress" placeholder="상세주소">
										<input type="text" name="orderaddress5" id="sample4_extraAddress" placeholder="참고항목">
		                        	</td>
		                        </tr>
		                        <tr>
		                        	<th>전 화</th>
		                        	<td><input type="text" name="orderPhone" placeholder="전화번호"></td>
		                        </tr>
		                        <tr>
		                        	<th>총 금액</th>
		                        	<td><input type="text" name="totalprice" value="${totalprice }" readonly></td>
		                        </tr>
		            		</table>
		            	</div>
		            		
		            		
		            		<button type="submit" data-oper="modify" class="btn btn-default">주문하기</button>
		                	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
		                	<input type="hidden" name="userid" value="${info[0].userid}"/>
	                		<c:forEach items="${info }" var="info">
	                			<input type="hidden" name="bno" value="${info.bno}"/>
							</c:forEach>
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
<%@include file="../include/footer.jsp" %>
            