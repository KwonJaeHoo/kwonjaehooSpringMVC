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
	
	<c:if test="${empty coCookie}">
		alert("잘못된 접근입니다.");
		location.href="/";
	</c:if>
	
	$("#promListBtn").on("click", function()
	{
		document.coMyPagePlayListForm.promSeq.value = "";
		document.coMyPagePlayListForm.action="/user/coMyPage";
		document.coMyPagePlayListForm.submit();
	});	
});

function playListPaging(playListCurPage)
{
	document.coMyPagePlayListForm.playListCurPage.value = playListCurPage;
	document.coMyPagePlayListForm.action = "/user/coMyPagePlayList";
	document.coMyPagePlayListForm.submit();
}
</script>
</head>
<body>

<c:if test="${!empty coCookie && !empty promSeq}">
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
        	
			<div class="row justify-content-center">
            	<h5 class="text-center">참여 내역</h5>
                	<table class="table table-ws w-75 p-3">
                    	<thead class="mb-5">
                        	<tr>
                                <th scope="col" class="text-center" style="width:15%">참가자 명</th>
                                <th scope="col" class="text-center" style="width:20%">신청날짜</th>
                            </tr>
                        </thead>
                        
                        <!--c:if-->
                        <tbody>
                        	<c:choose>
								<c:when test="${!empty spJoinApproveList}">
									<c:forEach var="spJoinApproveList" items="${spJoinApproveList}" varStatus="status">
		                            	<tr class="justify-content-center ws-list-hove">
			                                <td class="text-center">${spJoinApproveList.nmNickname}</td>
			                                <td class="text-center"><fmt:formatDate value="${spJoinApproveList.approvedAt}" type="DATE" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			                            </tr>
                            		</c:forEach>
								</c:when>
								<c:otherwise>
								<tfoot>
		                        	<tr>
		                               	<td colspan="5">참가 인원이 없어요.</td>
		                           	</tr>
		                       </tfoot>
		                       
								</c:otherwise>
								
							</c:choose>
                        </tbody>
                    </table>
			</div>
            <!-- 페이징 -->
			<div class="text-center py-4">
            	<div class="custom-pagination">
					<c:if test="${!empty playListPaging}">
						<c:if test="${playListPaging.prevBlockPage gt 0}">     
							<a class="prev" href="javascript:void(0)" onclick="playListPaging(${playListPaging.prevBlockPage})">Previous</a>  
						</c:if>   
						<c:forEach var="i" begin="${playListPaging.startPage}" end="${playListPaging.endPage}">
							<c:choose>
								<c:when test="${i ne playListCurPage}">
									<a href="javascript:void(0)" onclick="playListPaging(${i})">${i}</a>
	        					</c:when>
	        					<c:otherwise>
	        						<a class="active"href="javascript:void(0)">${i}</a>
	        					</c:otherwise>
   							</c:choose>
   						</c:forEach>
						<c:if test="${playListPaging.nextBlockPage gt 0}">
                    		<a class="next" href="javascript:void(0)" onclick="playListPaging(${playListPaging.nextBlockPage})">Next</a>
                		</c:if>
           			</c:if>     
				</div>
			</div>
            <!-- 페이징 -->
            
            <div>
            	<br>
            	<br>
            	<br>
            </div>
        	<button type="button" id="promListBtn"class="btn btn-primary" value="Post comment">리스트</button>
        </div>
    </section>    
</main>
<!-- End #main -->
    <form id="coMyPagePlayListForm" name="coMyPagePlayListForm" method="POST">
	   	<input type="hidden" id="promSeq" name="promSeq" value="${promSeq}">
	   	<input type="hidden" id="searchType" name="searchType" value="${searchType}">
	   	<input type="hidden" id="searchValue" name="searchValue" value="${searchValue}">
	   	<input type="hidden" name="curPage" value="${curPage}">
	   	<input type="hidden" name="playListCurPage" value="${playListCurPage}">	
   	</form>
<!-- ======= Footer start ======= -->
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<!-- ======= Footer e n d ======= -->

<a href="#" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

<%@ include file="/WEB-INF/views/include/vendor.jsp" %>
</c:if>
</body>
</html>