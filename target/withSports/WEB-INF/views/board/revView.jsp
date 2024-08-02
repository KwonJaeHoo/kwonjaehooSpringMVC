<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script>
<c:if test="${empty spRev}">
	alert("잘못된 접근입니다.");
	location.href="/board/revList";
</c:if>

$(document).ready(function()
{
	$("#revListBtn").on("click", function()
	{
		location.href = "/board/revList"; 
	});
	
	$("#revUpdateBtn").on("click", function()
	{
		document.revViewForm.action="/board/revUpdate";
		document.revViewForm.submit();
	});	 
	
	$("#revDeleteBtn").on("click", function()
	{
		$("#revDeleteBtn").prop("disabled", true);
		
		if(confirm("글을 삭제하시겠어요?"))
		{
			rev_Delete();
		}
	});	
	
	
	$("#revReplyBtn").on("click", function()
	{
		$("#revReplyBtn").prop("disabled", true);
		
		if($.trim($("#RevReplyComment").val()).length <= 0)
		{
			alert("내용을 입력하세요.");
			$("#RevReplyComment").val("");
			$("#RevReplyComment").focus();
		
			$("#revReplyBtn").prop("disabled", false); //버튼 활성화
			return;
		}
		
		$.ajax
		({
			type:"POST",
			url:"/board/revReplyProc",
			data:
			{
				revSeq:$("#revSeq").val(),
				replyContent:$("#RevReplyComment").val()
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
					$("#revReplyBtn").prop("disabled", false);
					
					location.href = location.href;
				}
				else if(response.code == 400)
				{
					alert("파라미터 값이 올바르지 않습니다.");
					$("#revReplyBtn").prop("disabled", false);
					return;
				}
				else
				{
					alert("오류가 발생했습니다.");
					$("#revReplyBtn").prop("disabled", false);
					return;
				}	
			},
			error:function(xhr, status, error)
			{
				icia.common.error(error);
				alert("오류가 발생했습니다.");	
				$("#revReplyBtn").prop("disabled", false);
			}
		});
		
	});	
	
});

//각자 코딩해서 써주세요
function fn_reply(num)
{	
	if(num == 1)
		$("#replyDiv1").toggle();
	else if(num == 2)
		$("#replyDiv2").toggle();
}

function rev_Delete()
{
	$.ajax
	({
		type:"POST",
		url:"/board/revDeleteProc",
		data:
		{
			revSeq:$("#revSeq").val()
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
				alert("게시물 삭제되었습니다.");
				location.href="/board/revList";
			}
			else if(response.code == 400)
			{
				alert("파라미터 값이 올바르지 않습니다.");
				$("#revDeleteBtn").prop("disabled", false);
				return;
			}
			else if(response.code == 403)
			{
				alert("올바른 회원의 게시글이 아닙니다.");
				$("#revDeleteBtn").prop("disabled", false);
				return;
			}
			else if(response.code == 404)
			{
				alert("게시글이 존재하지 않습니다.");
				$("#revDeleteBtn").prop("disabled", false);
				return;
			}
			else
			{
				alert("게시물 수정중 오류가 발생했습니다.");
				$("#revDeleteBtn").prop("disabled", false);
				return;
			}	
		},
		error:function(xhr, status, error)
		{
			icia.common.error(error);
			alert("게시물 수정중 오류가 발생했습니다.");	
			$("#revDeleteBtn").prop("disabled", false);
		}
	});
}

