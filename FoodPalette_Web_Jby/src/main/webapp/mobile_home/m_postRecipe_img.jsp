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
		<form:form action="../mobile_Post/m_upload_img.html" modelAttribute="RecipeInfo"  method="post"  enctype="multipart/form-data" data-ajax="false">
			<div id="upload_heaer" align="center">	
				<!-- Input button -->
				<input type="submit" value="다음단계로"/>
				<br/>
				<!-- Validate  -->
				<spring:hasBindErrors name="recipeInfo">
					<font color="red">
						<c:forEach var="error" items="${errors.allErrors}">
							<spring:message code="${error.code}"/>
						</c:forEach>
					</font>
				</spring:hasBindErrors>		
			</div>
			<div id="upload_content" align="center">
					<div style="margin-top:15px; margin-bottom:15px;">
						<font color="gray" style="font-size:12px;">레시피에 사용할 사진을 올려주세요. <br/> (장당 5MB이내, 최대 10장 업로드 가능)</font>
				    </div>
				    <table>
				        <tr>
				            <td><input class="upload_img" name="img_food" type="file" multiple="multiple"/></td>
				        </tr>        
				    </table>
			    <br/>
			</div>
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