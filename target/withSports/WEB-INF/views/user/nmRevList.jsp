<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script>
<c:if test="${empty nmCookie}">
	location.href="/";
</c:if>

function revListPaging(curPage)
{
	document.revListForm.revSeq.value = "";
	document.revListForm.curPage.value = curPage;
	document.revListForm.action = "/user/nmRevList";
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
                    
                    <table class="table table-ws w-75 p-3">
                        <thead class="mb-5">
                            <tr>
                                <th scope="col" class="text-center" style="width:10%">번호</th>
                                <th scope="col" class="text-center" style="width:25%">제목</th>
                                <th scope="col" class="text-center" style="width:13%">작성자</th>
                                <th scope="col" class="text-center" style="width:20%">날짜</th>
                                <th scope="col" class="text-center" style="width:10%">조회수</th>
                            </tr>
                        </thead>



                        <!--c:if-->
                        <tbody>
                        	<c:choose>
								<c:when test="${!empty spRevList}">
									<c:forEach var="spRevList" items="${spRevList}" varStatus="status">
		                            	<tr class="justify-content-center ws-list-hove">
			                                <td class="text-center">${spRevList.revSeq}</td>
			                                <td class="ps-5">
			                                    <a href="javascript:void(0)" onclick="revListView(${spRevList.revSeq})">${spRevList.revTitle}</a>
			                                </td>
			                                <td class="text-center">${spRevList.nmNickname}</td>
			                                <td class="text-center">${spRevList.revRegDate}</td>
			                                <td class="text-center">
			                                    <fmt:formatNumber type="number" maxFractionDigits="3" value="${spRevList.revReadCnt}" />
			                                </td>
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
            <!-- 페이징 -->

        </section>



    </main><!-- End #main -->
    <form id="revListForm" name="revListForm" method="POST">
	   	<input type="hidden" id="revSeq" name="revSeq" value="">
	   	<input type="hidden" name="searchType" value="${searchType}">
	   	<input type="hidden" name="searchValue" value="${searchValue}">
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