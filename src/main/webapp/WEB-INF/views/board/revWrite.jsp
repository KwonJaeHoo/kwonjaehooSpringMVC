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
	$("#revWriteBtn").on("click", function()
	{
		$("#revWriteBtn").prop("disabled", true) //버튼 비활성화
		
		if($.trim($("#revWriteTitle").val()).length <= 0)
		{
			alert("제목을 입력하세요.");
			$("#revWriteTitle").val("");
			$("#revWriteTitle").focus();
		
			$("#revWriteBtn").prop("disabled", false); //버튼 활성화
			return;
		}
		
		if($.trim($("#revWriteContent").val()).length <= 0)
		{
			alert("내용을 입력하세요.");
			$("#revWriteContent").val("");
			$("#revWriteContent").focus();
			
			$("#revWriteBtn").prop("disabled", false); //버튼 활성화
			return;
		}
		
		if(confirm("입력하신 내용으로 글을 작성하시겠어요?"))
		{
			rev_Wtire();
		}
		else
		{
			$("#revWriteBtn").prop("disabled", false); //버튼 활성화
		}
	}); 
}); 	

function rev_Wtire()
{
	var form = $("#revWriteForm") [0];
	//자바스크립트에서 폼 데이터를 다루는 객체
	var formData = new FormData(form);
	
	$.ajax
	({
		type:"POST",
		url:"/board/revWriteProc",
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
				alert("게시물이 등록되었습니다.");	
				
				document.revWriteForm.action = "/board/revList";
				document.revWriteForm.submit();
			}
			else if(response.code == 400)
			{
				alert("파라미터 값이 올바르지 않습니다.");
				$("#revWriteBtn").prop("disabled", false); //버튼 활성화
			}
			else if(response.code == 410)
			{
				alert("파일은 이미지만 가능하며, 확장자는 png, jpg, jpeg만 가능합니다.");
				$("#revWriteBtn").prop("disabled", false); //버튼 활성화
			}
			else
			{
				alert("게시물 등록중 오류가 발생했습니다.");
				$("#revWriteBtn").prop("disabled", false); //버튼 활성화
			}
		},
		error:function(error)
		{
			icia.common.error(error);
			alert("게시물 등록 중 오류가 발생하였습니다.");
			$("#revWriteBtn").prop("disabled", false); //버튼 활성화
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
            <h3>게시글 작성</h3>
          </div>
        </div>

        <div class="form mt-5">
          <form name="revWriteForm" id="revWriteForm" method="post" class="php-email-form" enctype="multipart/form-data">
            <div class="row">
              <div class="form-group col-md-8">
                <input type="text" class="form-control" name="revWriteTitle" id="revWriteTitle" value="" placeholder="제목" required>
              </div>
              <div class="form-group col-md-4">
                <input type="text" class="form-control" name="nmNickname" id="nmNickname" value="${spNmUser.nmNickname}" placeholder="작성자" style="background-color:#F2F2F2;" required readonly>
              </div>
            </div>
            <div class="form-group">
              <textarea class="form-control" name="revWriteContent" id="revWriteContent" rows="5" placeholder="내용" required></textarea>
            </div>
            <!-- 첨부파일 
                 이거 버튼 눌러서 첨부파일 입력할 수 있는 칸 늘어나게 하면 어떨까
                 아님 확장자 제한 둬서 이미지만 첨부 가능하게 하고 순서대로 보여주기-->
            <input type="file" id="revFile" name="revFile" class="form-control mb-2" placeholder="파일을 선택하세요." required />
            <div class="my-3">
            </div>
            <div class="text-center"><button class="btn btn-primary" type="button" id="revWriteBtn" name="revWriteBtn">완료</button></div>
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