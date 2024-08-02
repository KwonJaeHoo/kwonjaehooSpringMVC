<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/css/progress-bar.css" type="text/css">
<script type="text/javascript">
$(document).ready(function()
{
	$("#btnClose").on("click", function()
	{
		//1.내 페이지 list로 돌림
		//페이를 오픈시킨련 - opener
		opener.movePage();
		
		//2. kakao 결제창 닫기
		window.close();
	});	
});
</script>
</head>
<body>
	<div class="container">
		<c:choose>
			<c:when test="${!empty kakaoPayApprove}">
				<h2>결제가 완료되었습니다.</h2>
				결제 일시 : ${kakaoPayApprove.approved_at}<br />
				주문 번호 : ${kakaoPayApprove.partner_order_id}<br />
				상품 명  : ${kakaoPayApprove.item_name}<br />
				상품 수량 : ${kakaoPayApprove.quantity}<br />
				결제 금액 : ${kakaoPayApprove.amount.total}<br />
				결제 방법 : ${kakaoPayApprove.payment_method_type}<br />
			</c:when>
			<c:otherwise>
				<h2>결제 중 오류가 발생했습니다.</h2>
			</c:otherwise>
		</c:choose>
	</div>
	<button id="btnClose" name="btnClose" type="button">닫기</button>
</body>
</html>
