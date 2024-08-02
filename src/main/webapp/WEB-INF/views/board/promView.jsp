<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
 <style>
  .btn-like {
    background-color: var(--color-white);
    color: var(--color-black);
    border-color: var(--color-gray);
  }

  .btn-like.after{
    background-color: var(--color-red);
    color: var(--color-white);
    border-color: var(--color-red);
  }
</style>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script>
<c:if test="${empty spProm}">
	alert("잘못된 접근입니다.");
	location.href="/board/promList";
</c:if>
$(document).ready(function()
{
	$("#promListBtn").on("click", function()
	{
		document.promViewForm.action="/board/promList";
		document.promViewForm.submit();
	});	
	
	$("#promUpdateBtn").on("click", function()
	{
		document.promViewForm.action="/board/promUpdate";
		document.promViewForm.submit();
	});	
	
	$("#promViewLikeBtn").on("click", function()
	{
		$.ajax
		({
			type:"POST",
			url:"/board/promViewLikeProc",
			data:
			{
				promSeq:$("#promSeq").val()
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
					if($(".btn-like").hasClass("after"))
				    {
				    	$(".btn-like").removeClass("after");
				    }
				    else
				    {
				    	$(".btn-like").addClass("after");
				    }
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
			}
		});
	});
	
	$("#promViewApplyBtn").on("click", function()
	{
		$("#promViewApplyBtn").prop("disabled", true);
		
		if(confirm("대회에 신청하시겠어요?") == true)
		{
			var promPrice = ${spProm.promPrice};
			var promTitle = "${spProm.promTitle}";
			
			icia.ajax.post
			({
				url:"/kakao/paymentReady",
				data:
				{
					itemCode:$("#promSeq").val(),
					itemName:promTitle,
					quantity:1,
					totalAmount:promPrice
				},
				success:function(response)
				{
					icia.common.log(response)
					
					if(response.code == 200)
					{
						var orderId = response.data.orderId;
						var tId = response.data.tId;
						var pcUrl = response.data.pcUrl;  
						
						$("#orderId").val(orderId);
						$("#tId").val(tId);
						$("#pcUrl").val(pcUrl);
						
						var win = window.open('', 'kakaoPopUp', 'toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=540,height=700,left=100,top=100');
					
						$("#kakaoForm").submit();
						
						$("#promViewApplyBtn").prop("disabled", false);
					}
					else
					{
						alert("오류가 발생하였습니다.");
						$("#promViewApplyBtn").prop("disabled", false);
					}	
				},
				error:function(error)
				{
					icia.common.error(error);
					$("#promViewApplyBtn").prop("disabled", false);
				}
			});
		}
		else
		{
			$("#promViewApplyBtn").prop("disabled", false);
		}	
	});
	
	
});
function promListView(promSeq)
{
	document.promViewForm.promSeq.value = promSeq;
	document.promViewForm.action = "/board/promView";
	document.promViewForm.submit();
}

function movePage()
{
   location.href = "/user/nmJoinList";
}
</script>




<!--좋아요 버튼 script-->
<script>
  $(".btn-like").click(function()
  {
      
  });
