<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script>


$(document).ready(function()
{
	<c:if test="${!empty nmCookie}">
		$("#revWriteBtn").on("click", function()
		{
			location.href = "/board/revWrite"; 
		});	
	</c:if>

	$("#revSearchType").change(function()
	{
		$("#revSearchValue").val("");
	});
	
   	$("#revSearchBtn").on("click", function() 
   	{
   		if($("#revSearchType").val() == "")
   		{
   			alert("조회 항목을 선택하세요.");
   			return;
   		}   
   		
   		if($("#revSearchType").val() != "")
    	{
    		if($.trim($("#revSearchValue").val()) == "")
    	    {
    	    	alert("조회 값을 입력하세요.");
    	    	$("#revSearchValue").val("");
    	    	$("#revSearchValue").focus();
    	    	return;
    	    }
    	}
   		
		document.revListForm.revSeq.value = "";
		
		document.revListForm.searchType.value = $("#revSearchType").val();
		document.revListForm.searchValue.value = $("#revSearchValue").val();
		document.revListForm.curPage.value = "1";
		
		document.revListForm.action = "/board/revList";
		document.revListForm.submit();
   	});
});

function revSortPaging(searchSort)
{
	document.revListForm.revSeq.value = "";
	document.revListForm.curPage.value = "1";
	document.revListForm.searchSort.value = searchSort;
	document.revListForm.action = "/board/revList";
	document.revListForm.submit();
}

function revListPaging(curPage)
{
	document.revListForm.revSeq.value = "";
	document.revListForm.curPage.value = curPage;
	document.revListForm.action = "/board/revList";
	document.revListForm.submit();
}

function revListView(revSeq)
{
	document.revListForm.revSeq.value = revSeq;
	document.revListForm.action = "/board/revView";
	document.revListForm.submit();
}
</script>
</head>
<body>
<!-- ======= Header ======= -->
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<!-- End Header -->

 <main id="main">

    <!-- ======= Search Results ======= -->
    <section id="search-result" class="search-result">
      <div class="container">
       
            <h3 class="category-title">후기게시판</h3>
            <c:if test="${!empty nmCookie}">
				<input type="button" name="revWriteBtn" id="revWriteBtn" class="btn btn-primary" value="글쓰기" style="float:right;">
            </c:if>
            <!-- 게시글 정렬 -->
			<div class="aside-block">
              <ul class="nav nav-pills custom-tab-nav mb-4" id="pills-tab" role="tablist">
                <li class="nav-item" role="presentation">
                	<!--  해당 버튼이 선택되면 aria-selected가 true -->
                	
                	
                  <button onclick="revSortPaging(1)" <c:choose> <c:when test='${searchSort eq "1"}'> class="nav-link active" </c:when> <c:otherwise> class="nav-link" </c:otherwise></c:choose>  id="pills-popular-tab" data-bs-toggle="pill" type="button" role="tab">최신순</button>
                </li>
                <li class="nav-item" role="presentation">
                  <button onclick="revSortPaging(2)" <c:choose> <c:when test='${searchSort eq "2"}'> class="nav-link active" </c:when> <c:otherwise> class="nav-link" </c:otherwise></c:choose>  id="pills-trending-tab" data-bs-toggle="pill" type="button" role="tab">조회수순</button>
                </li>
               </ul>
              </div>
              

		<c:choose>
			<c:when test="${!empty spRevList}">
				<c:forEach  var="spRevList" items="${spRevList}" varStatus="status">
			       <div class="d-md-flex post-entry-2 small-img border-bottom">
		              	<div>
			                <div class="post-meta"><span class="date">작성일 : ${spRevList.revRegDate} </span> <span class="mx-1">&bullet;</span> <span class="date">조회수 : ${spRevList.revReadCnt}</span></div>
			                <h3><a href="javascript:void(0)" onclick="revListView(${spRevList.revSeq})">${spRevList.revTitle}</a></h3>
			                <div class="d-flex align-items-center author">
			                  <div class="name">
			                    <h3 class="m-0 p-0">${spRevList.nmNickname}</h3>
			                  </div>
			                </div>
			              </div>
			         </div>
		        </c:forEach>
			</c:when>
			<c:otherwise>
				<div class="d-md-flex post-entry-2 half my-5">
			        	<h3>작성된 후기가 없거나, 검색결과값이 존재하지 않습니다. </h3>
			    </div>
			</c:otherwise>
		</c:choose>
	        
	  <!-- 검색 -->
	  <div class="row justify-content-center mt-5">
	       <select name="revSearchType" id="revSearchType" class="custom-select " style="width:auto;height:45px;">
					<option value="">조회항목</option>
                    <option value="1" <c:if test='${searchType eq "1"}'> selected </c:if>>작성자</option>
                    <option value="2" <c:if test='${searchType eq "2"}'> selected </c:if>>제목</option>
                    <option value="3" <c:if test='${searchType eq "3"}'> selected </c:if>>내용</option>
	       </select>
	       <input type="text" name="revSearchValue" id="revSearchValue" value="${searchValue}" class="form-control mx-1" maxlength="20" style="width:auto;ime-mode:active;height:45px;" placeholder="조회값을 입력하세요." />
	       <button type="button" id="revSearchBtn" class="btn btn-secondary mb-3 mx-1" style="width:auto;height:43px;">조회</button>
	  </div>
	<!-- 이거 도대체 왜 가로 정렬이 안될까 -->
      <!-- 검색 끝 -->
      

      <!-- 페이징 -->
            <div class="text-center py-4">
                <div class="custom-pagination">
			<c:if test="${!empty paging}">
				<c:if test="${paging.prevBlockPage gt 0}">     
					<a class="prev" href="javascript:void(0)" onclick="revListPaging(${paging.prevBlockPage})">Previous</a>  
				</c:if>   
					<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
			<c:choose>
				<c:when test="${i ne curPage}">
					<a  href="javascript:void(0)" onclick="revListPaging(${i})">${i}</a>
	        	</c:when>
	        	<c:otherwise>
	        		<a class="active"href="javascript:void(0)">${i}</a>
	        	</c:otherwise>
   			</c:choose>
   		</c:forEach>
				<c:if test="${paging.nextBlockPage gt 0}">
                    <a class="next" href="javascript:void(0)" onclick="revListPaging(${paging.nextBlockPage})">Next</a>
                </c:if>
           </c:if>     
                </div>
           </div>
       <!-- 페이징 끝 -->

	 </div> <!-- container 끝 -->
    </section> <!-- End Search Result -->
  </main><!-- End #main -->


    <form id="revListForm" name="revListForm" method="POST">
	   	<input type="hidden" id="revSeq" name="revSeq" value="">
	   	<input type="hidden" name="searchType" value="${searchType}">
	   	<input type="hidden" name="searchValue" value="${searchValue}">
	   	<input type="hidden" name="searchSort" value="${searchSort}">
	   	<input type="hidden" name="curPage" value="${curPage}">
   </form>

<!-- ======= Footer start ======= -->
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<!-- ======= Footer e n d ======= -->

<a href="#" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>
<%@ include file="/WEB-INF/views/include/vendor.jsp" %>
</body>
</html>