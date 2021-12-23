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
				<h1 class="page-header">Product</h1>
	        	<hr>
	            <!-- /.panel-heading -->
	            <div class="panel-body">
	            
	            	<form role="form" action="/product/register" method="post">
	            	
	            		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
	            		<div class="form-group">
	            			<select name="types" id="selectType" onchange="changeSelect()">
	            				<option value="">품 목</option>
	            				<option value="outer">아우터</option>
	            				<option value="top">상 의</option>
	            				<option value="pants">하 의</option>
	            			</select>
	            			<select name="category" id="selectCategory">
	            				<option value="" class="trash">품목을 선택해 주세요</option>
	            				<option value='padding' class="outer" style="display:none;">패딩</option>
	            				<option value='coat' class="outer" style="display:none;">코트</option>
	            				<option value='jacket' class="outer" style="display:none;">재킷</option>
	            				<option value='short' class="top" style="display:none;">반팔 티</option>
	            				<option value='long' class="top" style="display:none;">긴팔 티</option>
	            				<option value='shirts' class="top" style="display:none;">셔 츠</option>
	            				<option value='denim' class="pants" style="display:none;">데님 팬츠</option>
	            				<option value='shorts' class="pants" style="display:none;">숏 팬츠</option>
	            				<option value='slacks' class="pants" style="display:none;">슬랙스</option>
	            			</select>
	            		</div>
	            		<br>
	            		
	            		<div class="form-group">
	            			<label>제목</label>
	            			<input class="form-control" name="title">
	            		</div>
	            		<div class="form-group">
	            			<label>가격</label>
	            			<input class="form-control" name="price">
	            		</div>
	            		<div class="form-group">
	            			<label>내용</label>
	            			<textarea class="form-control" rows="3" name="content"></textarea>
	            		</div>
	            		<div class="form-group">
	            			<label>Writer</label>
	            			<input class="form-control" name="writer"
	            				value='<sec:authentication property="principal.username"/>' readonly="readonly">
	            		</div>
	            		<button type="submit" class="btn btn-default">작성</button>
	            		<button type="reset" class="btn btn-default">취소</button>
	            	</form>
	                                
	            </div>
	            <!-- /.panel-body -->
	        </div>
	        <!-- /.panel -->
	    </div>
	    <!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->
	
	<div class="row">
		<div class="col-lg-12">		
			<div class="panel panel-default">
			
				<div class="panel-heading">파일 첨부</div>
				<div class="panel-body">
					<div class="form-group uploadDiv">
						<input type="file" name="uploadFile" multiple>
					</div>
					
					<div class="uploadResult">
						<ul>
						</ul>
					</div>
				</div>
			
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

	var formObj=$("form[role='form']");
	$("button[type='submit']").on("click",function(e){
		e.preventDefault();
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
		
		formObj.append(str).submit();
		
	});
	
	var regex=new RegExp("(.*?)\.(exe|sh)$");
	var maxSize=5242880;	//5MB
	
	function checkExtension(fileName,fileSize){
		if(fileSize>=maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
		
		if(regex.test(fileName)){
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
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
		
		console.log(files);	//서버 전송전 파일정보
		
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
				console.log(result);	//서버 전송후 파일정보
				
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
				console.log("===========uploadPath:============"+fileCallPath);
				
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
	
	$(".uploadResult").on("click","button",function(e){
		console.log("delete file");
		
		var targetFile=$(this).data("file");
		var type=$(this).data("type");
		
		var targetLi=$(this).closest("li");
		
		$.ajax({
			url:'/deleteFile',
			beforeSend:function(xhr){
				xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
			},
			data:{fileName:targetFile,type:type},			
			dataType:'text',
			type:'POST',
			success:function(result){
				alert(result);
				targetLi.remove();
			}
		});
	});
});
</script>
<%@include file="../include/footer.jsp" %>
            