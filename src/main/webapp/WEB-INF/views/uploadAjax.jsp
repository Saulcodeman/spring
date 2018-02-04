<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>

<style>
.fileDrop{
	width:100%;
	height:200px;
	border: 3px dotted blue;
}
small {
	margin-left:3px;
	font-weight:bold;
	color:grey;
}
</style>
</head>
<body>
	
	<h3>Ajax FIle Upload</h3>
	<div class='fileDrop'></div>
	
	<div class='uploadedList'></div>
	
	<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
	<script>
		$(".fileDrop").on("dragenter dragover", function(event){
			event.preventDefault();
		});
		
		$(".fileDrop").on("drop", function(event){
			event.preventDefault();
			
			var files = event.originalEvent.dataTransfer.files; 
			
			var file = files[0];
			
			//console.log(file);
			
			var formData = new FormData();
			
			formData.append("file", file);
			// uploadAjax.jsp에서 화면에 데이터를 출력한다
			$.ajax({
				url: '/uploadAjax',
				data: formData,
				dataType: 'text',
				processData: false,
				contentType: false,
				type: 'POST',
				success: function(data){
					
					var str = "";
					
					console.log(data);
					console.log(checkImageType(data));
					
					if(checkImageType(data)){
						str = "<div><a href='displayFile?fileName="+getImageLink(data)+"'>"
								+"<img src='displayFile?fileName="+data+"'/>"
								+"</a><small data-src="+data+">X</small></div>";
					}else{
						str = "<div><a href='displayFile?fileName="+data+"'>"+getOriginalName(data)+"</a>"
								+"<small data-src="+data+">X</small></div>";
					}
					$(".uploadedList").append(str);
					
				}
			});
			
		});
		
		//전송 받은 문자열이 이미지 파일인지를 확인하는 함수, 정규 표현식 이용 
		function checkImageType(fileName){
			
			var pattern = /jpg$|gif$|png$|jpeg$/i;
			
			return fileName.match(pattern);
		}
		
		//파일의 이름 줄여주는 기능
		function getOriginalName(fileName){
			if(checkImageType(fileName)){
				return;
			}
			var idx = fileName.indexOf("_")+1;
			return fileName.substr(idx);
		}
		
		//썸네일 말고 원본파일의 링크 찾기
		function getImageLink(fileName){
			if(!checkImageType(fileName)){
				return;
			}
			var front = fileName.substr(0,12);
			var end = fileName.substr(14);
			
			return front + end;
		}
		
		//Ajax를 이용 파일의 이름을 컨트롤러에 전달, 삭제버튼 이벤트 처리
		$(".uploadedList").on("click", "small", function(event){
			
			var that = $(this);
			
			$.ajax({
				url:"deleteFile",
				type:"post",
				data: {fileName:$(this).attr("data-src")},
				dataType:"text",
				success:function(result){
					if(result == 'deleted'){
						that.parent("div").remove();
					}
				}
			});
		});
			
	</script>
	
</body>
</html>