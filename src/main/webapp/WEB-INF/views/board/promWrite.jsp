<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>

<script>
<c:if test="${empty coCookie}">
	location.href="/";
</c:if>

$(document).ready(function()
{
    $('#promWriteMoEdate').prop('disabled', true);
    $('#promWriteCoSdate').prop('disabled', true);
    $('#promWriteCoEdate').prop('disabled', true);
    
    var mosdate = new Date();
    var moedate = new Date();
    var cosdate = new Date();
    var coedate = new Date();
    
	var now_utc = Date.now();
	var timeOff = new Date().getTimezoneOffset() * 60000;
	var today = new Date(now_utc-timeOff).toISOString().split("T")[0];
	
	document.getElementById("promWriteMoSdate").setAttribute("min", today);
	
	//MoSdate 선택시 -> MoEdate disabled 풀림
    $('#promWriteMoSdate').on('change', function() 
    {
        var MoSdate = $(this).val();
        mosdate = $(this).val();
        
        if(MoSdate) 
        {
            $('#promWriteMoEdate').attr('min', MoSdate);
            $('#promWriteMoEdate').prop('disabled', false);
        } 
        else 
        {
            $('#promWriteMoEdate').val('');
            $('#promWriteMoEdate').prop('disabled', true);
            
            $('#promWriteCoSdate').val('');
            $('#promWriteCoSdate').prop('disabled', true);
            
            $('#promWriteCoEdate').val('');
            $('#promWriteCoEdate').prop('disabled', true);
        }
    });
	
	//MoEdate 선택시 -> CoSdate disabled 풀림
    $('#promWriteMoEdate').on('change', function() 
    {
        var MoEdate = $(this).val();
        moedate = $(this).val();
        
        if(MoEdate) 
        {
            var MoEDate = new Date(MoEdate);
            MoEDate.setDate(MoEDate.getDate() + 1);
            var MoEDate1 = MoEDate.toISOString().split('T')[0];
            
            $('#promWriteCoSdate').attr('min', MoEDate1);
            $('#promWriteCoSdate').prop('disabled', false);
        } 
        else 
        {
            $('#promWriteCoSdate').val('');
            $('#promWriteCoSdate').prop('disabled', true);
            
            $('#promWriteCoEdate').val('');
            $('#promWriteCoEdate').prop('disabled', true);
        }
    });
	
	//CoSdate 선택시 -> CoEdate disabled 풀림
    $('#promWriteCoSdate').on('change', function() 
    {
        var CoSdate = $(this).val();
        cosdate = $(this).val();
        
        if(CoSdate) 
        {
            $('#promWriteCoEdate').attr('min', CoSdate);
            $('#promWriteCoEdate').prop('disabled', false);
        } 
        else 
        {
            $('#promWriteCoEdate').val('');
            $('#promWriteCoEdate').prop('disabled', true);
        }
    });
	
	$('#promWriteCoEdate').on('change', function()
	{
		coedate = $(this).val();
	});
	
	$("#promWriteBtn").on("click", function()
	{
		$("#promWriteBtn").prop("disabled", true) //버튼 비활성화
		
		if($.trim($("#promWriteTitle").val()).length <= 0)
		{
			alert("제목을 입력하세요.");
			$("#promWriteTitle").val("");
			$("#promWriteTitle").focus();
		
			$("#promWriteBtn").prop("disabled", false); //버튼 활성화
			return;
		}
		
		//-----------------------------------------------------
		
		if($.trim($("#promWriteMoSdate").val()).length <= 0)
		{
			alert("모집 시작일자를 입력하세요.");
			$("#promWriteBtn").prop("disabled", false); //버튼 활성화
			return;
		}
		
		if($.trim($("#promWriteMoEdate").val()).length <= 0)
		{
			alert("모집 마감일자를 입력하세요.");
			
			$("#promWriteBtn").prop("disabled", false); //버튼 활성화
			return;
		}
		
		if($.trim($("#promWriteCoSdate").val()).length <= 0)
		{
			alert("대회 시작일자를 입력하세요.");
		
			$("#promWriteBtn").prop("disabled", false); //버튼 활성화
			return;
		}
		
		if($.trim($("#promWriteCoEdate").val()).length <= 0)
		{
			alert("대회 마감일자를 입력하세요.");
			
			$("#promWriteBtn").prop("disabled", false); //버튼 활성화
			return;
		}
		
		//--------------------------------------------------------
		
		if($.trim($("#promWriteCate").val()).length <= 0)
		{
			alert("종목을 입력하세요.");
			$("#promWriteCate").val("");
			$("#promWriteCate").focus();
		
			$("#promWriteBtn").prop("disabled", false); //버튼 활성화
			return;
		}
		
		if($.trim($("#sample6_postcode").val()).length <= 0)
		{
			alert("대회장소를 기입해주세요.");
			$("#promWriteBtn").prop("disabled", false); //버튼 활성화
			return;
		}
		
		if($.trim($("#sample6_address").val()).length <= 0)
		{
			alert("대회장소를 기입해주세요.");
		
			$("#promWriteBtn").prop("disabled", false); //버튼 활성화
			return;
		}
		
		if($.trim($("#sample6_detailAddress").val()).length <= 0)
		{
			alert("상세 주소를 입력해주세요.");
			
			$("#promWriteBtn").prop("disabled", false); //버튼 활성화
			return;
		}
		
		if($.trim($("#promWritePrice").val()).length <= 0)
		{
			alert("대회 비용을 입력하세요.");
			$("#promWritePrice").val("");
			$("#promWritePrice").focus();
		
			$("#promWriteBtn").prop("disabled", false); //버튼 활성화
			return;
		}
		
		if($.trim($("#promWriteLimitCnt").val()).length <= 0)
		{
			alert("대회참가 최대인원을 입력하세요.");
			$("#promWriteLimitCnt").val("");
			$("#promWriteLimitCnt").focus();
		
			$("#promWriteBtn").prop("disabled", false); //버튼 활성화
			return;
		}
		
		if($.trim($("#promWriteContent").val()).length <= 0)
		{
			alert("내용을 입력하세요.");
			$("#promWriteContent").val("");
			$("#promWriteContent").focus();
			
			$("#promWriteBtn").prop("disabled", false); //버튼 활성화
			return;
		}
		
		//--------------------------------------------------------
		
		if(mosdate > moedate || mosdate > cosdate || mosdate > coedate)
		{
			alert("모집/대회 기간이 맞지 않아요.");
			$("#promWriteBtn").prop("disabled", false); //버튼 활성화
			return;
		}

		if(moedate > cosdate || moedate > coedate)
		{
			alert("모집/대회 기간이 맞지 않아요.");
			$("#promWriteBtn").prop("disabled", false); //버튼 활성화
			return;			
		}
		
		if(cosdate > coedate)
		{
			alert("모집/대회 기간이 맞지 않아요.");
			$("#promWriteBtn").prop("disabled", false); //버튼 활성화
			return;
		}


		//--------------------------------------------------------
		
		if(confirm("입력하신 내용으로 글을 작성하시겠어요?"))
		{
			prom_Wtire();
		}
		else
		{
			$("#promWriteBtn").prop("disabled", false); //버튼 활성화
		}
	});	
});

