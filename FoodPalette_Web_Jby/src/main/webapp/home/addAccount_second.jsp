<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="jsp_header.jsp" %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>ȸ������ �ι�° ������</title>
<link type="text/css" rel="stylesheet" href="../design/design.css"/>
<script src="../jsfile/facebook.login.js"></script>
</head>
<body>

<div align="center">
<table border="1" width="40%" style="margin-top:120px;">
<tr align="center">
<td>
	<table class="loginwindow">
	<tr align="center">
		<td>
		<img src="../image/title.png"><br/>
		<font color="gray">�� ������ �پ��� �����Ǹ� �����Ϸ��� �����ϼ���.</font><br/>
		<input id="fb_login" type="button" value="Facebook���� �α���" onClick="javascript:loginFB()"/><br/>
		<img src="../image/dd.png">
		</td>
	</tr>
	<form:form modelAttribute="userInfo" action="../account/input_second.html" method="post">
	<input type="hidden" name="user_email" value="${userInfo.user_email}">
	<input type="hidden" name="user_name" value="${userInfo.user_name}">
	<input type="hidden" name="user_nick" value="${userInfo.user_nick}">
	<input type="hidden" name="user_password" value="${userInfo.user_password}">
	<tr align="center">
		<td>
		<form:input path="user_question" placeholder="��й�ȣ ã�� �� ����� ������ �Է����ּ���."/>
		</td>
	</tr>
	<tr align="center">
		<td>
		<form:input path="user_answer" placeholder="������ ���� �Է����ּ���."/>
		</td>
	</tr>
	<tr align="center">
		<td>
    	<input type="submit" value="�Ϸ�">
		</td>
	</tr>
	<tr align="center">
		<td>
		
		<spring:hasBindErrors name="userInfo">
		<font color="red">
		<c:forEach var="error" items="${errors.globalErrors}">
		<spring:message code="${error.code}"/>
		</c:forEach>
		</font>
		</spring:hasBindErrors>
		
		<font color="red"><br/>
		<form:errors path="user_question"/><!-- ������ ������ ���۵Ǵ� �±� -->
		</font>
		<font color="red"><br/>
		<form:errors path="user_answer"/><!-- ������ ������ ���۵Ǵ� �±� -->
		</font>
		
    	<h5><font color="gray">�����ϸ� FOOD PALETTE�� ��� �� ��������ó����ħ�� �����ϰ� �˴ϴ�.</font>
		</h5>
		</td>
	</tr>
	</form:form>
	</table>
</td>
</tr>
</table>

<!-- facebook login�� from -->
	<form:form id="fb_form" action="../login/fb_login.html" method="post" modelAtrribute="UserInfo">
		<input type="hidden" id="fb_name" name="user_name"/>
		<input type="hidden" id="fb_email" name="user_email"/>
	</form:form>

<br/>
<table border="1" width="40%">
	<tr>
		<td align="center" >
		������ �����Ű���? <a href="../login/login.html">�α���</a>
		</td>
	</tr>
</table>
</div>

</body>
</html>