</script>
</head>
<body>
<c:if test="${!empty spProm}">
<!-- ======= Header ======= -->
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<!-- End Header -->
  <main id="main">

    <section class="single-post-content">
      <div class="container">
        <div class="row">
          <div class="col-md-9 post-content" data-aos="fade-up">

          <!-- ======= Single Post Content ======= -->
          <div class="single-post">
            <div class="post-meta"><span class="date">작성일</span> <span class="mx-1">&bullet;</span> <span> ${spProm.promRegDate}</span></div>
            <h1 class="mb-5">${spProm.promTitle}</h1>
            <div class="post-meta" style="text-align: right;">
              <p>조회수 : ${spProm.promReadCnt}    좋아요수 : ${spProm.promLikeCnt}</p>
            </div>
      
            <div class="row gy-4">

              <div class="col-md-4">
                <div class="info-item">
                  <i class="bi bi-buildings"></i>
                  <h3>주최단체</h3>
                  <p>${spProm.coName}</p>
                </div>
              </div>
    
              <div class="col-md-4">
                <div class="info-item info-item-borders">
                  <i class="bi bi-calendar"></i>
                  <h3>접수기간</h3>
                  <p>${spProm.promMoSdate} ~ ${spProm.promMoEdate}</p>
                </div>
              </div>
    
              <div class="col-md-4">
                <div class="info-item">
                  <i class="bi bi-calendar-check"></i>
                  <h3>대회일시</h3>
                  <p>${spProm.promCoSdate} ~ ${spProm.promCoEdate}</p>
                </div>
              </div>

              <div class="col-md-4">
                <div class="info-item">
                  <i class="bi bi-person-walking"></i>
                  <h3>대회종목</h3>
                  <p>${spProm.promCate}</p>
                </div>
              </div>
    
              <div class="col-md-4">
                <div class="info-item info-item-borders">
                  <i class="bi bi-envelope"></i>
                  <h3>Email</h3>
                  <p><a href="#">${spProm.coEmail}</a></p>
                </div>
              </div>
    
              <div class="col-md-4">
                <div class="info-item">
                  <i class="bi bi-phone"></i>
                  <h3>전화번호</h3>
                  <p><a href="#">${spProm.coTel}</a></p>
                </div>
              </div>

              <div class="col-md-4">
                <div class="info-item">
                  <i class="bi bi-person-raised-hand"></i>
                  <h3>참가인원</h3>
                  <p>${spProm.promJoinCnt}/${spProm.promLimitCnt}</p>
                </div>
              </div>
    
              <div class="col-md-4">
                <div class="info-item info-item-borders">
                  <i class="bi bi-coin"></i>
                  <h3>참가비</h3>
                  <p>${spProm.promPrice}원</p>
                </div>
              </div>
              <div class="col-md-4">
                <div class="info-item info-item-borders">
                  <i class="bi bi-backpack2"></i>
                  <h3>상세 주소</h3>
                  <p>${spProm.promAddr}</p>
                </div>
              </div>
            </div>
			<c:if test="${!empty spProm.spPromFile}">
            	<img src="/resources/upload/${spProm.spPromFile.promFileName}" alt="" class="img-fluid">
			</c:if>


              <!-- 지도 API 위치 -->
              <p style="margin-top:-12px">
			    <em class="link">
			        <a href="javascript:void(0);" onclick="window.open('http://fiy.daum.net/fiy/map/CsGeneral.daum', '_blank', 'width=981, height=650')">
			        </a>
			    </em>
				</p>
			<div id="map" style="width:100%;height:350px;"></div>

              <br /><br /><br /><br />
                                      <p>${spProm.promContent}</p>
              <div class="col-md-9 d-flex justify-content-sm-beetween" style="">
	              <div class="col-12" style="">
	                  <button type="button" id="promListBtn"class="btn btn-primary" value="Post comment">리스트</button>
	              <c:if test="${spProm.coId eq coCookie}">    
	                  <button type="button" id="promUpdateBtn"class="btn btn-primary" value="Post comment">수정</button>
	              </c:if>
	              </div>
	
	              <!--css적용 확인용 jquery-->
	              <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	              <div class="col-12" style="">
	              	  <!-- 모두에게 보일때.. -->
	               <c:if test="${!empty nmCookie}"> 	
	               	<c:choose>
	               		<c:when test="${!empty spLike}">
	               			<button type="button" id="promViewLikeBtn" class="btn btn-like after"><i class="bi bi-heart" aria-hidden="true"></i> Like</button>
	               		</c:when>	               			
	               		<c:otherwise>
	               			<button type="button" id="promViewLikeBtn" class="btn btn-like"><i class="bi bi-heart" aria-hidden="true"></i> Like</button>
	               		</c:otherwise>
	               	</c:choose>  
	                  
	                 <c:if test='${spProm.promJoinCnt == spProm.promLimitCnt}'>
	                 	<button type="button" id="promViewApplyBtn" class="btn btn-primary" value="Post comment" disabled>신청마감</button>
	                 </c:if> 
	                 <c:if test='${spProm.promJoinCnt != spProm.promLimitCnt}'> 
	                 	<jsp:useBean id="now" class="java.util.Date" />

						<fmt:parseDate var="promMoSdateParseDate" value="${spProm.promMoSdate}" pattern="yyyy-MM-dd"/>
                    	<fmt:parseDate var="promMoEdateParseDate" value="${spProm.promMoEdate}" pattern="yyyy-MM-dd"/> 							
						
						<fmt:formatDate var="promMoSdateFormatDate" value="${promMoSdateParseDate}" type="DATE" pattern="yyyyMMdd"/>
						<fmt:formatDate var="promMoEdateFormatDate" value="${promMoEdateParseDate}" type="DATE" pattern="yyyyMMdd"/>
					
                    	<fmt:formatDate value="${now}" var="nowTimeFormatDate" pattern="yyyyMMdd"/>
                    	
						<fmt:parseNumber value="${nowTimeFormatDate}" var="nowTime" scope="request"/>
						<fmt:parseNumber value="${promMoSdateFormatDate}" var="promMoSdate" scope="request"/>
						<fmt:parseNumber value="${promMoEdateFormatDate}" var="promMoEdate" scope="request"/>
	                 
	                 	<c:if test='${(promMoSdate - nowTime) > 0 && (promMoEdate - nowTime) > 0}'>
	                 	</c:if>
	                 	<c:if test='${(promMoSdate - nowTime) <= 0 && (promMoEdate - nowTime) >= 0}'>
	                 		<button type="button" id="promViewApplyBtn" class="btn btn-primary" value="Post comment">신청하기</button> 
	                 	</c:if>
	                 	<c:if test="${(promMoEdate - nowTime) < 0}">
	                 		<button type="button" class="btn btn-primary" value="Post comment" disabled>신청마감</button>
	                 	</c:if>
	                 </c:if>

	               </c:if>  
	                  <!--좋아요 버튼 css-->
	                 
	              </div>
	            </div>
          </div><!-- End Single Post Content -->

          </div>
         <div class="col-md-3">    
            <!-- ======= Sidebar ======= -->
                <div class="aside-block">
    
                <ul class="nav nav-pills custom-tab-nav mb-4" id="pills-tab" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="pills-popular-tab" data-bs-toggle="pill" data-bs-target="#pills-popular" type="button" role="tab" aria-controls="pills-popular" aria-selected="true">Popular</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="pills-trending-tab" data-bs-toggle="pill" data-bs-target="#pills-trending" type="button" role="tab" aria-controls="pills-trending" aria-selected="false">Trending</button>
                    </li>
                </ul>
    
                <div class="tab-content" id="pills-tabContent">
    
                    <!-- 좋아요순-->
           	
                    <div class="tab-pane fade show active" id="pills-popular" role="tabpanel" aria-labelledby="pills-popular-tab">
                        <!--리스트 시작(8개추천)-->
			<c:choose>
				<c:when test="${!empty spPromListLike}">
					<c:forEach  var="spPromListLike" items="${spPromListLike}" varStatus="status">
                        <div class="post-entry-1 border-bottom">
                          <div class="post-meta" style="width:300px">
                            <span class="date">${spPromListLike.promCate}</span> <span>&bullet;</span>
                            <span class="float-end">
                              <img src="/resources/assets/img/pm-like.png" class="me-1" style="width:22px;height:20px;margin-bottom:0px;">
                              <span>추천수 : ${spPromListLike.promLikeCnt}</span>
                            </span>
                          </div>
                          <div class="post-meta">
                            <h2 class="my-3 d-flex" style="width:300px"><a href="javascript:void(0)" onclick="promListView(${spPromListLike.promSeq})">${spPromListLike.promTitle}</a></h2>
                            <span class="d-block mb-1 me-2">행사일자 : ${spPromListLike.promCoSdate}</span>
                            <span class="d-block mb-1 me-2">행사일자 : ${spPromListLike.promCoEdate}</span>
                            <span class="mb-3 me-2 d-block">주최자 : ${spPromListLike.coName}</span>
                          </div>
                        </div>
                        <!--리스트 끝-->
                	</c:forEach>
				</c:when>
			</c:choose>
                    </div>

                    <!-- 좋아요순 끝 -->
    
                    <!-- 조회수 시작 -->

                    <div class="tab-pane fade" id="pills-trending" role="tabpanel" aria-labelledby="pills-trending-tab">
                        <!--리스트 시작-->
			<c:choose>
				<c:when test="${!empty spPromListRead}">
					<c:forEach  var="spPromListRead" items="${spPromListRead}" varStatus="status">
                        <div class="post-entry-1 border-bottom">
                          <div class="post-meta" style="width:300px">
                            <span class="date">${spPromListRead.promCate}</span> <span>&bullet;</span>
                            <span class="float-end">
                              <img src="/resources/assets/img/pm-view.png" class="me-1" style="width:22px;height:20px;margin-bottom:0px;">
                              <span>조회수 : ${spPromListRead.promReadCnt}</span>
                            </span>
                          </div>
                          <div class="post-meta">
							<h2 class="my-3 d-flex" style="width:300px"><a href="javascript:void(0)" onclick="promListView(${spPromListRead.promSeq})">${spPromListRead.promTitle}</a></h2>
                            <span class=" d-block mb-1 me-2">행사일자 : ${spPromListRead.promCoSdate}</span>
                            <span class="d-block mb-1 me-2">행사일자 : ${spPromListRead.promCoEdate}</span>
                            <span class="mb-3 me-2 d-block">주최자 : ${spPromListRead.coName}</span>
                          </div>
                        </div>
                        <!--리스트 끝-->
					</c:forEach>
				</c:when>
			</c:choose>   
                    </div>
   
                    <!-- 조회수 끝 -->
                </div>
            </div>
    
            </div>
        </div>
    </section>
  </main><!-- End #main -->
  
    <form id="promViewForm" name="promViewForm" method="POST">
	   	<input type="hidden" id="promSeq" name="promSeq" value="${spProm.promSeq}">
	   	<input type="hidden" name="searchType" value="${searchType}">
	   	<input type="hidden" name="searchValue" value="${searchValue}">
	   	<input type="hidden" name="curPage" value="${curPage}">
   </form>
   
   <form name="kakaoForm" id="kakaoForm" method="POST" target="kakaoPopUp" action="/kakao/payPopUp">
  		 <input type="hidden" name="orderId" id="orderId" value=""/>
  		 <input type="hidden" name="tId" id="tId" value=""/>
  		 <input type="hidden" name="pcUrl" id="pcUrl" value=""/>
   </form>
<!-- ======= Footer start ======= -->
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<!-- ======= Footer e n d ======= -->

<a href="#" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

<%@ include file="/WEB-INF/views/include/vendor.jsp" %>


<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f07a95ecb9fade70ae8b76e8614d658b&libraries=services"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

// 주소로 좌표를 검색합니다
geocoder.addressSearch('<c:out value="${spProm.promRoadAddress}"/>', function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;"><c:out value="${spProm.promDetailAddress}"/></div>'
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    } 
});    
</script>
</c:if>
</body>
</html>