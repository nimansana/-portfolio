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
	align-centent:center;
	text-align:center;
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
	            <div class="panel-heading">
					<h1 class="page-header">공지사항</h1>
	            	<div class="panel-body">
	           		<div class="form-group">
	           			<label>Bno</label>
	           			<input class="form-control" name="bno" readonly="readonly" value="${board.bno }">
	           		</div>
	           		<div class="form-group">
	           			<label>Title</label>
	           			<input class="form-control" name="title" readonly="readonly" value="${board.title }">
	           		</div>
	           		<div class="form-group">
	           			<label>Text area</label>
	           			<textarea class="form-control" rows="3" name="content" readonly="readonly">${board.content }</textarea>
	           		</div>
	           		<div class="form-group">
	           			<label>Writer</label>
	           			<input class="form-control" name="writer" readonly="readonly" value="${board.writer }">
	           		</div>
	           		
	           		<sec:authentication property="principal" var="pinfo"/>
	           		<sec:authorize access="isAuthenticated()">
	           			<c:if test="${pinfo.username eq board.writer }">
	           				<button data-oper="modify" class="btn btn-default">수정</button>
	           			</c:if>
	           		</sec:authorize>
	           		
	           		<button data-oper="list" class="btn btn-info">목록</button>
	           		
	           		<form id="operForm" action="/board/modify" method="get">
	           			<input type='hidden' id='bno' name='bno' value="${board.bno }">
	           			<input type='hidden' name='pageNum' value="${cri.pageNum }">
	           			<input type='hidden' name='amount' value="${cri.amount }">
	           			<input type="hidden" name="type" value="${cri.type }">
	                	<input type="hidden" name="keyword" value="${cri.keyword }">
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
</div>

<div class='bigPictureWrapper'>
	<div class='bigPicture'>
	</div>
</div>

<div class="row">
	<div class="col-lg-12">		
		<div class="panel panel-default">
		
			<div class="panel-heading">첨부파일</div>
			<div class="panel-body">				
				
				<div class="uploadResult">
					<ul>
					</ul>
				</div>
			</div>
		
		</div>
	</div>
</div>

<div class='row'>
	<div class='col-lg-12'>
	
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i>댓글
				
				<sec:authorize access="isAuthenticated()">
					<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>새 댓글</button>
				</sec:authorize>
			</div>
			
			<div class="panel-body">
				<ul class="chat">
					<li class="left clearfix" data-rno='12'>
						<div>
							<div class="header">
								<strong class="primary-font">user00</strong>
								<small class="pull-right text-muted">2021-11-08 15:18</small>
							</div>
							<p>Good job!</p>
						</div>
					</li>
				</ul>
			</div>
			
			<div class="panel-footer">			
			</div>
			
		</div><!-- panel -->
	</div><!-- col -->
</div><!-- row -->

<!-- 모달창 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
		
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">댓글 MODAL</h4>
			</div>
			
			<div class="modal-body">
				<div class="form-group">
					<label>Reply</label>
					<input class="form-control" name="reply" value="New Reply!!!">
				</div>
				<div class="form-group">
					<label>Replyer</label>
					<input class="form-control" name="replyer" value="replyer" readonly="readonly">
				</div>
				<div class="form-group">
					<label>Reply Date</label>
					<input class="form-control" name="replyDate" value="">
				</div>
			</div>
			
			<div class="modal-footer">
				<button id="modalModBtn" type="button" class="btn btn-warning">수정</button>
				<button id="modalRemoveBtn" type="button" class="btn btn-danger">삭제</button>
				<button id="modalRegisterBtn" type="button" class="btn btn-primary">등록</button>
				<button id="modalCloseBtn" type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			</div>
			
		</div>
	</div>
</div>

