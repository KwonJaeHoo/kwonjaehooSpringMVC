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

function JoinCancel(partnerOrderId)
{
	if(confirm("결제를 취소하시겠어요?") == true)
	{
		var joinPartnerOrderId = partnerOrderId;
		
		icia.ajax.post
		({
			url:"/kakao/paymentCancel",
			data:
			{
				partnerOrderId : joinPartnerOrderId
			},
			success:function(response)
			{
				icia.common.log(response)
				
				if(response.code == 200)
				{
					alert("결제취소가 완료되었습니다.");
					location.href = "/user/nmJoinList";
				}
				else
				{
					alert("오류가 발생하였습니다.");
				}	
			},
			error:function(error)
			{
				icia.common.error(error);
			}
		});
	}
}



function joinApprovePaging(approveCurPage)
{
	document.promListForm.promSeq.value = "";
	document.promListForm.approveCurPage.value = approveCurPage;
	document.promListForm.action = "/user/nmJoinList";
	document.promListForm.submit();
}

function joinCancelPaging(cancelCurPage)
{
	document.promListForm.promSeq.value = "";
	document.promListForm.cancelCurPage.value = cancelCurPage;
	document.promListForm.action = "/user/nmJoinList";
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
                        	<li class="nav-item"><a class="nav-link active" aria-current="page" disabled>참여기록</a></li>
                        	<li class="nav-item"><a class="nav-link" href="/user/nmRevList">작성글</a></li>
                        	<li class="nav-item"><a class="nav-link" href="/user/nmLikeList">관심글</a></li>
                        </ul>
                    </div>
				</div>
			</nav>
            
            <!--sub 네비게이션 끝-->
			<div class="mb-5 mt-5">
            	<h2 class="text-center">참여기록</h2>
            </div>

            <div class="row justify-content-center">
            	<h5 class="text-center">결제내역</h5>
            	<table class="table table-ws w-75 p-3">
                	<thead class="mb-5">
                    	<tr>
                        	<th scope="col" class="text-center" style="width:5%"></th>
                            <th scope="col" class="text-center" style="width:25%">대회명</th>
                            <th scope="col" class="text-center" style="width:10%">가격</th>
                            <th scope="col" class="text-center" style="width:20%">결제일자</th>
                            <th scope="col" class="text-center" style="width:15%"></th>
                        </tr>
                    </thead>

					<!--c:if-->
					<tbody>
	                	<!--리스트 시작-->
		<c:choose>
			<c:when test="${!empty joinApproveList}">
				<c:forEach var="joinApproveList" items="${joinApproveList}" varStatus="status">	
	                	
	                	<tr class="justify-content-center">
	                    	<td class="text-center"><img src="/resources/assets/img/join-medal.png" class="ms-4"style="width:30px;height:30px"></td>  
	                        <td class="text-center"><a href="javascript:void(0)" onclick="promListView(${joinApproveList.itemCode})">${joinApproveList.itemName}</a></td>
	                        <td class="text-center">${joinApproveList.totalAmount}</td>
	                        <td class="text-center"><fmt:formatDate value="${joinApproveList.approvedAt}" type="DATE" pattern="yyyy-MM-dd HH:mm:ss"/></td>
	                        
	                        <c:if test="${joinApproveList.status eq 'Y'.charAt(0)}">
	                            <jsp:useBean id="now" class="java.util.Date" />
		                        <fmt:formatDate value="${joinApproveList.promCoSdate}" var="promCoSdateFormatDate" pattern="yyyyMMdd" />
		                        <fmt:formatDate value="${joinApproveList.approvedAt}" var="approveAtFormatDate" pattern="yyyyMMdd"/>
		                        <fmt:formatDate value="${now}" var="nowTimeFormatDate" pattern="yyyyMMdd"/>
		                        
		                        <fmt:parseNumber value="${promCoSdateFormatDate}" var="promCoSdate" scope="request"/>
	 	                        <fmt:parseNumber value="${approveAtFormatDate}" var="approveAt" scope="request"/>
	 	                        <fmt:parseNumber value="${nowTimeFormatDate}" var="nowTime" scope="request"/>
	                        
		               			<c:if test="${approveAt - nowTime > -4}">
		                        	<c:if test="${promCoSdate - nowTime > 0}">
		                        		<td class="text-center"><button value="${joinApproveList.partnerOrderId}" id="JoinCancelBtn" name="JoinCancelBtn" type="button" onclick="JoinCancel('${joinApproveList.partnerOrderId}')" class="btn btn-primary">결제취소</button></td>
		                        	</c:if>
		                        	<c:if test="${promCoSdate - nowTime <= 0}">
										<td class="text-center">결제 완료</td>
		                        	</c:if>	
		                        </c:if>
		                        <c:if test="${approveAt - nowTime <= -4}">
		                        	<td class="text-center">결제 완료</td>
		                        </c:if>
	                        </c:if>
	                        <c:if test="${joinApproveList.status eq 'C'.charAt(0)}">
	                        	<td class="text-center">결제 취소</td>
	                        </c:if>
	                	</tr>
	                	</c:forEach>
                      </c:when>
                      <c:otherwise>
		                    <tfoot>
		                    	<tr>
		                        	<td colspan="5">참가한 기록이 없습니다.</td>
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
					<c:if test="${!empty joinApprovePaging}">
						<c:if test="${joinApprovePaging.prevBlockPage gt 0}">     
							<a class="prev" href="javascript:void(0)" onclick="joinApprovePaging(${joinApprovePaging.prevBlockPage})">Previous</a>  
						</c:if>   
							<c:forEach var="i" begin="${joinApprovePaging.startPage}" end="${joinApprovePaging.endPage}">
					<c:choose>
						<c:when test="${i ne approveCurPage}">
							<a  href="javascript:void(0)" onclick="joinApprovePaging(${i})">${i}</a>
			        	</c:when>
			        	<c:otherwise>
			        		<a class="active"href="javascript:void(0)">${i}</a>
			        	</c:otherwise>
			  			</c:choose>
			  		</c:forEach>
						<c:if test="${joinApprovePaging.nextBlockPage gt 0}">
			                   <a class="next" href="javascript:void(0)" onclick="joinApprovePaging(${joinApprovePaging.nextBlockPage})">Next</a>
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
            	<h5 class="text-center">취소내역</h5>
            	<table class="table table-ws w-75 p-3">
                	<thead class="mb-5">
                    	<tr>
                        	<th scope="col" class="text-center" style="width:5%"></th>
                            <th scope="col" class="text-center" style="width:25%">대회명</th>
                            <th scope="col" class="text-center" style="width:10%">가격</th>
                            <th scope="col" class="text-center" style="width:20%">취소일자</th>
                            <th scope="col" class="text-center" style="width:15%"></th>
                        </tr>
                    </thead>

					<!--c:if-->
					<tbody>
	                	<!--리스트 시작-->
		<c:choose>
			<c:when test="${!empty joinCancelList}">
				<c:forEach var="joinCancelList" items="${joinCancelList}" varStatus="status">	
	                	
	                	<tr class="justify-content-center">
	                    	<td class="text-center"><img src="/resources/assets/img/join-medal.png" class="ms-4"style="width:30px;height:30px"></td>  
	                        <td class="text-center"><a href="javascript:void(0)" onclick="promListView(${joinCancelList.itemCode})">${joinCancelList.itemName}</a></td>
	                        <td class="text-center">${joinCancelList.cancelTotalAmount}</td>
	                        <td class="text-center"><fmt:formatDate value="${joinCancelList.canceledAt}" type="DATE" pattern="yyyy-MM-dd HH:mm:ss"/></td>
	                        <td class="text-center"></td>
	                	</tr>
	                	</c:forEach>
                      </c:when>
                      <c:otherwise>
		                    <tfoot>
		                    	<tr>
		                        	<td colspan="5">취소 내역이 없습니다.</td>
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
					<c:if test="${!empty joinCancelPaging}">
						<c:if test="${joinCancelPaging.prevBlockPage gt 0}">     
							<a class="prev" href="javascript:void(0)" onclick="joinCancelPaging(${joinCancelPaging.prevBlockPage})">Previous</a>  
						</c:if>   
							<c:forEach var="i" begin="${joinCancelPaging.startPage}" end="${joinCancelPaging.endPage}">
					<c:choose>
						<c:when test="${i ne cancelCurPage}">
							<a  href="javascript:void(0)" onclick="joinCancelPaging(${i})">${i}</a>
			        	</c:when>
			        	<c:otherwise>
			        		<a class="active"href="javascript:void(0)">${i}</a>
			        	</c:otherwise>
			  			</c:choose>
			  		</c:forEach>
						<c:if test="${joinCancelPaging.nextBlockPage gt 0}">
			                   <a class="next" href="javascript:void(0)" onclick="joinCancelPaging(${joinCancelPaging.nextBlockPage})">Next</a>
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
	   	<input type="hidden" id="approveCurPage" name="approveCurPage" value="${approveCurPage}">
	   	<input type="hidden" id="cancelCurPage" name="cancelCurPage" value="${cancelCurPage}">
   	</form>

<!-- ======= Footer start ======= -->
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<!-- ======= Footer e n d ======= -->

<a href="#" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

<%@ include file="/WEB-INF/views/include/vendor.jsp" %>
</c:if>
</body>
</html>