function prom_Wtire()
{
	var form = $("#promWriteForm") [0];
	//자바스크립트에서 폼 데이터를 다루는 객체
	var formData = new FormData(form);
	
	$.ajax
	({
		type:"POST",
		url:"/board/promWriteProc",
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
				
				document.promWriteForm.action = "/board/promList";
				document.promWriteForm.submit();
			}
			else if(response.code == 400)
			{
				alert("파라미터 값이 올바르지 않습니다.");
				$("#promWriteBtn").prop("disabled", false); //버튼 활성화
			}
			else if(response.code == 410)
			{
				alert("파일은 이미지만 가능하며, 확장자는 png, jpg, jpeg만 가능합니다.");
				$("#promWriteBtn").prop("disabled", false); //버튼 활성화
			}
			else
			{
				alert("게시물 등록중 오류가 발생했습니다.");
				$("#promWriteBtn").prop("disabled", false); //버튼 활성화
			}
		},
		error:function(error)
		{
			icia.common.error(error);
			alert("게시물 등록 중 오류가 발생하였습니다.");
			$("#promWriteBtn").prop("disabled", false); //버튼 활성화
		}
	});		 
}
</script>

</head>
<body>
<c:if test="${!empty coCookie}">
<!-- ======= Header ======= -->
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<!-- End Header -->

  <main id="main">
    <section id="contact" class="contact mb-5">
      <div class="container" data-aos="fade-up">

        <div class="row">
          <div class="col-lg-12 text-center mb-5">
            <h1 class="page-title">홍보 글 쓰기</h1>
          </div>
        </div>

        <div class="form mt-5">
          <form id="promWriteForm" name="promWriteForm" method="post" role="form" class="php-email-form">
            <table width="100%">
              <tr>
                <td width="10%">
                  게시물 제목 : 
                </td>
                <td colspan="3">
                  <div class="form-group">
                    <input type="text" class="form-control" name="promWriteTitle" id="promWriteTitle" placeholder="제목을 입력해주세요." />
                  </div>
                </td>
              </tr>
              <tr>
                <td width="10%">
                  주최자 : 
                </td>
                <td colspan="3">
                  <div class="form-group">
                  	<input type="text" class="form-control" name="coName" id="coName" value="${spCoUser.coName}" readonly/>
                  </div>
                </td>
              </tr>
              <tr>
                <td width="10%">
                  모집 기간 : 
                </td>
                <td >
                  <div class="form-group">
                    <input type="date" class="form-control" name="promWriteMoSdate" id="promWriteMoSdate" />
                  </div>
                </td>
                <td width="10%">
                  <div class="form-group" style="text-align: center;">
                    ~
                  </div>
                </td>
                <td>
                  <div class="form-group">
                    <input type="date" class="form-control" name="promWriteMoEdate" id="promWriteMoEdate" min="" max="" />
                  </div>
                </td>
              </tr>
              <tr>
                <td width="10%">
                  대회 일자 : 
                </td>
                <td >
                  <div class="form-group">
                    <input type="date" class="form-control" name="promWriteCoSdate" id="promWriteCoSdate" min="" max=""/>
                  </div>
                </td>
                <td width="10%">
                  <div class="form-group" style="text-align: center;">
                    ~
                  </div>
                </td>
                <td>
                  <div class="form-group">
                    <input type="date" class="form-control" name="promWriteCoEdate" id="promWriteCoEdate" min="" max=""/>
                  </div>
                </td>
              </tr>
              <tr>
                <td width="10%">
                  대회 종목 : 
                </td>
                <td colspan="3">
                  <div class="form-group">
                    <input type="text" class="form-control" name="promWriteCate" id="promWriteCate" placeholder="Subject" />
                  </div>
                </td>
              </tr>
              <tr>
                <td width="10%">
                  대회 장소 : 
                </td>
                <td colspan="3">
                  <div class="form-group" style="line-height:50%;">
                    <table>
                      <tr>
                        <td>
                          <input type="text" class="form-control" id="sample6_postcode" name="sample6_postcode" placeholder="우편번호" readonly/>
                        </td>
                        <td>
                          <input type="button" onclick="sample6_execDaumPostcode()" class="form-control" style="background-color: lightgray;" value="우편번호 찾기" />
                        </td>
                      </tr>
                    </table><br />
                      <input type="text" class="form-control" id="sample6_address" name="sample6_address" placeholder="주소" readonly/> <br />
                      <input type="text" class="form-control" id="sample6_detailAddress" name="sample6_detailAddress" placeholder="상세주소" />
                      <input type="hidden" id="sample6_extraAddress" placeholder="참고항목">
                  </div>
                </td>
              </tr>
              <tr>
                <td width="10%">
                  대회 참가 비용 : 
                </td>
                <td colspan="3">
                  <div class="form-group">
                    <input type="text" class="form-control" name="promWritePrice" id="promWritePrice" placeholder="Subject" style="width:300px;" />
                  </div>
                </td>
              </tr>
              <tr>
                <td width="10%">
                  모집 인원 : 
                </td>
                <td colspan="3">
                  <div class="form-group">
                    <input type="text" class="form-control" name="promWriteLimitCnt" id="promWriteLimitCnt" placeholder="Subject" style="width:300px;" />
                  </div>
                </td>
              </tr>
              <tr>
                <td width="10%">
                  행사 내용 : 
                </td>
                <td colspan="3">
                  <div class="form-group">
                    <textarea class="form-control" name="promWriteContent" id="promWriteContent" style="height:300px; resize: none;"></textarea>
                  </div>
                </td>
              </tr>
              <tr>
                <td width="10%">
                  첨부 파일 : 
                </td>
                <td colspan="3">
                  <div class="form-group">
                    <input type="file" class="form-control" name="promFile" id="promFile" placeholder="Subject" />
                  </div>
                </td>
              </tr>
            </table>
            <div class="text-center"><button class="btn btn-primary" type="button" id="promWriteBtn" name="promWriteBtn">게시글 작성</button></div>
          </form>
        </div>

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

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>
</html>