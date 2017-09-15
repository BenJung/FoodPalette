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

<!-- <link type="text/css" rel="stylesheet" href="../design/m_design.css"/> -->

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
				<img align="right" src="../image/search_icon.png" class="opensearch" width="15px" height="15px" style="padding:5px; padding-right:10px; "/>	
			</td>
		</tr>
		</table>
		<div class="search_field" style="display:none; background-color:white;">
			<input name="search" id="search" value="" placeholder="검색" type="search" data-theme="b" style="font-size:11px;"/>
		</div>
	</div>
	 
	<div data-role="content">
	<form:form action="../mobile_Post/m_upload_all.html" id="upload_form" modelAttribute="RecipeInfo"  method="post" data-ajax="false">
		<input type="submit" value="업로드"/>
	
		<!-- 기존 객체값 저장 -->
		<input type="hidden" name="TOTALS" value="${TOTAL}"/>
		<input type="hidden" name="recipe_id" value="${recipeInfo.recipe_id}"/>
		<input type="hidden" name="recipe_img_order" value="${recipeInfo.recipe_img_order}"/>
		<c:forEach var="img" items="${IMGS}" varStatus="status">
			<input type="hidden" name="recipe_img${status.count}" value="${img}"/>
		</c:forEach>
	
		<table align="center">
			<tr align="center">
				<td>
				<!-- Validate  -->
				<spring:hasBindErrors name="recipeInfo">
					<font color="red">
					<c:forEach var="error" items="${errors.allErrors}">
					<spring:message code="${error.code}"/>
					</c:forEach>
					</font>
				</spring:hasBindErrors>	
				</td>
			</tr>
			<tr>
				<td>
					<c:if test="${empty recipeInfo.recipe_content}">
						<textarea name="recipe_content" rows="9" cols="60" placeholder="레시피를 입력해주세요." data-autogrow="false"></textarea>
					</c:if>
					<c:if test="${!empty recipeInfo.recipe_content}">
						<textarea name="recipe_content" rows="9" cols="60" placeholder="레시피를 입력해주세요." data-autogrow="false">${recipeInfo.recipe_content}</textarea>
					</c:if>
					
				</td>
			</tr>
			<tr>
				<td>
					<c:if test="${empty recipeInfo.recipe_hashtag}">
						<input type="text" name="recipe_hashtag" placeholder="주 재료를 해쉬태그로 입력해주세요"/>
					</c:if>
					<c:if test="${!empty recipeInfo.recipe_hashtag}">
						<input type="text" name="recipe_hashtag" placeholder="주 재료를 해쉬태그로 입력해주세요" value="${recipeInfo.recipe_hashtag}"/>
					</c:if>
				</td>
			</tr>
		</table>
	</form:form>	
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
				<a href="../recipebook/my_clip_list.html">
					<img src="../image/book_icon.png" width="25px" height="25px" style="padding:5px;">
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
</div>
</body>
</html>