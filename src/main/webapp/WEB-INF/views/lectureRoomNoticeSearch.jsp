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
<title>DEVELOP</title>
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
			<c:choose>
				<c:when test="${boardType == 1 }">
					<a style="font-weight: bold;" href="javascript:lectureRoomNotice(${classID }, 1 ,1)">강의 공지</a>
					<c:set var="boadTitle" value="강의 공지" />
				</c:when>
				<c:otherwise>
					<a style="font-weight: bold;" href="javascript:lectureRoomNotice(${classID }, 1 ,2)">Q & A</a>
					<c:set var="boadTitle" value="Q & A" />
				</c:otherwise>
			</c:choose>
			<div class="classRoom-notice" style="height: 700px;">
				<h3 style="font-weight: bold; text-align: center;">${boadTitle }</h3>
				<div class="notice-search-container">
				    <form id="searchForm" method="post" action="lectureRoomNoticeSearch.do">
				        <select class="notice-search-select" id="searchOption" name="searchOption">
				            <option value="title">제목</option>
				            <option value="content">내용</option>
				            <option value="titleAndContent">제목+내용</option>
				        </select>
				        <input class="notice-search-input" type="text" id="searchKeyword" name="searchKeyword" placeholder="검색어를 입력하세요">
				        <input type="hidden" name="classID" value="${classID }">
				        <input type="hidden" name="boardType" value="${boardType}">
				        <button type="submit" class="btn-notice-search">검색</button>
				        <button type="button" class="btn-notice-search" onclick="javascript:lectureRoomNotice(${classID }, 1, ${boardType })">검색 취소</button>
				        <c:if test="${userType eq lectuerType }">
						    <button type="button" class="btn-lectureContent-write" onclick="lectureRoomNoticeWrite(${classID})">글쓰기</button>
						</c:if>
				    </form>
				</div>
				<table class="table table-striped table-hover">
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">제목</th>
							<th scope="col">작성자</th>
							<th scope="col">작성일</th>
							<th scope="col">조회수</th>
						</tr>
					</thead>
	
					<tbody>
						<c:forEach var="noticeInfo" items="${noticeInfoList}">
							<tr class="notice-tr" onclick="lectureRoomNoticeInfo(${classID },${noticeInfo.boardID })">						
								<th scope="row" class="noc-th">${noticeInfo.boardID }</th>
								<th class="noc-th">${noticeInfo.boardTitle }</th>
								<th class="noc-th">${noticeInfo.userName }</th>
								<th class="noc-th">${noticeInfo.boardDate }</th>
								<th class="noc-th">${noticeInfo.boardHit }</th>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="pagination">
				    <nav class="pagination-nav" aria-label="Page navigation example">
				         <ul class="pagination">
				         <c:choose>
				         <c:when test="${searchKeyword != null }">
                            <%-- 이전 링크 --%>
                            <li class="page-item ${currentPage < 2 ? 'disabled' : ''}">
                                <a class="page-link" href="javascript:lectureRoomNoticeSearch(${classID },${currentPage - 1 },'${searchOption }','${searchKeyword }')">이전</a></li>

                            <%-- 페이지 번호 링크 --%>
                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="javascript:lectureRoomNoticeSearch(${classID },${i },'${searchOption }','${searchKeyword }')">${i }</a>
                                </li>
                            </c:forEach>

                            <%-- 다음 링크 --%>
                            <li class="page-item ${currentPage > totalPages-1 ? 'disabled' : ''}">
                                <a class="page-link" href="javascript:lectureRoomNoticeSearch(${classID },${currentPage + 1 },'${searchOption }','${searchKeyword }')">다음</a></li>
                        </c:when>
                        <c:otherwise>
                        	<%-- 이전 링크 --%>
                            <li class="page-item ${currentPage < 2 ? 'disabled' : ''}">
                                <a class="page-link" href="javascript:lectureRoomNotice(${classID },${currentPage - 1 })">이전</a></li>

                            <%-- 페이지 번호 링크 --%>
                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="javascript:lectureRoomNotice(${classID },${i })">${i }</a>
                                </li>
                            </c:forEach>

                            <%-- 다음 링크 --%>
                            <li class="page-item ${currentPage > totalPages-1 ? 'disabled' : ''}">
                                <a class="page-link" href="javascript:lectureRoomNotice(${classID },${currentPage + 1 })">다음</a></li>
                        </c:otherwise>
                        </c:choose>
                        </ul>
				    </nav>
				</div>
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
	<!-- lectureRoomNotice.js 추가 -->
	<script src="./js/lectureRoomNotice.js" /></script>
	<!-- lectureRoomNoticeSearch.js 추가 -->
	<script src="./js/lectureRoomNoticeSearch.js" /></script>
	<!-- lectureRoomNoticeWrite.js 추가 -->
	<script src="./js/lectureRoomNoticeWrite.js" /></script>
	<!-- lectureRoomNoticeInfo.js 추가 -->
	<script src="./js/lectureRoomNoticeInfo.js" /></script>
</body>
</html>