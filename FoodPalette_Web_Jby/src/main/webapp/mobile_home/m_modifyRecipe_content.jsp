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
	<div data-role="header">
	</div>
	
	<div data-role="content">
	<form:form action="../mobile_Post/m_modify_upload.html" id="upload_form" modelAttribute="RecipeInfo"  method="post" data-ajax="false">
		<input type="submit" value="수정하기"/>
	
		<!-- 5.8 jung -->
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
	
	<div data-role="footer">
	</div>
</div>
</body>
</html>