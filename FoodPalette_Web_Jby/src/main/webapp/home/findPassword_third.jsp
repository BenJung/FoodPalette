<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="jsp_header.jsp" %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>��й�ȣã�� ������-��й�ȣ ����</title>
<link type="text/css" rel="stylesheet" href="../design/design.css"/>
</head>
<body>

<div align="center">
<form:form modelAttribute="changePwd" action="../account/findPassword_third.html" method="post">
<input type="hidden" name="user_email" value="${changePwd.user_email}">


<table border="1" width="40%" style="margin-top:120px;">
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
		<font color="gray">${changePwd.user_email}���� ���Ե�</font><br/>
		<font color="gray">������ ��й�ȣ�� ���� �Է����ּ���.</font><br/>
		</td>
	</tr>
	<tr align="center">
		<td>
		<form:password path="user_password" placeholder="���ο� ��й�ȣ"/>
		</td>
	</tr>
	<tr align="center">
		<td>
		<form:password path="user_password_check" placeholder="��й�ȣ Ȯ��"/>
		</td>
	</tr>
	<tr align="center">
		<td>
    	<input type="submit" value="Ȯ��">
		</td>
	</tr>
	<tr align="center">
		<td>
    	
    	<spring:hasBindErrors name="changePwd">
		<font color="red">
		<c:forEach var="error" items="${errors.globalErrors}">
		<spring:message code="${error.code}"/>
		</c:forEach>
		</font>
		</spring:hasBindErrors>
    	
    	<font color="red"><br/>
		<form:errors path="user_password"/><!-- ������ ������ ���۵Ǵ� �±� -->
		</font>
		
		<font color="red"><br/>
		<form:errors path="user_password_check"/><!-- ������ ������ ���۵Ǵ� �±� -->
		</font>
		
		</td>
	</tr>
	</table>
</td>
</tr>
</table>

</form:form>

<br/>
<table border="1" width="40%">
	<tr>
		<td align="center" >
		������ ��ﳪ�̳���? <a href="../login/login.html">�α���</a>
		</td>
	</tr>
</table>
</div>
</body>
</html>