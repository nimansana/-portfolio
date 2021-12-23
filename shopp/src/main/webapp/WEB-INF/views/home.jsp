<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    
<%@include file="include/header.jsp" %>

<style>
.recommPaging{
	text-align:right;
}
.bodyTable tr:nth-child(2n) {
	height:300px;
	border-bottom:2px solid blue;
	text-align:center;
}
.bodyTable tr:nth-child(2n-1){
	height:50px;
}
.bodyTable{
	width:100%;
}
.bodyTable td{
	padding:0 20px 0 20px;
}
</style>
	
	<div align=center>
	
		<table class="bodyTable">
			<tr>
				<td colspan=3>추천상품1</td>
				<td class="recommPaging">|페이징|</td>
			</tr>
			<tr>
				<td>|상품 나열1|</td>
				<td>|상품 나열2|</td>
				<td>|상품 나열3|</td>
				<td>|상품 나열4|</td>
			</tr>
			<tr>
				<td colspan=3>추천상품2</td>
				<td class="recommPaging">|페이징|</td>
			</tr>
			<tr>
				<td>|상품 나열1|</td>
				<td>|상품 나열2|</td>
				<td>|상품 나열3|</td>
				<td>|상품 나열4|</td>
			</tr>
						<tr>
				<td colspan=3>추천상품3</td>
				<td class="recommPaging">|페이징|</td>
			</tr>
			<tr>
				<td>|상품 나열1|</td>
				<td>|상품 나열2|</td>
				<td>|상품 나열3|</td>
				<td>|상품 나열4|</td>
			</tr>
						<tr>
				<td colspan=3>추천상품4</td>
				<td class="recommPaging">|페이징|</td>
			</tr>
			<tr>
				<td>|상품 나열1|</td>
				<td>|상품 나열2|</td>
				<td>|상품 나열3|</td>
				<td>|상품 나열4|</td>
			</tr>
			<tr>
				<td colspan=3>추천상품5</td>
				<td class="recommPaging">|페이징|</td>
			</tr>
			<tr>
				<td>|상품 나열1|</td>
				<td>|상품 나열2|</td>
				<td>|상품 나열3|</td>
				<td>|상품 나열4|</td>
			</tr>
		</table>
	</div>
	<!-- /.body -->
	
	
	
<%@include file="include/footer.jsp" %>
	