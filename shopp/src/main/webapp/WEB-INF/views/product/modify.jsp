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
<script>
(function selected(){
	var types=${types};
	var category=${category};
	
	if(types=="outer"){
		$(".outers").attr("selected","selected");
	}else if (types=="top") {
		$(".tops").attr("selected","selected");	
	}else if (types=="pants") {
		$(".pantses").attr("selected","selected");
	}
}())
</script>
<div class="aaa">
	<!-- /.row -->
	<div class="row">
	    <div class="col-lg-12">
	        <div class="panel panel-default">
				<h1 class="page-header">Product</h1>
		        <hr>
	            <!-- /.panel-heading -->
	            <div class="panel-body">
	                
	                <form role="form" action="/product/modify" method="post">
	            		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
	                
	                	<input type='hidden' name='pageNum' value="${cri.pageNum }">
	           			<input type='hidden' name='amount' value="${cri.amount }">
	           			<input type="hidden" name="type" value="${cri.type }">
	                	<input type="hidden" name="keyword" value="${cri.keyword }">
	            		<input type="hidden" name="bno" value="${board.bno }">
	            		<div class="form-group">
	            			<select name="types" id="selectType" onchange="changeSelect()">
	            				<option value="">??? ???</option>
	            				<option value="outer" class="outers">?????????</option>
	            				<option value="top" class="tops">??? ???</option>
	            				<option value="pants" class="pantses">??? ???</option>
	            			</select>
	            			<select name="category" id="selectCategory">
	            				<option value="" class="trash">????????? ????????? ?????????</option>
	            				<option value='padding' class="outer" style="display:none;">??????</option>
	            				<option value='coat' class="outer" style="display:none;">??????</option>
	            				<option value='jacket' class="outer" style="display:none;">??????</option>
	            				<option value='short' class="top" style="display:none;">?????? ???</option>
	            				<option value='long' class="top" style="display:none;">?????? ???</option>
	            				<option value='shirts' class="top" style="display:none;">??? ???</option>
	            				<option value='denim' class="pants" style="display:none;">?????? ??????</option>
	            				<option value='shorts' class="pants" style="display:none;">??? ??????</option>
	            				<option value='slacks' class="pants" style="display:none;">?????????</option>
	            			</select>
	            		</div>
	            		<br>
	            		
	            		<div class="form-group">
	            			<label>??????</label>
	            			<input class="form-control" name="title" value="${board.title }">
	            		</div>
	            		<div class="form-group">
	            			<label>??????</label>
	            			<input class="form-control" name="price" value="${board.price }">
	            		</div>
	            		<div class="form-group">
	            			<label>??????</label>
	            			<textarea class="form-control" rows="3" name="content">${board.content }</textarea>
	            		</div>
	            		<div class="form-group">
	            			<label>Writer</label>
	            			<input class="form-control" name="writer"
	            				value="${board.writer }" readonly="readonly">
	            		</div>
	            	</form>
	            </div>
	            <!-- /.panel-body -->
	        </div>
	        <!-- /.panel -->
	    </div>
	    <!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->            
	<div class='bigPictureWrapper'>
		<div class='bigPicture'>
		</div>
	</div>
	
	<div class="row">
		<div class="col-lg-12">		
			<div class="panel panel-default">
			
				<div class="panel-heading">????????????</div>
				<div class="panel-body">
					<div class="form-group uploadDiv">
						<input type="file" name='uploadFile' multiple="multiple">
					</div>
					
					<div class="uploadResult">
						<ul>
						</ul>
					</div>
				</div>
				<hr>
				<sec:authentication property="principal" var="pinfo"/>
					<sec:authorize access="isAuthenticated()">
						<c:if test="${pinfo.username eq board.writer }">
							<button type="submit" data-oper="modify" class="btn btn-default" onmouseover="this.style.background='#46C6C6';">??????</button>
							<button type="submit" data-oper="remove" class="btn btn-default" onmouseover="this.style.background='#E16A9D';">??????</button>
						</c:if>
					</sec:authorize>
				<button type="submit" data-oper="list" class="btn btn-default" onmouseover="this.style.background='#6482B9';">??????</button>
			</div>
		</div>
	</div>
</div>

<script>
function changeSelect(){
		var selectedType = $("#selectType option:selected").val();
		var selected = $("#selectType option:selected").text();

		switch (selectedType){
		  case "outer" :
			  $(".outer").css("display","inline-block");
			  $(".top").css("display","none");
			  $(".pants").css("display","none");
			  $(".trash").css("display","none");
		      break;
		  case "top" :
			  $(".top").css("display","inline-block");
			  $(".outer").css("display","none");
			  $(".pants").css("display","none");
			  $(".trash").css("display","none");
		      break;
		  case "pants" :
			  $(".pants").css("display","inline-block");
			  $(".top").css("display","none");
			  $(".outer").css("display","none");
			  $(".trash").css("display","none");
		      break;
		  default :
			$(".trash").css("display","inline-block");
			$(".top").css("display","none");
		  	$(".outer").css("display","none");
		  	$(".pants").css("display","none");
		}
	}
