<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false"%>
<%@include file="../include/header.jsp"%>

<!-- Main content -->
<section class="content">
 <div class="row">
  <!-- left column -->
  <div class="col-md-12">
   <!-- general form elements -->
   <div class='box'>
    <div class="box-header with-border">
     <h3 class="box-title">Board List</h3>
    </div>
    <div class='box-body'>
     <button id='newBtn'>New Board</button>
    </div>
   </div>
   <div class="box">
    <div class="box-header with-border">
     <h3 class="box-title">LIST PAGING</h3>
    </div>
    <div class="box-body">
    
    <!-- 검색에 필요한 화면 구현 -->
     <select name="serchType">
       <option value="n"
         <c:out value="${cri.searchType == null?'selected':''}"/>>
         ---</option>
       <option value="t"
         <c:out value="${cri.searchType eq 't'?'selected':''}"/>>
         Title</option>
       <option value="c"
         <c:out value="${cri.searchType eq 'c'?'selected':''}"/>>
         Content</option>
       <option value="w"
         <c:out value="${cri.searchType eq 'w'?'selected':''}"/>>
         Writer</option>
       <option value="tc"
         <c:out value="${cri.searchType eq 'tc'?'selected':''}"/>>
         Title OR Content</option>
       <option value="cw"
         <c:out value="${cri.searchType eq 'cw'?'selected':''}"/>>
         Content OR Writer</option>
       <option value="tcw"
         <c:out value="${cri.searchType eq 'tcw'?'selected':''}"/>>
         Title OR Content OR Writer</option>
     </select>
     <input type="text" name='keyword' id="keywordInput" value='${cri.keyword}'>
     	<button id='searchBtn'>Search</button>
     	<button id='newBtn'>New Board</button>
     	
     <table class="table table-bordered">
      <tr>
       <th style="width: 10px">BNO</th>
       <th>TITLE</th>
       <th>WRITER</th>
       <th>REGDATE</th>
       <th style="width: 40px">VIEWCNT</th>
      </tr>

      <c:forEach items="${list}" var="boardVO">

       <tr>
        <td>${boardVO.bno}</td>
        <td><a
         href='/sboard/readPage${pageMaker.makeSearch(pageMaker.cri.page)}&bno=${boardVO.bno}'>
          ${boardVO.title}<strong>[ ${boardVO.replycnt} ]</strong></a></td>
        <td>${boardVO.writer}</td>
        <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
          value="${boardVO.regdate}" /></td>
        <td><span class="badge bg-red">${boardVO.viewcnt }</span></td>
       </tr>

      </c:forEach>

     </table>
    </div>
    <!-- /.box-body -->


    <div class="box-footer">





<!-- p.276의 내용을 입력하세요. -->

	<div class="text-center">
		<ul class="pagination">
		
		<!-- 스프링 MVC를 이용하는 방식 -->
			<c:if test="${pageMaker.prev}">
				<li><a href="list${pageMaker.makeSearch(pageMaker.startPage -1)}">&laquo;</a></li>
			</c:if>
			
			<c:forEach begin="${pageMaker.startPage }"
				end="${pageMaker.endPage}" var = "idx">
				<li 
					<c:out value="${pageMaker.cri.page == idx?'class=active':''}"/>>
					<a href="list${pageMaker.makeSearch(idx)}">${idx}</a>
				</li>
			</c:forEach>
			
			<c:if test="${pageMaker.next && pageMaker.endPage>0 }">
				<li><a href="list${pageMaker.makeSearch(pageMaker.endPage +1)}">&raquo;</a>
				</li>
			</c:if> 
			
			
			<!-- JAVASCRIPT를 이용하는 링크의 처리 
			
			     <li>
			     	<a href="1">1</a>
			     </li>
				 <li><a href="2">2</a></li>
				 <li><a href="3">3</a></li>
				 <li><a href="4">4</a></li>
				 <li><a href="5">5</a></li>
				 <li><a href="6">6</a></li>
				-->
			
		</ul>
	</div>


    </div>
    <!-- /.box-footer-->
   </div>
  </div>
  <!--/.col (left) -->

 </div>
 <!-- /.row -->
</section>
<!-- /.content -->

				<form id="jobForm">
			   	<input type='hidden' name="page" value=${pageMaker.cri.perPageNum}>
			   	<input type='hidden' name="perPageNum" value=${pageMaker.cri.perPageNum}>
				</form>


<script>
 var result = '${msg}';

 if (result == 'SUCCESS') {
  alert("처리가 완료되었습니다.");
 }
 
 $(document).ready(
		 function() {
			 
			 $('#searchBtn').on(
					 "click",
					 function(event){
						 
						 self.location = "list"
						 	+'${pageMaker.makeQuery(1)}'
						 	+"&searchType="
						 	+$("select option:selected").val()
						 	+"&keyword=" + encodeURIComponent($('#keywordInput').val());
					 });
			 
			 $('#newBtn').on("click", function(evt){
				 self.location = "register";
			 });
		 });
 <!--
 $(".pagination li a").on("click", function(event){
  
 // event.preventDefault(); //JS로페이징할때
  
  var targetPage = $(this).attr("href");
  
  var jobForm = $("#jobForm");
  jobForm.find("[name='page']").val(targetPage);
  jobForm.attr("action","/board/listPage").attr("method", "get");
  jobForm.submit();
 });
 -->
</script>

<%@include file="../include/footer.jsp"%>

