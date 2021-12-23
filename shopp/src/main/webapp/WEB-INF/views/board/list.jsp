<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style>
	.paging-div {
	  padding: 15px 0 5px 10px;
	  display: table;
	  margin-left: auto;
	  margin-right: auto;
	  text-align: center;
	}
</style>
<%@include file="../include/header.jsp" %>

<link href="/resources/vendor/datatables/css/jquery.dataTables.css" rel="stylesheet" />

<div class="aaa">
	<div class="row">
	    <div class="col-lg-12">
	        <div class="panel panel-default">
	            <div class="panel-heading">
					<h1 class="page-header">공지사항</h1>
	                <button id='regBtn' type="button" class="btn btn-xs pull-right">새글 등록</button>
	            </div>
	            <!-- /.panel-heading -->
	            <div class="panel-body">
	                <table class="table table-striped table-bordered table-hover">
	                    <thead>
	                        <tr>
	                            <th>#번호</th>
	                            <th>제목</th>
	                            <th>작성자</th>
	                            <th>작성일</th>
	                            <th>수정일</th>
	                        </tr>
	                    </thead>
	                    
	                    <tbody>
	                    <c:forEach items="${list }" var="board">
	                    	<tr>
	                     	<td>${board.bno }</td>
	                     	<td><a class='move' href='${board.bno }'>${board.title } <b>[${board.replyCnt }]</b></a></td>
	                     	<td>${board.writer }</td>
	                     	<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate }"/></td>
	                     	<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate }"/></td>
	                    	</tr>
	                    </c:forEach>
	                    </tbody>                    
	                </table>
	                
	                <!-- 검색 처리 -->
	                <div class='row'>
	                	<div class='col-lg-12'>
	                		<form id='searchForm' action="/board/list" method='get'>
	                			<table>
	                				<tr>
	                					<td>
				                			<select name='type'>
				                				<option value="" ${pageMaker.cri.type==null?'selected':'' }>--</option>
				                				<option value="T" ${pageMaker.cri.type eq 'T'?'selected':'' }>제목</option>
				                				<option value="C" ${pageMaker.cri.type eq 'C'?'selected':'' }>내용</option>
				                				<option value="W" ${pageMaker.cri.type eq 'W'?'selected':'' }>작성자</option>
				                				<option value="TC" ${pageMaker.cri.type eq 'TC'?'selected':'' }>제목 or 내용</option>
				                				<option value="TW" ${pageMaker.cri.type eq 'TW'?'selected':'' }>제목 or 작성자</option>
				                				<option value="TWC" ${pageMaker.cri.type eq 'TWC'?'selected':'' }>제목 or 내용 or 작성자</option>
				                			</select>
				                		</td>
	                					<td>
				                			<input class="form-control" type='text' name='keyword' value='${pageMaker.cri.keyword }'>
				                			<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'>
				                			<input type='hidden' name='amount' value='${pageMaker.cri.amount }'>
				                		</td>
				                		<td>
		                    				<button class="btn btn-primary" id="btnNavbarSearch" type="button"><i class="fas fa-search"></i></button>
		                    			</td>
		                    		</tr>
	                    		</table>
	                		</form>
	                	</div>                	
	                </div>
	                
	                <!-- 페이지 처리 -->
	                <div class='pull-right'>
	                	<ul class="pagination">
	                		<c:if test="${pageMaker.prev }">
	                			<li class="paginate_button previous">
	                				<a href="${pageMaker.startPage-1 }">Previous</a>
	                			</li>
	                		</c:if>
	                		
	                		<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
	                			<li class="paginate_button ${pageMaker.cri.pageNum==num?'active':'' }">
	                				<a href="${num }">${num }</a>
	                			</li>
	                		</c:forEach>
	                		
	                		<c:if test="${pageMaker.next }">
	                			<li class="paginate_button next">
	                				<a href="${pageMaker.endPage+1 }">Next</a>
	                			</li>
	                		</c:if>
	                	</ul>
	                </div>
	                
	                <form id="actionForm" action="/board/list" method="get">	                
	                	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
	                	<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
	                	<input type="hidden" name="type" value="${pageMaker.cri.type }">
	                	<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
	                </form>
	                
	                <!-- 모달창 처리 -->
	                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	                	<div class="modal-dialog">
	                		<div class="modal-content">
	                			<div class="modal-header">
	                				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                				<h4 class="modal-title" id="myModalLabel">Modal title</h4>
	                			</div>
	                			<div class="modal-body">처리가 완료되었습니다.</div>
	                			<div class="modal-footer">
	                				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	                				<button type="button" class="btn btn-primary">Save changes</button>
	                			</div>
	                		</div>
	                	</div>
	                </div><!-- /.modal -->
	                
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
	var result='<c:out value="${result}"/>';
	
	checkModal(result);
	
	history.replaceState({},null,null);
	
	function checkModal(result){
		
		if(result==='' || history.state){
			return;
		}
		
		if(parseInt(result)>0){
			$(".modal-body").html("게시글 "+parseInt(result)+" 번이 등록되었습니다.");
		}
		$("#myModal").modal("show");
	}
	
	$("#regBtn").on("click",function(){
		self.location="/board/register";
	});
	
	//페이지 처리
	var actionForm=$("#actionForm");
	
	$(".paginate_button a").on("click",function(e){
		e.preventDefault();
		console.log('click');
		
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
	
	//게시물 조회 이벤트 처리
	$(".move").on("click",function(e){
		e.preventDefault();
		
		actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>'");
		actionForm.attr("action","/board/get");
		actionForm.submit();
	});
	
	//검색 버튼 이벤트 처리
	var searchForm=$("#searchForm");
	
	$("#searchForm button").on("click",function(e){
		
		/* if(!searchForm.find("option:selected").val()){
			alert("검색 종류를 선택하세요");
			return false;
		}		
		if(!searchForm.find("input[name='keyword']").val()){
			alert("키워드를 입력하세요");
			return false;
		} */
		
		searchForm.find("input[name='pageNum']").val("1");
		e.preventDefault();
		
		searchForm.submit();
	});
});
</script>

<%@include file="../include/footer.jsp" %>
            