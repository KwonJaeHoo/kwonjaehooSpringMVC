<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script>
<c:if test="${empty nmCookie}">
	location.href="/";
</c:if>
$(document).ready(function()
{


});
function likePaging(curPage)
{
	document.promListForm.promSeq.value = "";
	document.promListForm.curPage.value = curPage;
	document.promListForm.action = "/user/nmLikeList";
	document.promListForm.submit();
}
function promListView(promSeq)
{
	document.promListForm.promSeq.value = promSeq;
	document.promListForm.action = "/board/promView";
	document.promListForm.submit();
}

function nmLikeDelete(promSeq)
{
	var promSub = promSeq;
	
	if(confirm("관심글을 삭제하시겠습니까?") == true)
	{
		$.ajax
		({
			type:"POST",
			url:"/board/promViewLikeProc",
			data:
			{
				promSeq:promSub
			},
			dataType:"JSON",
			beforeSend:function(xhr)
			{
				xhr.setRequestHeader("AJAX", true);
			},
			success:function(response)
			{
				if(response.code == 200)
				{
					alert("관심글 삭제가 완료되었습니다.");
					location.href = "/user/nmLikeList";
				}
				else
				{
					alert("잠시 후 다시 시도해주세요.");
					return;
				}	
			},
			error:function(xhr, status, error)
			{
				icia.common.error(error);
				alert("잠시 후 다시 시도해주세요.");
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
                        	<li class="nav-item"><a class="nav-link nav" href="/user/nmMyPage">회원정보</a></li>
                        	<li class="nav-item"><a class="nav-link" href="/user/nmJoinList">참여기록</a></li>
                        	<li class="nav-item"><a class="nav-link" href="/user/nmRevList">작성글</a></li>
                        	<li class="nav-item"><a class="nav-link active" aria-current="page" disabled>관심글</a></li>
                        </ul>
                    </div>
                </div>
            </nav>
            
			<!--sub 네비게이션 끝-->
            <div class="mb-5 mt-5">
                <h2 class="text-center">관심글</h2>
            </div>
            <div class="row justify-content-center">
            	<table class="table table-ws w-75 p-3">
                	<thead class="mb-5">
                    	<tr>
                            <th scope="col" class="text-center" style="width:5%"></th>
                            <th scope="col" class="text-center" style="width:10%">대회종목</th>
                            <th scope="col" class="text-center" style="width:25%">대회명</th>
                            <th scope="col" class="text-center" style="width:25%">신청일자</th>
                            <th scope="col" class="text-center" style="width:25%">대회일자</th>
                            <th scope="col" class="text-center" style="width:10%">스크랩</th>
                        </tr>
                    </thead>

                    <!--c:if-->
                    <tbody>
                        <!--리스트 시작-->
                        
          <c:choose>
			<c:when test="${!empty spLikeList}">
				<c:forEach var="spLikeList" items="${spLikeList}" varStatus="status">
                        <tr class="justify-content-center">
                        	<td class="text-center"><img src="/resources/assets/img/like-check.png" class="ms-4"style="width:30px;height:30px"></td>
                            <td class="text-center">${spLikeList.promCate}</td>
                            <td class="text-center"><a href="javascript:void(0)" onclick="promListView(${spLikeList.promSeq})">${spLikeList.promTitle}</a></td>
                            <td class="text-center">${spLikeList.promMoSdate} ~ ${spLikeList.promMoEdate}</td>
                            <td class="text-center">${spLikeList.promCoSdate} ~ ${spLikeList.promCoEdate}</td>
                            <td class="text-center"><button value="${spLikeList.promSeq}" id="promSeqDelete" name="promSeqDelete" type="button" onclick="nmLikeDelete(${spLikeList.promSeq})" class="btn btn-primary">삭제</button></td>
                        </tr>
                      </c:forEach>
                      </c:when>
                      <c:otherwise>
		                    <tfoot>
		                    	<tr>
		                        	<td colspan="5">관심글이 없습니다.</td>
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
							<a class="prev" href="javascript:void(0)" onclick="likePaging(${paging.prevBlockPage})">Previous</a>  
						</c:if>   
							<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
					<c:choose>
						<c:when test="${i ne curPage}">
							<a  href="javascript:void(0)" onclick="likePaging(${i})">${i}</a>
			        	</c:when>
			        	<c:otherwise>
			        		<a class="active"href="javascript:void(0)">${i}</a>
			        	</c:otherwise>
			  			</c:choose>
			  		</c:forEach>
						<c:if test="${paging.nextBlockPage gt 0}">
			                   <a class="next" href="javascript:void(0)" onclick="likePaging(${paging.nextBlockPage})">Next</a>
			               </c:if>
			          </c:if>     
                </div>
           </div>
            <!-- 페이징 -->
        </div>
    </section>
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