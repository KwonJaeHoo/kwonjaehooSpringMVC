<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
<script>
<c:if test="${empty spRev}">
	alert("잘못된 접근입니다.");
	location.href="/board/revList";
</c:if>

$(document).ready(function()
{
	$("#revListBtn").on("click", function()
	{
		document.revViewForm.revSeq.value = "";
		document.revViewForm.action="/board/revList"; 
		document.revViewForm.submit();
	});
	
	$("#revUpdateBtn").on("click", function()
	{
		document.revViewForm.action="/board/revUpdate";
		document.revViewForm.submit();
	});	 
	
	$("#revDeleteBtn").on("click", function()
	{
		$("#revDeleteBtn").prop("disabled", true);
		
		if(confirm("게시글을 삭제하시겠어요?") == true)
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
						alert("게시글이 삭제되었습니다.");
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
						alert("게시물 삭제중 오류가 발생했습니다.");
						$("#revDeleteBtn").prop("disabled", false);
						return;
					}	
				},
				error:function(xhr, status, error)
				{
					icia.common.error(error);
					alert("게시물 삭제중 오류가 발생했습니다.");	
					$("#revDeleteBtn").prop("disabled", false);
				}
			});
		}
	});	
	
	$("#revBtn").on("click", function()
	{
		$("#revBtn").prop("disabled", true);
		
		if($.trim($("#RevReplyComment").val()).length <= 0)
		{
			alert("내용을 입력하세요.");
			$("#RevReplyComment").val("");
			$("#RevReplyComment").focus();
		
			$("#revBtn").prop("disabled", false); //버튼 활성화
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
					$("#revBtn").prop("disabled", false);
					
					revLocation();
				}
				else if(response.code == 400)
				{
					alert("파라미터 값이 올바르지 않습니다.");
					$("#revBtn").prop("disabled", false);
					return;
				}
				else
				{
					alert("오류가 발생했습니다.");
					$("#revBtn").prop("disabled", false);
					return;
				}	
			},
			error:function(xhr, status, error)
			{
				icia.common.error(error);
				alert("오류가 발생했습니다.");	
				$("#revBtn").prop("disabled", false);
			}
		});
	});	
});

function revLocation()
{
	document.revViewForm.action="/board/revView";
	document.revViewForm.submit();
}


function revReplyBtn(replySeq)
{
	var addCommentBox =
		`
		<div class="row justify-content-center mt-5">
           	<div class="col-lg-12">
               	<h5 class="comment-title">대댓글 작성</h5>
           		<div class="row">
           			<div class="col-lg-6 mb-3">
               			<input type="text" class="form-control" id="comment-name" value="${spNmUser.nmNickname}" style="background-color:#F2F2F2;" readonly>
             		</div>
             		<form>
                        <div class="col-12 mb-3">
                            <textarea class="form-control" id="RevReplyCommentAdd" placeholder="내용을 입력하세요." cols="30" rows="10" maxlength="300" style="height:86px;"></textarea>
                        </div>
                        <div class="col-12">
                            <input type="button" class="btn btn-primary" id="revReplyBtnAdd" style="float:right;" value="댓글 작성">
                        </div>
                    </form>
           		</div>
        	</div>
		</div>
		`;
		
		$('#revReplyComment' + replySeq).after(addCommentBox);
		$("#revReplyCommentBtn" + replySeq).prop("disabled", true);
		document.querySelector('#RevReplyCommentAdd').id = 'RevReplyCommentAdd' + replySeq;	
		document.querySelector('#revReplyBtnAdd').id = 'revReplyBtnAdd' + replySeq;	

		
        document.getElementById("revReplyBtnAdd" + replySeq).addEventListener("click", function()
        {
            revReplyCommentBtn(replySeq);
        });
                
}

