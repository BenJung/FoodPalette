<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="jsp_header.jsp" %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>����������-��й�ȣ ����</title>
<style type="text/css">
.profile {
    width: 100px; height: 100px;
    object-fit: cover;
    object-position: bottom;
    border-radius: 50%;
}
</style>
<link type="text/css" rel="stylesheet" href="../design/design.css"/>
</head>
<body>

<table width="100%" style="border-bottom : 1px solid gray; margin-top : 20px; margin-bottom : 20px;">
<tr>
	<td align="center">
	<img src="${pageContext.request.contextPath}/upload/${sessionScope.profile}" class="profile">
	</td>
</tr>
<tr>
	<td align="center" style="padding-bottom : 15px; font-weight:bold;">
	${sessionScope.user_nick}
	</td>
</tr>
</table>

<form:form modelAttribute="changePwd_Mypage" action="../mypage/changePwd.html" method="post">
<table width="30%" align="center">
<tr>
	<td>
	<form:password path="current_password" placeholder="���� ��й�ȣ"/>
	</td>
</tr>
<tr>
	<td>
	<form:password path="change_password" placeholder="������ ��й�ȣ"/>
	</td>
</tr>
<tr>
	<td>
	<form:password path="change_password_check" placeholder="��й�ȣ Ȯ��"/>
	</td>
</tr>

<tr>
	<td align="center">
	<spring:hasBindErrors name="changePwd_Mypage">
		<font color="red">
		<c:forEach var="error" items="${errors.globalErrors}">
		<spring:message code="${error.code}"/>
		</c:forEach>
		</font>
	</spring:hasBindErrors>
	<br/>
	<font color="red"><br/>
		<form:errors path="current_password"/><!-- ������ ������ ���۵Ǵ� �±� -->
	</font>
	<font color="red"><br/>
		<form:errors path="change_password"/><!-- ������ ������ ���۵Ǵ� �±� -->
	</font>
	<font color="red"><br/>
		<form:errors path="change_password_check"/><!-- ������ ������ ���۵Ǵ� �±� -->
	</font>
	</td>
</tr>

<tr>
	<td>
	<input type="submit" value="����"/>
	</td>
</tr>
</table>
</form:form>

</body>
</html>