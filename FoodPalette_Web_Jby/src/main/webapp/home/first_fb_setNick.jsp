<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="jsp_header.jsp" %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>ó�� �α����� ���̽��� ������ ������̸� ���ϴ� ������</title>
<link type="text/css" rel="stylesheet" href="../design/design.css"/>
</head>
<body>

<form:form modelAttribute="userInfo" action="../account/fb_nick.html" method="post">

<input type="hidden" name="user_email" value="${userInfo.user_email}">
<input type="hidden" name="user_name" value="${userInfo.user_name}">
<div align="center">
<table border="1" width="40%">
<tr align="center">
<td>
	<table class="loginwindow">
	<tr align="center">
		<td>
		<img src="../image/title.png"><br/>
		</td>
	</tr>
	<tr align="center">
		<td>
		<font color="gray">FOOD PALETTE���� ����� �г����� �Է����ּ���.</font><br/>
		</td>
	</tr>
	<tr align="center">
		<td>
		<form:input path="user_nick" placeholder="����� �̸�"/>
		</td>
	</tr>
	<tr align="center">
		<td>
    	<input type="submit" value="Ȯ��">
		</td>
	</tr>
	<tr align="center">
		<td>
    	
    	<spring:hasBindErrors name="user">
		<font color="red">
		<c:forEach var="error" items="${errors.globalErrors}">
		<spring:message code="${error.code}"/>
		</c:forEach>
		</font>
		</spring:hasBindErrors>
    	
    	<font color="red"><br/>
		<form:errors path="user_nick"/><!-- ������ ������ ���۵Ǵ� �±� -->
		</font>
		
		</td>
	</tr>
	</table>
</td>
</tr>
</table>
</div>
</form:form>

</body>
</html>