<script src="/resources/js/reply.js"></script>
<script>
$(document).ready(function(){
	
	var bnoValue='${board.bno}';
	var replyUL=$(".chat");
	
	showList(1);
	
	function showList(page){
		replyService.getList(
				{bno:bnoValue,page:page},
			function(replyCnt,list){
			
				console.log("get replyCnt:"+replyCnt);
				//console.log("get list[0].rno:"+list[0].rno);
				
				if(page==-1){
					pageNum=Math.ceil(replyCnt/10.0);
					showList(pageNum);
					return;
				}
				
				if(list==null || list.length==0){
					replyUL.html("");				
					return;
				}
							
				var str="";
				for(var i=0;i<list.length;i++){
					str+="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
					str+="	<div>";
					str+="		<div class='header'>";
					str+="			<strong class='primary-font'>"+list[i].replyer+"</strong>";
					str+="			<small class='pull-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small>";
					str+="		</div>";
					str+="		<p>"+list[i].reply+"</p>";
					str+="	</div>";
					str+="</li>";				
				}
				
				console.log(str);
				
				replyUL.html(str);
				
				showReplyPage(replyCnt);
			});
	}
	
	var modal=$(".modal");
	var modalInputReply=modal.find("input[name='reply']");
	var modalInputReplyer=modal.find("input[name='replyer']");
	var modalInputReplyDate=modal.find("input[name='replyDate']");
	
	var modalModBtn=$("#modalModBtn");
	var modalRemoveBtn=$("#modalRemoveBtn");
	var modalRegisterBtn=$("#modalRegisterBtn");
	
	var replyer=null;
	
	<sec:authorize access="isAuthenticated()">
		replyer='<sec:authentication property="principal.username"/>';
	</sec:authorize>
	
	var csrfHeaderName="${_csrf.headerName}";
	var csrfTokenValue="${_csrf.token}";
	
	$("#addReplyBtn").on("click",function(e){
		modal.find("input").val("");
		modal.find("input[name='replyer']").val(replyer);
		modalInputReplyDate.closest("div").hide();
		modal.find("button[id='modalModBtn']").hide();
		modal.find("button[id='modalRemoveBtn']").hide();
		
		$(".modal").modal("show");
	});
	
	//Ajax spring 시큐러티 header...
	$(document).ajaxSend(function(e,xhr,options){
		xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
	});
	
	modalRegisterBtn.on("click",function(e){
		var reply={
				reply:modalInputReply.val(),
				replyer:modalInputReplyer.val(),
				bno:bnoValue
		};
		replyService.add(reply,function(result){
			alert(result);
			
			modal.find("input").val("");
			modal.modal("hide")
			
			showList(-1);
		});
	});
	
	$(".chat").on("click","li",function(e){
		var rno=$(this).data("rno");		
		console.log(rno);
		
		replyService.get(rno,function(reply){
			modalInputReply.val(reply.reply);
			modalInputReplyer.val(reply.replyer);
			modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly","readonly");
			modal.data("rno",reply.rno);
			
			modalRegisterBtn.hide();
			
			$(".modal").modal("show");
		});
		
	});
	
	modalModBtn.on("click",function(e){
		console.log("수정클릭");
		
		var originalReplyer=modalInputReplyer.val();
		console.log("Original Replyer:"+originalReplyer);
		
		var reply={
				rno:modal.data("rno"),
				reply:modalInputReply.val(),
				replyer:originalReplyer
		};
				
		if(!replyer){
			alert("로그인후 수정이 가능합니다.");
			modal.modal("hide");
			return;
		}
		
		if(replyer!=originalReplyer){
			alert("자신이 작성한 댓글만 수정이 가능합니다.");
			modal.modal("hide");
			return;
		}		
		
		replyService.update(reply,function(result){
			alert(result);
			modal.modal("hide");
			showList(pageNum);
		});
	});
	
	modalRemoveBtn.on("click",function(e){
		console.log("삭제클릭");
		var rno=modal.data("rno");
		
		console.log("RNO:"+rno);
		console.log("REPLYER:"+replyer);
		
		if(!replyer){
			alert("로그인후 삭제가 가능합니다.");
			modal.modal("hide");
			return;
		}
		
		var originalReplyer=modalInputReplyer.val();
		console.log("Original Replyer:"+originalReplyer);
		
		if(replyer!=originalReplyer){
			alert("자신이 작성한 댓글만 삭제가 가능합니다.");
			modal.modal("hide");
			return;
		}
		
		replyService.remove(rno,originalReplyer,function(result){
			alert(result);
			modal.modal("hide");
			showList(pageNum);
		});
	});
	
	//페이징 처리
	var pageNum=1;
	var replyPageFooter=$(".panel-footer");
	
	function showReplyPage(replyCnt){
		var endNum=Math.ceil(pageNum/10.0)*10;
		var startNum=endNum-9;
		
		var prev=startNum != 1;
		var next=false;
		
		if(endNum*10>=replyCnt){
			endNum=Math.ceil(replyCnt/10.0);
		}
		if(endNum*10<replyCnt){
			next=true;
		}
		
		var str="<ul class='pagination pull-right'>";
		
		if(prev){
			str+="<li class='page-item'>";
			str+="	<a class='page-link' href='"+(startNum-1)+"'>Previous</a>";
			str+="</li>";
		}
		
		for(var i=startNum;i<=endNum;i++){
			var active=pageNum==i?"active":"";
			
			str+="<li class='page-item "+active+"'>";
			str+="	<a class='page-link' href='"+i+"'>"+i+"</a>";
			str+="</li>";			
		}
		
		if(next){
			str+="<li class='page-item'>";
			str+="	<a class='page-link' href='"+(endNum+1)+"'>Next</a>";
			str+="</li>";
		}
		
		str+="</ul>";
		
		/* console.log(str); */
		
		replyPageFooter.html(str);
	}
	
	replyPageFooter.on("click","li a",function(e){
		e.preventDefault();
		console.log("page click");
		
		var targetPageNum=$(this).attr("href");
		console.log("targetPageNum:"+targetPageNum);
		
		pageNum=targetPageNum;
		showList(pageNum);
	});
	
});