function revReplyCommentBtn(replySeq)
{
	var replyCommentSeq = replySeq;

	$("#revReplyBtnAdd" + replySeq).prop("disabled", true);
	
	if($.trim($("#RevReplyCommentAdd" + replySeq).val()).length <= 0)
	{
		alert("내용을 입력하세요.");
		$("#RevReplyCommentAdd" + replySeq).val("");
		$("#RevReplyCommentAdd" + replySeq).focus();
	
		$("#revReplyBtnAdd" + replySeq).prop("disabled", false);
		return;
	}
	
	$.ajax
	({
		type : "POST",
		url : "/board/revReplyCommnetProc",
		async : "true",
		dataType : "JSON",
		data : 
		{
			revSeq:$("#revSeq").val(),
			replySeq : replyCommentSeq,
			replyContent : $("#RevReplyCommentAdd" + replySeq).val()
		},
		success : function(response)
		{
			if(response.code == 200)
			{
				revLocation();
			}
			else
			{
				alert("오류가 발생했습니다. 다시 시도해주세요.");
				return;		
			}	
		},
		error : function(xhr, status, error)
		{
			alert("오류가 발생했습니다. 다시 시도해주세요.");
			return;			
		}		
	});


}

function revReplyDeleteBtn(replySeq)
{
	var replyDeleteSeq = replySeq;
	
	if(confirm("댓글을 삭제하시겠어요?") == true)
	{
		$.ajax
		({
			type : "POST",
			url : "/board/revReplyDeleteProc",
			async : "true",
			dataType : "JSON",
			data : 
			{
				replySeq : replyDeleteSeq
			},
			success : function(response)
			{
				icia.common.log(response)
				
				if(response.code == 200)
				{
					alert("삭제가 완료되었습니다.");
					revLocation();
				}
				else
				{
					alert("오류가 발생했습니다. 다시 시도해주세요.");
					return;		
				}	
			},
			error : function(xhr, status, error)
			{
				alert("오류가 발생했습니다. 다시 시도해주세요.");
				return;		
			}	
		});
	}
}

</script>
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
              	<h3> ${spRev.revContent} </h3><br/>
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
			</div>
<!-- 게시글 내용 끝 -->

 <!-- ======= 댓글 시작 ======= -->
            <div class="comments border-bottom">
            	<h5 class="comment-title py-4">댓글 목록</h5>
           	</div>
			<c:choose>
				<c:when test="${!empty spRev.spRevReplyList}">
					<c:forEach  var="spRevReplyList" items="${spRev.spRevReplyList}" varStatus="status">
            <div class="comments"><br /></div>
           	<div class="comments border-bottom" id="revReplyComment${spRevReplyList.replySeq}">
           	<c:if test="${spRevReplyList.replyOrder == 0}">
           		<c:if test="${spRevReplyList.status eq 'Y'.charAt(0)}">
              	<div class="comment d-flex mb-4">
                	<div class="flex-shrink-0"></div>
                	<div class="flex-grow-1 ms-2 ms-sm-3">
                  		<div class="comment-meta d-flex align-items-baseline">
							<h6 class="me-2">${spRevReplyList.nmNickname}</h6>
                    		<span class="text-muted">${spRevReplyList.replyRegDate}</span>
                  		</div>
                  		<div class="comment-body">${spRevReplyList.replyContent}</div>
						<div class="col-12 mb-2 d-flex justify-content-end">
							<c:if test="${spRevReplyList.nmId eq nmCookie}"> 
					            <input type="button" name="repReplyDeleteBtn" id="repReplyDeleteBtn" class="btn btn-primary" onclick="revReplyDeleteBtn(${spRevReplyList.replySeq})" value="삭제" style="height:38px;" />&nbsp;
				            </c:if>
				            <c:if test="${!empty nmCookie}">
				            	<input type="button" name="revReplyCommentBtn${spRevReplyList.replySeq}" id="revReplyCommentBtn${spRevReplyList.replySeq}" class="btn btn-primary" onclick="revReplyBtn(${spRevReplyList.replySeq})" value="대댓글달기" style="height:38px;" />
							</c:if>
							<br />
						</div>

					<!-- 대댓글 작성 -->

                    <!-- 대댓글 작성 끝 -->
                	</div>
              	</div>
              	</c:if>
              	<c:if test="${spRevReplyList.status eq 'C'.charAt(0)}">
              	<br />
				<div class="comment d-flex mb-4">
                	<div class="flex-shrink-0"></div>
                	<div class="flex-grow-1 ms-2 ms-sm-3">
                  		<div class="comment-meta d-flex align-items-baseline">
							<h6 class="me-2">삭제된 댓글입니다.</h6>
                    		<span class="text-muted"></span>
                  		</div>
                  		<div class="comment-body"></div>
						<div class="col-12 mb-2 d-flex justify-content-end">
							<br />
						</div>
                	</div>
              	</div>
              	</c:if>
            </c:if>
            <c:if test="${spRevReplyList.replyOrder > 0}">
            	<c:if test="${spRevReplyList.status eq 'Y'.charAt(0)}">
			<div class="comment d-flex mb-4">
                	<div class="flex-shrink-0"></div>
                	<div class="flex-grow-1 ms-2 ms-sm-5">
						<i class="bi bi-arrow-return-right"></i>
                  		<div class="comment-meta d-flex align-items-baseline">
							<h6 class="me-2">${spRevReplyList.nmNickname}</h6>
                    		<span class="text-muted">${spRevReplyList.replyRegDate}</span>
                  		</div>
                  		<div class="comment-body">${spRevReplyList.replyContent}</div>
						<div class="col-12 mb-2 d-flex justify-content-end">
							<c:if test="${spRevReplyList.nmId eq nmCookie}"> 
    							<input type="button" name="repReplyDeleteBtn" id="repReplyDeleteBtn" class="btn btn-primary" onclick="revReplyDeleteBtn(${spRevReplyList.replySeq})" value="삭제" style="height:38px;" />&nbsp;
				            </c:if>
				            <br />
						</div>
                	</div>
              	</div>
				</c:if>
				<c:if test="${spRevReplyList.status eq 'C'.charAt(0)}">
				<br />
				<div class="comment d-flex mb-4">
                	<div class="flex-shrink-0"></div>
                	<div class="flex-grow-1 ms-2 ms-sm-5">
                  		<div class="comment-meta d-flex align-items-baseline">
							<h6 class="me-2">삭제된 대댓글입니다.</h6>
                    		<span class="text-muted"></span>
                  		</div>
                  		<div class="comment-body"></div>
						<div class="col-12 mb-2 d-flex justify-content-end">
							<br />
						</div>
                	</div>
              	</div>
				</c:if>
			</c:if>
            </div>
            <!-- End Comments -->
				</c:forEach>
			</c:when>
			<c:otherwise>
			<div class="comments"><br /></div>
				<div class="comments border-bottom">
		    		<div class="comment d-flex mb-4">
		            	<div class="flex-shrink-0"></div>
		                	<div class="flex-grow-1 ms-2 ms-sm-3">
		                  		<div class="comment-meta d-flex align-items-baseline"><h5>작성된 댓글이 없습니다.</h5></div>
		                  	</div>
		           	</div>
		        </div>
			</c:otherwise>
		</c:choose>		
		
