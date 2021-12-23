console.log("Reply Module.....");

var replyService=(function(){
	
	function add(reply,callback){
		console.log("등록.....");
		
		$.ajax({
			type:'post',
			url:'/notice_replies/new',
			data:JSON.stringify(reply),
			contentType:"application/json;charset=utf-8",
			success:function(result,status,xhr){
				if(callback){
					callback(result);
				}
			},
			error:function(xhr,status,er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	function getList(param,callback){
		console.log("목록.....");
		
		var bno=param.bno;
		var page=param.page;
		
		console.log("bno:"+bno);
		console.log("page:"+page);
				
		$.getJSON("/notice_replies/pages/"+bno+"/"+page+".json",
			function(result){
				if(callback){
					console.log("replyCnt:"+result.replyCnt);
					
					for(var i=0;i<result.list.length;i++){
						console.log("list["+i+"]:"+result.list[i].rno);
						console.log("list["+i+"]:"+result.list[i].reply);
					}
										
					callback(result.replyCnt,result.list);
				}
			}).fail(function(xhr,status,err){
				if(error){
					error();
				}
			});
	}
	
	function remove(rno,replyer,callback,error){
		console.log("삭제.....");
		
		$.ajax({
			type:'delete',
			url:'/notice_replies/'+rno,
			data:JSON.stringify({rno:rno,replyer:replyer}),
			contentType:"application/json; charset=utf-8",
			success:function(result,status,xhr){
				if(callback){
					callback(result);
				}
			},
			error:function(xhr,status,er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	function update(reply,callback,error){
		console.log("수정.....");
		console.log("RNO:"+reply.rno);
		
		$.ajax({
			type:'put',
			url:'/notice_replies/'+reply.rno,
			data:JSON.stringify(reply),
			contentType:"application/json;charset=utf-8",
			success:function(result,status,xhr){
				if(callback){
					callback(result);
				}
			},
			error:function(xhr,status,er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	function get(rno,callback,error){
		
		$.get("/notice_replies/"+rno+".json",function(result){
			if(callback){
				callback(result);
			}
		}).fail(function(xhr,status,err){
			if(error){
				error();
			}
		});
	}
	
	function displayTime(timeValue){
		var today=new Date();
		var gap=today.getTime()-timeValue;
		
		var dateObj=new Date(timeValue);
		var str="";
		
		if(gap<(1000*60*60*24)){
			var hh=dateObj.getHours();
			var mi=dateObj.getMinutes();
			var ss=dateObj.getSeconds();
			
			return [(hh>9?'':'0')+hh,':',(mi>9?'':'0')+mi,
				':',(ss>9?'':'0')+ss].join('');
		}else{
			var yy=dateObj.getFullYear();
			var mm=dateObj.getMonth()+1;
			var dd=dateObj.getDate();
			
			return [yy,'/',(mm>9?'':'0')+mm,'/',(dd>9?'':'0')+dd].join('');
		}
	}	
	
	return {
		add:add,
		get:get,
		getList:getList,
		remove:remove,
		update:update,		
		displayTime:displayTime
	};
})();