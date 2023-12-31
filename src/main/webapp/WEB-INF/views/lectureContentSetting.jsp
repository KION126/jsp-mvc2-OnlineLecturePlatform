<%@page import="java.util.List"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="org.apache.catalina.User"%>
<%@ page import="java.io.PrintWriter"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>${lec_title }</title>
<!-- bootstrap CSS 추가 -->
<link rel="stylesheet" href="./css/bootstrap.min.css">
<!-- custom CSS 추가 -->
<link rel="stylesheet" href="./css/custom.css">
</head>
<body style="background-color: #F3F2F4">
	
	<%@ include file="layout/header.jsp" %>
	
	<div class="classRoom-header-container" style="background-image: url('./image/classRoom/header.png');">
		<h3 class="classRoom-title">${lec_title }</h3>
		<h5 class="classRoom-professor">${lec_pro }</h5>
	</div>
	
	<div class="row" style="height: 800px;">
		<%@ include file="layout/lectureRoomSideBar.jsp" %>
		<div class="col-8 classRoom-main-container">
			<a href="javascript:lectureRoom(${classID})">강의실 홈</a>&nbsp;&nbsp;&nbsp;>&nbsp;&nbsp;
			<a style="font-weight: bold;" href="javascript:lectureRoomNotice(${classID }, 1)">강의 관리</a>
			<div class="classRoom-notice" style="height: 700px;">
				<h3 style="font-weight: bold; text-align: center;">강의 관리</h3>
				<button type="button" class="btn-notice-write" onclick="lectureContentWrite(${classID })">강의 추가</button>
				
				<c:forEach var="lecConInfo" items="${lecConInfoList}">
					<table class="lectureContent-table">
					<thead>
						<tr>
							<th class="noticeInfo-head-th" scope="col">${lecConInfo.title}</th>
						</tr>
						<tr class="noticeInfo-tr">
							<th class="noticeInfo-th">강의영상:
							<a href="javascript:lectureRoomBoardDownload(${classID }, ${boardID })">${not_File }</a></th>
						</tr>
						<tr class="noticeInfo-tr">
							<th class="noticeInfo-th">첨부파일:
							<a href="javascript:lectureRoomBoardDownload(${classID }, ${boardID })">${lecConInfo.file}</a></th>
						</tr>
					</thead>
					<tbody>
						<tr class="noticeInfo-tr">
							<th class="noticeInfo-con-th">${not_Con }</th>
						</tr>
					</tbody>
				</table>
				</c:forEach>
				
			</div>
		</div>
	</div>

	<%@ include file="layout/footer.jsp" %>

	<!-- bootstrap.js 추가 -->
	<script src="./js/bootstrap.bundle.min.js" /></script>
	<!-- jquery.js 추가 -->
	<script src="./js/jquery.min.js" /></script>
	<!-- popper.js 추가 -->
	<script src="./js/popper.min.js" /></script>
	<!-- sidebar.js 추가 -->
	<script src="./js/sidebar.js" /></script>
	<!-- lectureRoom.js 추가 -->
	<script src="./js/lectureRoom.js" /></script>
	<!-- lectureRoomNotice.js 추가 -->
	<script src="./js/lectureRoomNotice.js" /></script>
	<!-- lectureContentWrite.js 추가 -->
	<script src="./js/lectureContentWrite.js" /></script>
</body>
</html>