<!-- ======= 새 댓글 작성 시작 ======= -->
            
				<div class="row justify-content-center mt-5">
	            	<div class="col-lg-12">
	                <c:if test="${!empty nmCookie}">
	                	<h5 class="comment-title">새 댓글 작성</h5>
	                		<div class="row">
	                			<div class="col-lg-6 mb-3">
	                    			<input type="text" class="form-control" id="comment-name" value="${spNmUser.nmNickname}" style="background-color:#F2F2F2;" readonly>
	                  			</div>
	                  			<form id="revReplyForm" name="revReplyForm" method="POST">
			                  		<div class="col-12 mb-3">
			                    		<textarea class="form-control" id="RevReplyComment" name="RevReplyComment" placeholder="내용을 입력하세요." cols="30" rows="10" maxlength="300" style="height:86px;"></textarea>
			                  		</div>
			                  		<div class="col-12">
			                  			<input type="button" name="revBtn" id="revBtn" class="btn btn-primary" style="float:right;" value="댓글 작성">
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
</main>
<!-- End #main -->

	<form id="revViewForm" name="revViewForm" method="POST">
	   	<input type="hidden" id="revSeq" name="revSeq" value="${spRev.revSeq}">
	   	<input type="hidden" name="searchType" value="${searchType}">
	   	<input type="hidden" name="searchValue" value="${searchValue}">
	   	<input type="hidden" name="curPage" value="${curPage}">
		<input type="hidden" name="searchSort" value="${searchSort}">
   	</form>

<!-- ======= Footer start ======= -->
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<!-- ======= Footer e n d ======= -->

<a href="#" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>
<%@ include file="/WEB-INF/views/include/vendor.jsp" %>
</c:if>
</body>
</html>