/*
replyService.add(
	{bno:bnoValue,reply:"JS Test",replyer:"tester"},
	function(result){
		alert("RESULT:"+result);
	});

replyService.getList({bno:bnoValue,page:1},
		function(list){
			for(var i=0;i<list.length;i++){
				console.log(list[i]);
			}
		});

replyService.remove(4,function(result){
	alert("RESULT:"+result);
	
	if(result==="success"){
		alert("삭제 성공");
	}
},function(err){
	alert("삭제 실패...");
});

replyService.update(
	{rno:5,bno:bnoValue,reply:"수정 답변....."},
	function(result){
		alert("수정 완료..."+result);
	});

replyService.get(5,function(data){
	console.log(data);
});
*/
</script>

<script>
$(document).ready(function(){
	var operForm=$("#operForm");

	$("button[data-oper='modify']").on("click",function(e){
		operForm.submit();
	});
	
	$("button[data-oper='list']").on("click",function(e){
		operForm.find("#bno").remove();
		operForm.attr("action","/board/list")
		operForm.submit();
	});
	
});

$(document).ready(function(){
	(function(){
		var bno='${board.bno}';
		
		$.getJSON("/board/getAttachList",{bno:bno},function(arr){
			console.log(arr);
			
			var str="";
			
			$(arr).each(function(i,attach){
				console.log(attach.fileType);
								
				if(attach.fileType){
					console.log(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);
					
					var fileCallPath=encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);
					console.log(fileCallPath);
					
					str+="<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'>"+						 
						 "		<img src='/display?fileName="+fileCallPath+"'>"+
						 "</li>";
				}else{					
					str+="<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'>"+
						 "		<span>"+attach.fileName+"</span><br>"+						 
						 "		<img src='/resources/img/attach.png'>"+
						 "</li>";
				}
			});
			
			$(".uploadResult ul").html(str);
		});
	})();
	
	$(".uploadResult").on("click","li",function(e){
		console.log("view image");
		
		var liObj=$(this);
		
		var path=encodeURIComponent(liObj.data("path")+"/"+liObj.data("uuid")+"_"+liObj.data("filename"));
						
		console.log(liObj.data("path"));
		console.log(liObj.data("uuid"));
		console.log(liObj.data("filename"));
		console.log(liObj.data("type"));
		
		if(liObj.data("type")){
			showImage(path.replace(new RegExp(/\\/g),"/"));
		}else{		
			self.location="/download?fileName="+path;
		}
	});
	
	function showImage(fileCallPath){
		alert(fileCallPath);
		
		$(".bigPictureWrapper").css("display","flex").show();
		
		$(".bigPicture")
		.html("<img src='/display?fileName="+fileCallPath+"'>")
		.animate({width:'100%',height:'100%'},1000);
	}
	
	$(".bigPictureWrapper").on("click",function(e){
		$(".bigPicture").animate({width:'0%',height:'0%'},1000);
		setTimeout(function(){
			$('.bigPictureWrapper').hide();
		},1000);
	});
});
</script>

<%@include file="../include/footer.jsp" %>
            