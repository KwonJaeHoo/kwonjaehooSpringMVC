<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script>
$(document).ready(function()
{
	<c:if test="${empty coCookie}">
		location.href="/";
	</c:if>
	
	$("#coMyPageSearchBtn").on("click", function() 
   	{
   		if($("#coMyPageSearchType").val() == "")
   		{
   			alert("조회 항목을 선택하세요.");
   			return;
   		}
   		
   		if($("#coMyPageSearchType").val() != "")
    	{
    		if($.trim($("#coMyPageSearchValue").val()) == "")
    	    {
    	    	alert("조회 값을 입력하세요.");
    	    	$("#coMyPageSearchValue").val("");
    	    	$("#coMyPageSearchValue").focus();
    	    	return;
    	    }
    	}
   		
		document.coPromListForm.promSeq.value = "";
		
		document.coPromListForm.searchType.value = $("#coMyPageSearchType").val();
		document.coPromListForm.searchValue.value = $("#coMyPageSearchValue").val();
		document.coPromListForm.curPage.value = "1";
		
		document.coPromListForm.action = "/user/coMyPage";
		document.coPromListForm.submit();
   	});
});

function promListPaging(curPage)
{
	document.coPromListForm.promSeq.value = "";
	document.coPromListForm.curPage.value = curPage;
	document.coPromListForm.action = "/user/coMyPage";
	document.coPromListForm.submit();
}

function promListView(promSeq)
{
	document.coPromListForm.promSeq.value = promSeq;
	document.coPromListForm.action = "/board/promView";
	document.coPromListForm.submit();
}

function promPlayListView(promSeq)
{
	document.coPromListForm.promSeq.value = promSeq;
	document.coPromListForm.action = "/user/coMyPagePlayList";
	document.coPromListForm.submit();
}

</script>
</head>
<body>

<c:if test="${!empty coCookie}">
<!-- ======= Header ======= -->
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<!-- End Header -->

