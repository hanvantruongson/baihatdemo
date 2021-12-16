<%@page import="daos.ChordsDao"%>
<%@page import="daos.UserDao"%>
<%@page import="daos.CatDao"%>
<%@page import="daos.SongDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/templates/admin/inc/header.jsp" %>
<%@ include file="/templates/admin/inc/leftbar.jsp" %>
<div id="page-wrapper">
    <div id="page-inner">
        <div class="row">
            <div class="col-md-12">
                <h2>QUẢN TRỊ VIÊN</h2>
            </div>
        </div>
        <!-- /. ROW  -->
        <hr />
        <%
        SongDao songDao = new SongDao();
        CatDao catDao = new CatDao();
        UserDao userDao = new UserDao();
        ChordsDao chordsDao = new ChordsDao();
        %>
        <div class="row">
            <div class="col-md-4 col-sm-4 col-xs-4">
                <div class="panel panel-back noti-box">
                    <span class="icon-box bg-color-blue set-icon">
                    <i class="fa fa-list"></i>
                </span>
                    <div class="text-box">
                        <p class="main-text"><a href="<%=request.getContextPath() %>/admin/cats" title="">Quản lý danh mục</a></p>
                        <p class="text-muted">Có <%=catDao.numberOfItems() %> danh mục</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 col-sm-4 col-xs-4">
                <div class="panel panel-back noti-box">
                    <span class="icon-box bg-color-blue set-icon">
                    <i class="fa fa-music"></i>
                </span>
                    <div class="text-box">
                        <p class="main-text"><a href="<%=request.getContextPath() %>/admin/songs" title="">Quản lý bài hát</a></p>
                        <p class="text-muted">Có <%=songDao.numberOfItems() %> bài hát</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 col-sm-4 col-xs-4">
                <div class="panel panel-back noti-box">
                    <span class="icon-box bg-color-blue set-icon">
                    <i class="fa fa-th"></i>
                </span>
                    <div class="text-box">
                        <p class="main-text"><a href="<%=request.getContextPath() %>/admin/chords" title="">Quản lý hợp âm</a></p>
                        <p class="text-muted">Có <%=chordsDao.numberOfItems() %> hợp âm</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 col-sm-4 col-xs-4">
                <div class="panel panel-back noti-box">
                    <span class="icon-box bg-color-blue set-icon">
                    <i class="fa fa-user"></i>
                </span>
                    <div class="text-box">
                        <p class="main-text"><a href="<%=request.getContextPath() %>/admin/users" title="">Quản lý người dùng</a></p>
                        <p class="text-muted">Có <%=userDao.numberOfItems() %> người dùng</p>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
<script>
    document.getElementById("index").classList.add('active-menu');
</script>
<!-- /. PAGE WRAPPER  -->
<%@ include file="/templates/admin/inc/footer.jsp" %>