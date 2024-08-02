<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script>
<c:if test="${empty nmCookie}">
	location.href="/";
</c:if>

function revListPaging(spRevCurPage)
{
	document.revListForm.revSeq.value = "";
	document.revListForm.spRevCurPage.value = spRevCurPage;
	document.revListForm.action = "/user/nmRevList";
	document.revListForm.submit();
}

function revReplyListPaging(spRevReplyCurPage)
{
	document.revListForm.revSeq.value = "";
	document.revListForm.spRevReplyCurPage.value = spRevReplyCurPage;
	document.revListForm.action = "/user/nmRevList";
	document.revListForm.submit();
}

function revListView(revSeq)
{
	document.revListForm.revSeq.value = revSeq;
	document.revListForm.action = "/board/revView";
	document.revListForm.submit();
}

function spRevDelete(revSeq)
{
	var spRevDeleteSeq = revSeq;
	
	if(confirm("작성한 후기를 삭제하시겠어요?") == true)
	{
		$.ajax
		({
			type : "POST",
			url : "/user/nmRevDeleteProc",
			async : "true",
			dataType:"JSON",
			data:
			{
				revSeq : spRevDeleteSeq
			},
			success:function(response)
			{
				icia.common.log(response)
				
				if(response.code == 200)
				{
					alert("삭제가 완료되었습니다.");
					location.href = location.href;
				}
				else
				{
					alert("오류가 발생했습니다. 다시 시도해주세요.");
					return;		
				}	
			},
			error:function(xhr, status, error)
			{
				alert("오류가 발생했습니다. 다시 시도해주세요.");
				return;		
			}

		});
	}
}