</script>

<script>
$(document).ready(function(){
	var formObj=$("form");
	
	$('button').on("click",function(e){
		e.preventDefault();
		
		var operation=$(this).data("oper");
		console.log(operation);
		
		if(operation==='remove'){
			formObj.attr("action","/product/remove");
		}else if(operation==='list'){
			formObj.attr("action","/product/list").attr("method","get");
			
			var pageNumTag=$("input[name='pageNum']").clone();
			var amountTag=$("input[name='amount']").clone();
			var keywordTag=$("input[name='keyword']").clone();
			var typeTag=$("input[name='type']").clone();
			
			formObj.empty();	//form ?????? ????????? ??????
			
			formObj.append(pageNumTag);
			formObj.append(amountTag);
			formObj.append(keywordTag);
			formObj.append(typeTag);
		}else if(operation==='modify'){
			console.log("submit clicked");
			
			var str="";
			
			$(".uploadResult ul li").each(function(i,obj){
				var jobj=$(obj);
				console.dir(jobj);
				
				str+="<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
				str+="<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
				str+="<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
				str+="<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
			});
			formObj.append(str);
			formObj.submit();
		}
		
		formObj.submit();
	});
});

$(document).ready(function(){
	(function(){
		var bno='${board.bno}';
		
		$.getJSON("/product/getAttachList",{bno:bno},function(arr){
			console.log(arr);
			
			var str="";
			
			$(arr).each(function(i,attach){
				console.log(attach.fileType);
								
				if(attach.fileType){
					console.log(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);
					
					var fileCallPath=encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);
					console.log(fileCallPath);
					
					str+="<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'>"+
						 "		<span>"+attach.fileName+"</span>"+
						 "		<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>"+
						 "		<img src='/display?fileName="+fileCallPath+"'>"+
						 "</li>";
				}else{
					str+="<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'>"+
						 "		<span>"+attach.fileName+"</span>"+
						 "		<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>"+
						 "		<img src='resources/img/attach.png'>"+attach.fileName+
						 "</li>";
				}
			});
			
			$(".uploadResult ul").html(str);
		});
	})();
	
	$(".uploadResult").on("click","button",function(e){
		console.log("delete file");
		
		if(confirm("??? ????????? ??????????????????????")){
			var targetLi=$(this).closest("li");
			targetLi.remove();
		}		
	});
	
	var regex=new RegExp("(.*?)\.(exe|sh)$");
	var maxSize=5242880;	//5MB
	
	function checkExtension(fileName,fileSize){
		if(fileSize>=maxSize){
			alert("?????? ????????? ??????");
			return false;
		}
		
		if(regex.test(fileName)){
			alert("?????? ????????? ????????? ???????????? ??? ????????????.");
			return false;
		}
		return true;
	}
	
	var csrfHeaderName="${_csrf.headerName}";
	var csrfTokenValue="${_csrf.token}";
	
	$("input[type='file']").change(function(e){
		var formData=new FormData();
		var inputFile=$("input[name='uploadFile']");
		var files=inputFile[0].files;
		
		console.log(files);	//?????? ????????? ????????????
		
		for(var i=0;i<files.length;i++){			
			if(!checkExtension(files[i].name,files[i].size)){
				return false;
			}
			formData.append("uploadFile",files[i]);
		}
		
		$.ajax({
			url:'/uploadAjaxAction',
			processData:false,
			contentType:false,
			beforeSend:function(xhr){
				xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
			},
			data:formData,
			type:'POST',
			success:function(result){
				console.log(result);	//?????? ????????? ????????????
				
				showUploadedFile(result);				
			}
		});
	});
	
	function showUploadedFile(uploadResultArr){
		
		if(!uploadResultArr || uploadResultArr.length==0){
			return;
		}
		var uploadUL=$(".uploadResult ul");
		
		var str="";
		
		$(uploadResultArr).each(function(i,obj){
			
			if(obj.image){
				var fileCallPath=encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
				
				str+="<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'>"+
					 "		<span>"+obj.fileName+"</span>"+
					 "		<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>"+
					 "		<img src='/display?fileName="+fileCallPath+"'>"+
					 "</li>";
			}else{			
				var fileCallPath=encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
				
				var fileLink=fileCallPath.replace(new RegExp(/\\/g),"/");
				
				str+="<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'>"+
					 "		<span>"+obj.fileName+"</span>"+
					 "		<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>"+
					 "		<img src='resources/img/attach.png'>"+obj.fileName+
					 "</li>";
			}
		});
		
		uploadUL.append(str);
	}
	
});
</script>
<%@include file="../include/footer.jsp" %>
            