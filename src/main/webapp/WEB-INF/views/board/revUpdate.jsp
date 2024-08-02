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
	$("#revUpdateBtn").on("click", function()
	{
		$("#revUpdateBtn").prop("disabled", true) //버튼 비활성화
		
		if($.trim($("#revUpdateTitle").val()).length <= 0)
		{
			alert("제목을 입력하세요.");
			$("#revUpdateTitle").val("");
			$("#revUpdateTitle").focus();
		
			$("#revUpdateBtn").prop("disabled", false); //버튼 활성화
			return;
		}
		
		if($.trim($("#revUpdateContent").val()).length <= 0)
		{
			alert("내용을 입력하세요.");
			$("#revUpdateContent").val("");
			$("#revUpdateContent").focus();
			
			$("#revUpdateBtn").prop("disabled", false); //버튼 활성화
			return;
		}
		
		if(confirm("입력하신 내용으로 글을 수정하시겠어요?"))
		{
			rev_Update();
		}
		else
		{
			$("#revUpdateBtn").prop("disabled", false); //버튼 활성화
		}
	}); 
	
   	<c:if test="${!empty spRev.spRevFile}">
		$("#btnFileDelete").on("click", function()
		{
			$("#uploadFile").val("N");
			$("#fileDiv").hide();
		});
	</c:if>
}); 

function rev_Update()
{
	var form = $("#revUpdateForm") [0];
	//자바스크립트에서 폼 데이터를 다루는 객체
	var formData = new FormData(form);
	
	$.ajax
	({
		type:"POST",
		url:"/board/revUpdateProc",
		enctype:"multipart/form-data",
		data:formData,
		
		//formData를 String으로 변환하지 않음.
		processData:false,
		//content-type 헤더가 multipart/form-data로 전송
		contentType:false,
		cache:false,
		timeout:600000,
		beforeSend:function(xhr)
		{
			xhr.setRequestHeader("AJAX", true);
		},
		success:function(response)
		{
			if(response.code == 200)
			{
				alert("게시물이 수정되었습니다.");	
				
				document.revUpdateForm.action = "/board/revList";
				document.revUpdateForm.submit();
			}
			else if(response.code == 400)
			{
				alert("파라미터 값이 올바르지 않습니다.");
				$("#revUpdateBtn").prop("disabled", false); //버튼 활성화
			}
			else if(response.code == 403)
			{
				alert("올바른 회원의 게시글이 아닙니다.");
				$("#revUpdateBtn").prop("disabled", false); //버튼 활성화
			}
			else if(response.code == 404)
			{
				alert("게시글이 존재하지 않습니다.");
				$("#revUpdateBtn").prop("disabled", false); //버튼 활성화
			}
			else if(response.code == 410)
			{
				alert("파일은 이미지만 가능하며, 확장자는 png, jpg, jpeg만 가능합니다.");
				$("#revUpdateBtn").prop("disabled", false); //버튼 활성화
			}
			else
			{
				alert("게시물 수정중 오류가 발생했습니다.");
				$("#revUpdateBtn").prop("disabled", false); //버튼 활성화
			}
		},
		error:function(error)
		{
			icia.common.error(error);
			alert("게시물 수정 중 오류가 발생하였습니다.");
			$("#revUpdateBtn").prop("disabled", false); //버튼 활성화
		}
	});		 
}
</script>
</head>
<body>
<c:if test="${!empty nmCookie}">
<!-- ======= Header ======= -->
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<!-- End Header -->

  <main id="main">
    <section id="contact" class="contact mb-5">
      <div class="container" data-aos="fade-up">

        <div class="row">
          <div class="col-lg-12 text-center mb-5">
            <h3>게시글 수정</h3>
          </div>
        </div>

		<div class="form mt-5">
          <form name="revUpdateForm" id="revUpdateForm" method="post" class="php-email-form" enctype="multipart/form-data">
            <input type="hidden" id="revSeq" name="revSeq" value="${spRev.revSeq}">
            <div class="row">
              <div class="form-group col-md-8">
                <input type="text" class="form-control" name="revUpdateTitle" id="revUpdateTitle" value="${spRev.revTitle}" placeholder="제목" required>
              </div>
              <div class="form-group col-md-4">
                <input type="text" class="form-control" name="nmId" id="nmId" value="${spRev.nmNickname}" placeholder="작성자" style="background-color:#F2F2F2;" required readonly>
              </div>
            </div>
            <div class="form-group">
              <textarea class="form-control" name="revUpdateContent" id="revUpdateContent" rows="5" placeholder="내용" required>${spRev.revContent}</textarea>
            </div>
            <!-- 첨부파일 
                 이거 버튼 눌러서 첨부파일 입력할 수 있는 칸 늘어나게 하면 어떨까
                 아님 확장자 제한 둬서 이미지만 첨부 가능하게 하고 순서대로 보여주기-->
            <input type="file" id="revFile" name="revFile" class="form-control mb-2" placeholder="파일을 선택하세요." required />
            <div class="my-3" id="fileDiv" class="fileDiv">
            <c:if test="${!empty spRev.spRevFile}">
		          <tr>	
		          	<td width="10%">등록된파일 : </td>
		            	<td colspan="3">
		      				<div  class="form-group">
		                    	<input type="text" class="form-control" placeholder="Subject" value="[첨부파일 : ${spRev.spRevFile.revFileOrgName}]" readonly/>
		                  	</div>
		                  	<button type="button" id="btnFileDelete" class="btn btn-primary" title="등록파일삭제">등록파일 삭제</button>
		                </td>
		          </tr>  	
      		  </c:if>
            </div>
            <div class="text-center"><button class="btn btn-primary" type="button" id="revUpdateBtn" name="revUpdateBtn">완료</button></div>
          
            <c:choose>
				<c:when test="${!empty spRev.spRevFile}">	   	
					   	<input type="hidden" name="uploadFile" id="uploadFile"value="Y">
				</c:when>
				<c:otherwise>
						<input type="hidden" name="uploadFile" id="uploadFile"value="N">
				</c:otherwise>	  
		 	</c:choose> 
          </form>
        </div><!-- End Contact Form -->

      </div>
    </section>

  </main><!-- End #main -->

<!-- ======= Footer start ======= -->
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<!-- ======= Footer e n d ======= -->

<a href="#" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>
<%@ include file="/WEB-INF/views/include/vendor.jsp" %>
</c:if>
</body>
</html>