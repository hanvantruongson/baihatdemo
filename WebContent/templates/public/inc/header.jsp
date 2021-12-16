<%@page import="models.User"%>
<%@page import="constants.GlobalConstant"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="models.Song"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
<head>
<title>Chia sẻ hợp âm</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="<%=GlobalConstant.URL_PUBLIC %>/css/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="<%=GlobalConstant.URL_PUBLIC %>/css/coin-slider.css" />
<script type="text/javascript" src="<%=GlobalConstant.URL_PUBLIC %>/js/jquery-3.2.1.js"></script>
<script type="text/javascript" src="<%=GlobalConstant.URL_PUBLIC %>/js/script.js"></script>
<script type="text/javascript" src="<%=GlobalConstant.URL_PUBLIC %>/js/coin-slider.min.js"></script>
<script type="text/javascript" src="<%=GlobalConstant.URL_PUBLIC %>/js/jquery.raty.min.js"></script>
</head>
<body>
<div class="main">
 
	<div class="header-menu">     <div class="logo">
        <h1><a href="<%=request.getContextPath()%>/home">Chia sẻ hợp âm</a></h1>
      </div>
      <div class="menu_nav">
        <ul>
        	<li><a href="<%=request.getContextPath()%>/chords"><span>Hợp âm</span></a></li>
        	<%
            	if(session.getAttribute("userLogin")!=null){
            		User userLogin = (User) session.getAttribute("userLogin");
            %>
          	<li><a href="<%=request.getContextPath()%>/admin" style="<%if(!"admin".equals(userLogin.getUsername())) out.print("display: none"); %>"> 
          	<span>Quản lý</span></a></li>
            <div style="color: black; padding: 12px 12px; float: right;font-size: 14px; font-family: arial;"> Xin chào, <b><%=userLogin.getFullname() %></b> &nbsp; <a href="<%=request.getContextPath() %>/logout" class="btn btn-danger square-btn-adjust">Đăng xuất</a> </div>
            <%}  else {  %>
          	<li><a href="<%=request.getContextPath()%>/login"><span>Đăng nhập</span></a></li>
          	<li><a href="<%=request.getContextPath()%>/register"><span>Đăng ký</span></a></li>
           <%} %>
        </ul>
      </div></div>
 
	<div class="content-wrapper">
      <div class="slider">
        <div id="coin-slider">
	        <a href="#"><img src="<%=GlobalConstant.URL_PUBLIC %>/images/banner1.jpg" width="935" height="307" alt="" /></a> 
	        <a href="#"><img src="<%=GlobalConstant.URL_PUBLIC %>/images/banner2.jpg" width="935" height="307" alt="" /></a> 
	        <a href="#"><img src="<%=GlobalConstant.URL_PUBLIC %>/images/banner3.jpg" width="935" height="307" alt="" /></a>
        </div>
      
      </div>
   
   <div class="content">

 