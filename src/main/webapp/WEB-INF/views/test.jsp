<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
	<style>
	#modDiv{width:300px; height:100px; background-color:gray; position:absolute;
			 top:50%; left:50%; margin-top: -50px; margin-left: -150px; padding:10px; z-index:1000;}
	.pagination {
	  width: 100%;
	}
	.pagination li{
	  list-style: none;
	  float: left; 
	  padding: 3px; 
	  border: 1px solid blue;
	  margin:3px;  
	}
	.pagination li a{
	  margin: 3px;
	  text-decoration: none;
	  }
	</style>
	<!-- jQuery 2.1.4 -->
	<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
	<script>
		var bno = 506;
	
	function getAllList(){
		$.getJSON("/replies/all/" + bno, function(data){
			
			var str="";
			console.log(data.length);
			
			$(data).each(
					function(){
						str += "<li data-rno='"+this.rno+"' class='replyLi'>"
						    + this.rno + ":" + this.replytext
						    + "<button>MOD</button></li>";
					});
			$("#replies").html(str);
		});
	}
	
	</script>
</head>
<body>

	<h2>Ajax Test Page</h2>
	<ul id="replies"></ul>
	
	<div>
		<div>
			REPLYER <input type='text' name='replyer' id='newReplyWriter'>
		</div>
		<div>
			REPLY TEXT<input type='text' name='replytext' id='newReplyText'>
		</div>
		<button id="replyAddBtn">ADD REPLY</button>
	</div>
	
	<div id='modDiv' style="display:none"> <!-- 숨겨진 div  -->
		<div class='modal-title'></div>
		<div>
			<input type='text' id='replytext'>
		</div>
		<div>
			<button type="button" id="replyModBtn">Modify</button>
			<button type="button" id="replyDelBtn">DELETE</button>
			<button type="button" id="closeBtn">Close</button>
		</div>
	</div>
	<!-- 댓글 페이지를 위한 ul -->
	<ul class='pagination'></ul>
	
	<script>
	<!--ADD REPLY버튼 클릭시 이벤트 처리-->
	 $("#replyAddBtn").on("click", function() {

		   var replyer = $("#newReplyWriter").val();
		   var replytext = $("#newReplyText").val();

		   $.ajax({
		    type : 'post',
		    url : '/replies',
		    headers : {
		     "Content-Type" : "application/json",
		     "X-HTTP-Method-Override" : "POST"
		    },
		    dataType : 'text',
		    data : JSON.stringify({
		     bno : bno,
		     replyer : replyer,
		     replytext : replytext
		    }),
		    success : function(result) {

		     if (result == 'SUCCESS') {

		      alert("등록 되었습니다.");
		      getAllList();
		      //getPageList(replyPage);
		     }
		    }
		   });
		  });
	 
	//MOD버튼에대한 jQuery
	 $("#replies").on("click", ".replyLi button", function(){
		
		 var reply = $(this).parent();
		 
		 var rno = reply.attr("data-rno");
		 var replytext = reply.text();
			
		 alert(rno + ":" + replytext);
		 $(".modal-title").html(rno);
		 $("#replytext").val(replytext);
		 $("#modDiv").show("slow");
		 
	 });
	
	//delete버튼 동작 삭제작업
	$("#replyDelBtn").on("click", function(){
		
		var rno = $(".modal-title").html();
		var replytext = $("#replytext").val();
	
		$.ajax({
			type : 'delete',
			url : '/replies/' + rno,
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "DELETE"
			},
			datatype : 'text',
			success : function(result){
				console.log("result: " + result);
				if(result == 'SUCCESS'){
					alert("삭제 되었씁니다.");
					$("#modDiv").hide("slow");
					getAllList();
					//getPageList(replyPage);
				}
			}
		}) ;
	});
	//수정 작업
	$("#replyModBtn").on("click",function(){
     
     var rno = $(".modal-title").html();
     var replytext = $("#replytext").val();
     
     $.ajax({
     type:'put',
     url:'/replies/'+rno,
     headers: { 
           "Content-Type": "application/json",
           "X-HTTP-Method-Override": "PUT" },
     data:JSON.stringify({replytext:replytext}), 
     dataType:'text', 
     success:function(result){
      console.log("result: " + result);
      if(result == 'SUCCESS'){
       alert("수정 되었습니다.");
        $("#modDiv").hide("slow");
      // getAllList();
        getPageList(replyPage);
      }
    }});
  });  
	
	function getPageList(page){//페이지 번호를 입력받고 getJSON을 이용해서 가져온데이터 처리
		$.getJSON("/replies/"+bno+"/"+page, function(data){
			
			console.log(data.list.length);
			
			var str = "";
			
			$(data.list).each(function(){
				str+= "<li data-rno'"+this.rno+"'class = 'replyLi'>"
				+this.rno+":"+this.replytext+
				"<button>MOD</button></li>";
			});
			
			$("#replies").html(str);
			
			printPaging(data.pageMaker);
		});
	}
	
	 function printPaging(pageMaker){
		   
		   var str = "";
		   
		   if(pageMaker.prev){
		    str += "<li><a href='"+(pageMaker.startPage-1)+"'> << </a></li>";
		   }
		   
		   for(var i=pageMaker.startPage, len = pageMaker.endPage; i <= len; i++){    
		     var strClass= pageMaker.cri.page == i?'class=active':'';
		      str += "<li "+strClass+"><a href='"+i+"'>"+i+"</a></li>";
		   }
		   
		   if(pageMaker.next){
		    str += "<li><a href='"+(pageMaker.endPage + 1)+"'> >> </a></li>";
		   }
		   $('.pagination').html(str);    
		}
	 	
	 	var bno = 506;
		getPageList(1);
		
		var replyPage = 1;
		
		$(".pagination").on("click", "li a", function(event){
			
			event.preventDefault(); //a태그의 기본 동작인 페이지 전환을 막는다.
			
			replyPage = $(this).attr("href");
			
			getPageList(replyPage);
			
		});
	</script>

</body>
</html>