function spRevReplyDelete(replySeq)
{
	var spRevReplyDeleteSeq = replySeq;
	
	if(confirm("작성한 댓글을 삭제하시겠어요?") == true)
	{
		$.ajax
		({
			type : "POST",
			url : "/user/nmRevReplyDeleteProc",
			async : "true",
			dataType:"JSON",
			data:
			{
				replySeq : spRevReplyDeleteSeq
			},
			success:function(response)
			{
				icia.common.log(response)
				
				if(response.code == 200)
				{
					alert("삭제가 완료되었습니다.");
					location.href = location.href;
				}
				else
				{
					alert("오류가 발생했습니다. 다시 시도해주세요.");
					return;		
				}
			},
			error:function(xhr, status, error)
			{
				alert("오류가 발생했습니다. 다시 시도해주세요.");
				return;		
			}
		});
	}
}
</script>
</head>
<body>
<c:if test="${!empty nmCookie}">
<!-- ======= Header ======= -->
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<!-- End Header -->
<main id="main">
	<section>
    	<div class="container" data-aos="fade-up">
                <div class="row">
                    <div class="col-lg-12 text-center mb-5">
                        <h1 class="page-title">My Page</h1>
                    </div>
                </div>

                <!--sub 네비게이션 시작-->
                <nav class="navbar navbar-expand-lg justify-content-center mb-3">
                    <div class="align-items-center">
                    <div class="collapse navbar-collapse align-items-center" id="navbarNavDropdown">
                        <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link nav" href="/user/nmMyPage">회원정보</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/user/nmJoinList">참여기록</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" disabled>작성글</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/user/nmLikeList">관심글</a>
                        </li>
                        </ul>
                    </div>
                    </div>
                </nav>
                <!--sub 네비게이션 끝-->
                <div class="mb-5 mt-5">
                    <h2 class="text-center">작성글</h2>
                </div>

                <div class="row justify-content-center">
                	<h5 class="text-center">작성 후기 내역</h5>
                    <table class="table table-ws w-75 p-3">
                        <thead class="mb-5">
                            <tr>
                                <th scope="col" class="text-center" style="width:10%">번호</th>
                                <th scope="col" class="text-center" style="width:25%">제목</th>
                                <th scope="col" class="text-center" style="width:13%">작성자</th>
                                <th scope="col" class="text-center" style="width:20%">날짜</th>
                                <th scope="col" class="text-center" style="width:10%">조회수</th>
                                <th scope="col" class="text-center" style="width:10%"></th>
                            </tr>
                        </thead>
                        
                        <!--c:if-->
                        <tbody>
                        	<c:choose>
								<c:when test="${!empty spRevList}">
									<c:forEach var="spRevList" items="${spRevList}" varStatus="status">
		                            	<tr class="justify-content-center ws-list-hove">
			                                <td class="text-center">${spRevList.revSeq}</td>
			                                <td class="text-center">
			                                    <a href="javascript:void(0)" onclick="revListView(${spRevList.revSeq})">${spRevList.revTitle}</a>
			                                </td>
			                                <td class="text-center">${spRevList.nmNickname}</td>
			                                <td class="text-center">${spRevList.revRegDate}</td>
			                                <td class="text-center">
			                                    <fmt:formatNumber type="number" maxFractionDigits="3" value="${spRevList.revReadCnt}" />
			                                </td>
			                                <td class="text-center"><button id="spRevDelete" name="spRevDelete" type="button" onclick="spRevDelete('${spRevList.revSeq}')" class="btn btn-primary">삭제</button></td>
			                            </tr>
                            		</c:forEach>
								</c:when>
								<c:otherwise>
								<tfoot>
		                           <tr>
		                               <td colspan="5"> 작성된 글이 없습니다.</td>
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
			<c:if test="${!empty spRevPaging}">
				<c:if test="${paging.prevBlockPage gt 0}">     
					<a class="prev" href="javascript:void(0)" onclick="revListPaging(${spRevPaging.prevBlockPage})">Previous</a>  
				</c:if>   
					<c:forEach var="i" begin="${spRevPaging.startPage}" end="${spRevPaging.endPage}">
			<c:choose>
				<c:when test="${i ne spRevCurPage}">
					<a  href="javascript:void(0)" onclick="revListPaging(${i})">${i}</a>
	        	</c:when>
	        	<c:otherwise>
	        		<a class="active"href="javascript:void(0)">${i}</a>
	        	</c:otherwise>
   			</c:choose>
   		</c:forEach>
				<c:if test="${spRevPaging.nextBlockPage gt 0}">
                    <a class="next" href="javascript:void(0)" onclick="revListPaging(${spRevPaging.nextBlockPage})">Next</a>
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
				<div class="row justify-content-center">
                	<h5 class="text-center">작성 댓글 내역</h5>
                    <table class="table table-ws w-75 p-3">
                        <thead class="mb-5">
                            <tr>
                                <th scope="col" class="text-center" style="width:10%">번호</th>
                                <th scope="col" class="text-center" style="width:25%">후기제목</th>
                                <th scope="col" class="text-center" style="width:13%">작성자</th>
                                <th scope="col" class="text-center" style="width:20%">날짜</th>
                                <th scope="col" class="text-center" style="width:10%"></th>
                            </tr>
                        </thead>
                        
                        <!--c:if-->
                        <tbody>
                        	<c:choose>
								<c:when test="${!empty spRevReplyList}">
									<c:forEach var="spRevReplyList" items="${spRevReplyList}" varStatus="status">
										<c:if test="${spRevReplyList.status eq 'Y'.charAt(0)}">
		                            	<tr class="justify-content-center ws-list-hove">
			                                <td class="text-center">${spRevReplyList.replySeq}</td>
			                                <td class="text-center">
			                                    <a href="javascript:void(0)" onclick="revListView(${spRevReplyList.revSeq})">${spRevReplyList.revTitle}</a>
			                                </td>
			                                <td class="text-center">${spRevReplyList.nmNickname}</td>
			                                <td class="text-center">${spRevReplyList.replyRegDate}</td>
			                                <td class="text-center"><button id="spRevReplyDelete" name="spRevReplyDelete" type="button" onclick="spRevReplyDelete('${spRevReplyList.replySeq}')" class="btn btn-primary">삭제</button></td>
			                            </tr>
			                            </c:if>
                            		</c:forEach>
								</c:when>
								<c:otherwise>
								<tfoot>
		                           <tr>
		                               <td colspan="5"> 작성한 댓글이 없습니다.</td>
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
			<c:if test="${!empty spRevReplyPaging}">
				<c:if test="${spRevReplyPaging.prevBlockPage gt 0}">     
					<a class="prev" href="javascript:void(0)" onclick="revReplyListPaging(${spRevReplyPaging.prevBlockPage})">Previous</a>  
				</c:if>   
					<c:forEach var="i" begin="${spRevReplyPaging.startPage}" end="${spRevReplyPaging.endPage}">
			<c:choose>
				<c:when test="${i ne spRevReplyCurPage}">
					<a  href="javascript:void(0)" onclick="revReplyListPaging(${i})">${i}</a>
	        	</c:when>
	        	<c:otherwise>
	        		<a class="active"href="javascript:void(0)">${i}</a>
	        	</c:otherwise>
   			</c:choose>
   		</c:forEach>
				<c:if test="${spRevReplyPaging.nextBlockPage gt 0}">
                    <a class="next" href="javascript:void(0)" onclick="revReplyListPaging(${spRevReplyPaging.nextBlockPage})">Next</a>
                </c:if>
           	</c:if>     
           		</div>
			</div>
            <!-- 페이징 -->
		</div>
	</section>
</main><!-- End #main -->
    <form id="revListForm" name="revListForm" method="POST">
	   	<input type="hidden" id="revSeq" name="revSeq" value="">
	   	<input type="hidden" id="spRevCurPage" name="spRevCurPage" value="${spRevCurPage}">
	   	<input type="hidden" id="spRevReplyCurPage" name="spRevReplyCurPage" value="${spRevReplyCurPage}">
   </form>

<!-- ======= Footer start ======= -->
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<!-- ======= Footer e n d ======= -->

<a href="#" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

<%@ include file="/WEB-INF/views/include/vendor.jsp" %>
</c:if>
</body>
</html>