<main id="main">
	<section>
    	<div class="container" data-aos="fade-up">
        	<div class="row">
          		<div class="col-lg-12 text-center mb-5">
            		<h3 class="page-title">Company Page</h3>
          		</div>
        	</div>
        </div>
    </section>    
    
    <div class="container">
    	<div class="row">
        	<div class="col-md-12"  data-aos="fade-up">
            	<div class="logo mb-5 align-items-center">
                	<h1 class="text-center">작성글 목록</h1>
                	<p class="text-center mt-3">*대회 삭제 요청은 관리자에게 문의바랍니다.</p>
            	</div>
          	</div>
        	<!--대회 리스트 시작(게시물 5개씩 추천)-->
        	<div class="row justify-content-center">
				<table class="table table-ws w-75 p-3">
                <thead class="mb-5"></thead>

                <!--c:if-->
                <tbody>
                	<!--리스트 시작-->
                <c:choose>
					<c:when test="${!empty spPromList}">
						<c:forEach var="spPromList" items="${spPromList}" varStatus="status">
		                    <tr>
		                    	<div class="d-md-flex half my-5 justify-content-center">
		                        	<div class="me-4 ratio ratio-16x9 p-3" style="width:400px; height:250px;">
						                <c:if test="${!empty spPromList.spPromFile}">
						                    <img class="" src="/resources/upload/${spPromList.spPromFile.promFileName}" alt="대회포스터">
						                </c:if>
						                <c:if test="${empty spPromList.spPromFile}">
						                    <img class="" src="/resources/assets/img/imgEmpty.png" alt="대회포스터">
						                </c:if>
		                            </div>
		                            <div class="justify-content-center">
		                            	<div class="post-meta w-200" style="width: 500px;">
		                                <span class="mx-1"></span><span class="date">${spPromList.promCate}</span><span class="mx-1">&bullet;</span>
		                        		<span class="date">게시일 : ${spPromList.promRegDate}</span>
		                                    <span class="mx-1 float-end">
		                                        <img src="/resources/assets/img/pm-like.png" class="me-1" style="width:15px;height:15px;">${spPromList.promLikeCnt}&nbsp;
		                                        <img src="/resources/assets/img/pm-view.png" class="me-1" style="width:22px;height:20px;">${spPromList.promReadCnt}
		                                    </span>
		                                </div>
		                                <h3><a href="javascript:void(0)" onclick="promListView(${spPromList.promSeq})">${spPromList.promTitle}</a></h3>
		                                	<ul class="list-unstyled">
		                                    	<li>- 모집기간 : ${spPromList.promMoSdate} ~ ${spPromList.promMoEdate}</li>
		                                    	<li>- 행사일자 : ${spPromList.promCoSdate} ~ ${spPromList.promCoEdate}</li>
		                                    	<li>- 행사장소 : ${spPromList.promAddr}</li>
		                                    	<li>- 모집인원 : ${spPromList.promJoinCnt}/${spPromList.promLimitCnt} (명)</li>
		                                    	<li>- 주최자 : ${spPromList.coName}</li>
		                                	</ul>
		                				<div style="width:500px">
			                                <c:if test='${spPromList.promJoinCnt == spPromList.promLimitCnt}'> 
						                        <button class="btn btn-outline-secondary float-end" disabled>모집마감</button>
						                    </c:if>
						                    <c:if test='${spPromList.promJoinCnt != spPromList.promLimitCnt}'>
						                    	<jsp:useBean id="now" class="java.util.Date" />
						                    	
												<fmt:parseDate var="promMoSdateParseDate" value="${spPromList.promMoSdate}" pattern="yyyy-MM-dd"/>
						                    	<fmt:parseDate var="promMoEdateParseDate" value="${spPromList.promMoEdate}" pattern="yyyy-MM-dd"/> 			
						                    	
               									<fmt:formatDate var="promMoSdateFormatDate" value="${promMoSdateParseDate}" type="DATE" pattern="yyyyMMdd"/>				
												<fmt:formatDate var="promMoEdateFormatDate" value="${promMoEdateParseDate}" type="DATE" pattern="yyyyMMdd"/>
											
						                    	<fmt:formatDate value="${now}" var="nowTimeFormatDate" pattern="yyyyMMdd"/>
						                    	
												<fmt:parseNumber value="${nowTimeFormatDate}" var="nowTime" scope="request"/>
												<fmt:parseNumber value="${promMoSdateFormatDate}" var="promMoSdate" scope="request"/>
												<fmt:parseNumber value="${promMoEdateFormatDate}" var="promMoEdate" scope="request"/>
												
						                    	<c:if test='${(promMoSdate - nowTime) > 0 && (promMoEdate - nowTime) > 0}'>
						                    		<button class="btn btn-outline-secondary float-end" disabled>모집전</button>
						                    	</c:if>
						                    	<c:if test='${(promMoSdate - nowTime) <= 0 && (promMoEdate - nowTime) >= 0}'>
						                    		<button class="btn btn-outline-secondary float-end">모집중</button>
						                    	</c:if>
						                    	<c:if test='${(promMoEdate - nowTime) < 0}'>
						                    		<button class="btn btn-outline-secondary float-end" disabled>모집마감</button>
						                    	</c:if>
						                        
						                    </c:if>
					                    	<button class="btn btn-outline-secondary" onclick="promPlayListView(${spPromList.promSeq})"><i></i>참여인원</button>
		                                </div>    
		                            </div>
		                        </div>
		                    </tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
							<tfoot>
		                	<tr>
		                        <td colspan="5">
		                        작성된 글이 없습니다.
		                        </td>
		                        
		                    </tr>
		                	</tfoot>
					</c:otherwise>
                </c:choose>
                    <!--리스트 끝-->
                </tbody>
                	  <div class="row justify-content-center mt-5">
					       <select name="coMyPageSearchType" id="coMyPageSearchType" class="custom-select " style="width:auto;height:45px;">
									<option value="">조회항목</option>
				                    <option value="2" <c:if test='${searchType eq "2"}'> selected </c:if>>행사명</option>
				                    <option value="3" <c:if test='${searchType eq "3"}'> selected </c:if>>행사내용</option>
					       </select>
					       <input type="text" name="coMyPageSearchValue" id="coMyPageSearchValue" value="${searchValue}" class="form-control mx-1" maxlength="20" style="width:auto;ime-mode:active;height:45px;" placeholder="조회값을 입력하세요." />
					       <button type="button" id="coMyPageSearchBtn" class="btn btn-secondary mb-3 mx-1" style="width:auto;height:43px;">조회</button>
					  </div>
            	</table>
            	
        	</div>
        	
        	<!-- 페이징 -->
					<div class="text-center py-4">
		                <div class="custom-pagination">
				<c:if test="${!empty paging}">
					
						<c:if test="${paging.prevBlockPage gt 0}">     
							<a class="prev" href="javascript:void(0)" onclick="promListPaging(${paging.prevBlockPage})">Previous</a>  
						</c:if> 
						  
							<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
								<c:choose>
									<c:when test="${i ne curPage}">
										<a  href="javascript:void(0)" onclick="promListPaging(${i})">${i}</a>
			        				</c:when>
			        				<c:otherwise>
			        					<a class="active"href="javascript:void(0)">${i}</a>
			        				</c:otherwise>
		   						</c:choose>
		   					</c:forEach>
		   					
						<c:if test="${paging.nextBlockPage gt 0}">
		                    <a class="next" href="javascript:void(0)" onclick="promListPaging(${paging.nextBlockPage})">Next</a>
		                </c:if>
		       </c:if>     
		                </div>
		           </div>
        <!-- 페이징 -->
			<div class="row mb-5 ">
    		</div>
        </div>
	</div>
</main>
<!-- End #main -->

    <form id="coPromListForm" name="coPromListForm" method="POST">
	   	<input type="hidden" id="promSeq" name="promSeq" value="">
	   	<input type="hidden" id="searchType" name="searchType" value="${searchType}">
	   	<input type="hidden" id="searchValue" name="searchValue" value="${searchValue}">
	   	<input type="hidden" name="curPage" value="${curPage}">
   	</form>
<!-- ======= Footer start ======= -->
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<!-- ======= Footer e n d ======= -->

<a href="#" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

<%@ include file="/WEB-INF/views/include/vendor.jsp" %>
</c:if>
</body>
</html>