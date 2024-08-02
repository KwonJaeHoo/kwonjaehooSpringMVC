<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title><spring:eval expression="@env['site.title']" /></title>

	<!-- Favicons -->
	<link href="/resources/assets/img/favicon.png" rel="icon">
	<link href="/resources/assets/img/apple-touch-icon.png" rel="apple-touch-icon">
	
	<!-- Google Fonts -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo&display=swap" rel="stylesheet">

	<!-- Vendor CSS Files -->
  	<link href="/resources/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  	<link href="/resources/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  	<link href="/resources/assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">
  	<link href="/resources/assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
  	<link href="/resources/assets/vendor/aos/aos.css" rel="stylesheet">

  	<!-- Template Main CSS Files -->
  	<link href="/resources/assets/css/variables.css" rel="stylesheet">
  	<link href="/resources/assets/css/main.css" rel="stylesheet">
  	<link href="/resources/assets/css/sub.css" rel="stylesheet">

	<script type="text/javascript" src="/resources/js/jquery-3.5.1.min.js"></script>
	<script type="text/javascript" src="/resources/js/icia.common.js"></script>
	<script type="text/javascript" src="/resources/js/icia.ajax.js"></script>
	
<%    
response.setHeader("Cache-Control","no-store");    
response.setHeader("Pragma","no-cache");    
response.setDateHeader("Expires",0);    
if (request.getProtocol().equals("HTTP/1.1"))  
        response.setHeader("Cache-Control", "no-cache");  
%>