</script>
</head>
<body>
<c:if test="${!empty spRev}">
<!-- ======= Header ======= -->
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<!-- End Header -->

  <main id="main">

    <section class="single-post-content">
      <div class="container">
        <div class="row">
          <div class="col-md-18 post-content" data-aos="fade-up">

            <!-- ======= 게시글 내용 시작 ======= -->
            <div class="single-post" >
              <div class="post-meta"><span class="date">작성일 : ${spRev.revRegDate} </span> <span class="mx-1">&bullet;</span> <span>조회수 : ${spRev.revReadCnt}</span></div>
              <h1>${spRev.revTitle}</h1>
	         <div class="d-flex align-items-center author">
             	<div class="photo"><i class="bi bi-person-circle"></i></div>
                <div class="name"> 
                  <h3 class="m-0 p-0">작성자 : ${spRev.nmNickname}</h3>
                </div>
              </div><br />
              <h3> ${spRev.revContent} </h3>
				<br/>

			  <!-- 이미지 첨부 -->
              <figure class="my-4">
              <c:if test="${!empty spRev.spRevFile}">
              	<img src="/resources/upload/${spRev.spRevFile.revFileName}"  class="img-fluid">
              </c:if>
                <!-- 이미지 밑에 캡션 달 수 있음 -->
              </figure>
            <div class="col-12 mb-2 border-bottom d-flex justify-content-end">
            <c:if test="${spRev.nmId eq nmCookie}"> 
	            <input type="button" name="revUpdateBtn" id="revUpdateBtn" class="btn btn-primary" value="수정" style="height:38px;" />&nbsp;
	            <input type="button" name="revDeleteBtn" id="revDeleteBtn" class="btn btn-primary" value="삭제" style="height:38px;" />
            </c:if>
            <br /><br />
			</div>
			
            </div><!-- 게시글 내용 끝 -->

			
            <!-- ======= 댓글 시작 ======= -->
            <div class="comments border-bottom">
              <h5 class="comment-title py-4">댓글 목록</h5>
              <div class="comment d-flex mb-4">
                <div class="flex-shrink-0">
                  <div class="avatar avatar-sm rounded-circle">
                    <img class="avatar-img" src="/resources/assets/img/person-5.jpg" alt="" class="img-fluid">
                  </div>
                </div>
                <div class="flex-grow-1 ms-2 ms-sm-3">
                  <div class="comment-meta d-flex align-items-baseline">
                  
                    <h6 class="me-2">댓글 작성자명</h6>
                    <span class="text-muted">댓글 작성 일자</span>
                  </div>
                  <div class="comment-body">댓글내용</div>
					
					<!-- 대댓글 작성 -->

                    <!-- 대댓글 작성 끝 -->
					
				  <!-- 대댓글 시작 -->
                  <div class="comment-replies bg-light p-3 mt-3 rounded">
                    
                    <!-- 대댓글 끝 -->
                    
                    <!-- 대댓글 작성 -->
                    <div id="replyDiv2" class="row justify-content-center mt-5" style="display:none; margin-left:1em">
		              <div class="col-lg-12">
		                <h5 class="comment-title"><i class="bi bi-arrow-return-right"></i>대댓글 작성</h5>
		                <div class="row">
		                  <div class="col-12 mb-3">
		                    <textarea class="form-control" id="reply-message3" placeholder="내용을 입력하세요." cols="30" rows="10" maxlength="300" style="height:62px;"></textarea>
		                  </div>
		                  <div class="col-12">
		                    <input type="submit" class="btn btn-primary" style="float:right;" value="댓글 작성">
		                  </div>
		                </div>
		              </div>
		            </div>
                    <!-- 대댓글 작성 끝 -->
                  </div>
                </div>
              </div>
              
            </div><!-- End Comments -->

            <!-- ======= 새 댓글 작성 시작 ======= -->
            
            <div class="row justify-content-center mt-5">
              <div class="col-lg-12">
                
                <c:if test="${!empty nmCookie}">
                	<h5 class="comment-title">새 댓글 작성</h5>
                	<div class="row">

                  <div class="col-lg-6 mb-3">
                    <input type="text" class="form-control" id="comment-name" value="${nmCookie}" placeholder="" style="background-color:#F2F2F2;" readonly>
                  </div>
                  

                  <form id="revReplyForm" name="revReplyForm" method="POST">
	                  <div class="col-12 mb-3">
	                    <textarea class="form-control" id="RevReplyComment" name="RevReplyComment" placeholder="내용을 입력하세요." cols="30" rows="10" maxlength="300" style="height:86px;"></textarea>
	                  </div>
	                  <div class="col-12">
	                  	<input type="button" name="revReplyBtn" id="revReplyBtn" class="btn btn-primary" style="float:right;" value="댓글 작성">
	                  </div>
                  </form>

                </div>
                  </c:if>
                <input type="button" name="revListBtn" id="revListBtn" class="btn btn-primary" value="리스트" />
              </div>
            </div>

            <!-- 새 댓글 작성 끝 -->

          </div>
        </div>
      </div>
      
    </section>
  </main><!-- End #main -->
  
    <form id="revViewForm" name="revViewForm" method="POST">
	   	<input type="hidden" id="revSeq" name="revSeq" value="${spRev.revSeq}">
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