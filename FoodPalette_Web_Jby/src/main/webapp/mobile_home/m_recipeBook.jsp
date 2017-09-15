<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../home/jsp_header.jsp" %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<script src="http://code.jquery.com/jquery-2.0.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<meta name="format-detection" content="telephone=no">
<meta name="msapplication-tap-highlight" content="no">
<meta name="viewport" content="user-scalable=no, initial-scale=1, maximum-scale=1, minimum-scale=1, width=device-width">
<title>Insert title here</title>
</head>
<body>
<div data-role="page">
<div data-role="header"  data-position="fixed" style="background-color:white;">
	<table width="100%" align="center" style="border:0px solid lightgray;">
	<tr>
		<td width="33%">
		</td>
		<td width="33%" align="center">
			<img src="../image/m_title2.png" style="padding:5px;"/>
		</td>
		<td width="33%" align="right">
			<img align="right" src="../image/search_icon.png" class="opensearch" width="15px" height="15px" style="padding:5px; padding-right:10px; "/>				</td>
	</tr>
	</table>
	<div class="search_field" style="display:none; background-color:white;">
		<input name="search" id="search" value="" placeholder="검색" type="search" data-theme="b" style="font-size:11px;"/>
	</div>
</div>
<div data-role="content">
	<!-- 내 스크랩북 -->
	<table align="center" width="100%">
	<tr style="border-top:1px solid lightgray;">
		<td align="left" colspan="3" style="padding-left:40px; padding-top:20px; padding-bottom:40px;">
			<font color="gray" style="font-weight:bold;">
				내가 스크랩한 레시피
			</font>
		</td>
	</tr>
	<c:choose>
	<c:when test="${empty FIRST_IMGS[0]}">
	<tr>
		<td align="center">
			<div style="margin-bottom:60px;">
				<font color="gray">내가 스크랩한 레시피가 없습니다.</font>
			</div>
		</td>
	</tr>
	</c:when>
	<c:otherwise>
	<!-- 총 게시물갯수/3만큼 반복 -->
	<c:forEach var="i" begin="0" end="${MAX-1}">
	<tr border="0">
		<c:forEach var="num" begin="${TR_INDEX[i]*3-2}" end="${TR_INDEX[i]*3}"><!-- 첫번째게시물부터 3개씩 뿌려줌. 1줄*1번째,1*2,1*3 / 4,5,6 / 7,8,9 -->
		<c:if test="${!empty FIRST_IMGS[num-1]}">
		<td align="center" border="0">
			<!-- 5.9 jung -->
			<a href="../mobile_List/recipe_selected.html?id=${LIST[num-1].recipe_id}" rel="external">
					<!-- 게시물의 첫번째이미지 뿌려줌  -->
					<img src="${pageContext.request.contextPath}/upload/${FIRST_IMGS[num-1]}" width="100px" height="100px"/>
			</a>
		</td>
		</c:if>
		</c:forEach>
	</tr>
	</c:forEach>
	</c:otherwise>
	</c:choose>
	</table>
</div>

<div data-role="footer" data-position="fixed" style="background-color:white;">
		<table width="100%" align="center" >
			<tr>
				<td align="center">
					<a href="../mobile_List/recipe_list.html">
						<img src="../image/home_icon.png" width="25px" height="25px" style="padding:5px;">
					</a>
				</td>
				<td align="center">
					<a href="../mobile_Recipebook/m_my_clip_list.html" rel="external">
						<img src="../image/book_icon.png" width="25px" height="25px" style="padding:5px;" >
					</a>
				</td>
				<td align="center">
					<a href="../mobile_Post/m_upload_start.html">
						<img src="../image/upload_icon.png" width="25px" height="25px" style="padding:5px;">
					</a>
				</td>
				<td align="center">
					<a href="../mobile_Mypage/mypage.html" rel="external">
						<img src="../image/mypage_icon.png" width="25px" height="25px" style="padding:5px;">
					</a>
				</td>
			</tr>
		</table>
</div>
		
</body>
</html>