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
		width:100%;
		text-align: left;
		font-size: larger;
		margin-bottom:30px;
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
</style>


<div class="aaa">
	<div class="row">
	    <div class="col-lg-12">
	        <div class="panel panel-default" align=center>
	            <div class="panel-heading">
					<h1 class="page-header">장바구니</h1>
					<hr>
	            </div>
	            <!-- /.panel-heading -->
	            <div class="panel-body" align=center>
	            	<form id="actionForm" action="/member/cartorder" method="get">
	            		<c:forEach items="${info }" var="info" varStatus="status">
	            			<input type="checkbox" name="cartnum" value="${info.cartnum }" class="buyprod${status.index }" checked style="display:none;"/>
	            			<input type="checkbox" name="quantity" value="" class="quanin${status.index }" checked style="display:none;"/>
	            		</c:forEach>
	            	</form>
	            	<c:if test="${empty info}"> 장바구니가 비었습니다 </c:if>
	            		<c:forEach items="${info }" var="info" varStatus="status">
							<input type="hidden" name="price${status.index}" value="${info.price }"/>
	        				<div class="cartWrap">
	        					<div class="cartTitle">
	        						<c:set var="title" value="${info.title }"/>
	        						<c:set var="lenTitle" value="${fn:length(title) }" />
	        						<input type="checkbox" name="sumarray" class="sumarraydel${status.index }" value="${status.index }" checked/>&nbsp;${fn:substring(title,0,20) }<c:if test="${lenTitle > 20}">···</c:if> <a class='button move' href='/member/delete?cartnum=${info.cartnum }&userid=${info.userid}' style="float:right;">X</a>
	        					</div>
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
        									주문 갯수: <input type="text" id="count${status.index }" name="changeQuan" class="quanin${status.index }" value="${info.quantity }" style="width:50px;text-align:center;">
	        							</div>
	        						</div>
	        					</div>
	        				</div>
		                </c:forEach>
	            </div>
	            <!-- /.panel-body -->
	        </div>
	        <!-- /.panel -->
	    </div>
	    <!-- /.col-lg-12 -->
	    <p id="sum_price">총 합계 금액: ${sumprice }￦</p>
       	<button type="submit" data-oper="modify" class="btn btn-default">수정</button>
       	<button type="submit" data-oper="order" class="btn btn-default">결제</button>
	</div>
	<!-- /.row -->
</div>        
<script>
$(document).ready(function(){
	
	var operForm=$("#actionForm");
	
	$("button[data-oper='order']").on("click",function(e){
		var len = $("input[name=sumarray]").length;
		
		/* for(var i=0; i<len; i++){
			var quanin = $(".quanin"+i).val();
			operForm.append("<input type='hidden' name='quantity' value='"+quanin+"'>'");
		} */
		operForm.submit();
	});
	
	$("input[name=sumarray]").change(function(){
		var len = $("input[name=sumarray]").length;
		
		for(var i=0; i<len; i++){
			console.log("len: "+len);
			var ischecked = true;
			
			if($(".sumarraydel"+i).is(":checked")){
				ischecked = true;
			}else{
				ischecked = false;
			}
			console.log("i: "+i);
			if(ischecked){
				$(".quanin"+i).attr("checked",true);
				$(".buyprod"+i).attr("checked", true);
			}else{
				$(".quanin"+i).attr("checked",false);
				$(".buyprod"+i).attr("checked", false);
			}
		}
		console.log("======================================");
	})
	
	//////////////////////버튼 submit주소 바꾸기///////////////////
	/* var operForm=$("#modifyForm"); */
	
	$("button[data-oper='modify']").on("click",function(e){
		operForm.submit();
	});	

	////////////////////함수////////////
	var cartprice=0;
	var price=0;
	var count=0;
	
	var len = $("input[name=sumarray]").length;
	for(var i=0; i<len; i++){
		$(".quanin"+i).val($("input[id='count"+i+"']").val());
	}
	
	var checkVal = new Array();
	
	function cal(checkVal){
		cartprice=0;
		
		for(var i in checkVal){
			price=parseInt($("input[name='price"+checkVal[i]+"']").val());
			count=$("input[id='count"+checkVal[i]+"']").val();
			$("#quanin"+i).val($("input[id='count"+checkVal[i]+"']").val());
			cartprice+=price*count;
		}
	}
	
	
	$("input[name=sumarray]:checked").each(function(){
		
		checkVal.push($(this).val());
		
	});
	
	
	///////////////////////////////
	$("input[name=sumarray]").change(function(){
		var checkVal=new Array();
		$("input[name=sumarray]:checked").each(function(){
			checkVal.push($(this).val());
		});
		cal(checkVal);
		$("#sum_price").text("총 합계 금액: "+cartprice+"￦");
	});
		
	$("input").change(function(){
		var checkVal=new Array();
		$("input[name=sumarray]:checked").each(function(){
			checkVal.push($(this).val());
		});
		cal(checkVal);				
		$("#sum_price").text("총 합계 금액: "+cartprice+"￦");
	});
});
</script>
<%@include file="../include/footer.jsp" %>
            