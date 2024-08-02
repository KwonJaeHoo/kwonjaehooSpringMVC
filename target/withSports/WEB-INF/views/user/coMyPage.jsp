<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script>
<c:if test="${empty coCookie}">
	location.href="/";
</c:if>

function promListPaging(curPage)
{
	document.promListForm.promSeq.value = "";
	document.promListForm.curPage.value = curPage;
	document.promListForm.action = "/user/coMyPage";
	document.promListForm.submit();
}

function promListView(promSeq)
{
	document.promListForm.promSeq.value = promSeq;
	document.promListForm.action = "/board/promView";
	document.promListForm.submit();
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
						                    <img ${spPromList.spPromFile.promFileName}class="" src="/resources/assets/img/imgEmpty.png" alt="대회포스터">
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
		                                    	<li>- 행사일자 : ${spPromList.promMoSdate}</li>
		                                    	<li>- 행사장소 : ${spPromList.promAddr}</li>
		                                    	<li>- 모집인원 : ${spPromList.promJoinCnt}/${spPromList.promLimitCnt} (명)</li>
		                                    	<li>- 주최자 : ${spPromList.coName}</li>
		                                	</ul>
		                				<div style="width:500px">
		                                	<!-- <button class="btn btn-primary float-end">참여</button> -->
		                                <c:if test='${spPromList.promStatus eq "N"}'> 
					                        <button class="btn btn-outline-secondary float-end" disabled>모집마감</button>
					                    </c:if>
					                    <c:if test='${spPromList.promStatus eq "Y"}'> 
					                        <button class="btn btn-outline-secondary float-end">모집중</button>
					                    </c:if>
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

    <form id="promListForm" name="promListForm" method="POST">
	   	<input type="hidden" id="promSeq" name="promSeq" value="">
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