<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="jsp_header.jsp" %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�α���</title>
<link type="text/css" rel="stylesheet" href="../design/design.css"/>
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<link href="http://cdnjs.cloudflare.com/ajax/libs/fotorama/4.6.4/fotorama.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/fotorama/4.6.4/fotorama.js"></script>
<script src="/jsfile/jquery.placeholder.min.js"></script>
<script src="/jsfile/jquery.placeholderjs"></script>
<script src="../jsfile/facebook.login.js"></script>
</head>

<body>
<table align="center" width="100%" style="margin-top:120px;">
<tr>
<td width="550px" style="padding:0px; margin:0px;">
	<div class="fotorama" align="center" 
	style="width:500px; height:450px; margin-left:150px; " 
	data-autoplay="3000">
		<img src="../image/food1.jpg">
		<img src="../image/food2.jpg">
		<img src="../image/food3.jpg">
		<img src="../image/food4.jpg">
		<img src="../image/food5.png">
		<img src="../image/food6.png">
		<img src="../image/food7.png">
		<img src="../image/food8.png">
		<img src="../image/food9.png">
		<img src="../image/food10.png">
	</div>
</td>

<td width="100%" style="padding:0px; margin:0px;" >
	<div width="100%" align="center" style="padding:0px 0px; margin-right:150px;" >
	<!-- modelAttribute : �����Ͱ� �� class�� �־���. 
	ex)
	product�� ���� Product����̸��� Ŭ������ ã�� �ű⿡ �����͸� �ִ´�. -->
	
	<form:form modelAttribute="userInfo" action="../login/do_login.html" method="post">
	<table border="1" width="80%">
	<tr align="center"><td>
		<table class="loginwindow">
		<tr align="center">
			<td>
			<img src="../image/title.png">
			</td>
		</tr>
		<tr align="center">
			<td>
			<form:input path="user_email" placeholder="�̸��� �ּ�"/>
			</td>
		</tr>
		<tr align="center">
			<td>
			<form:password path="user_password" placeholder="��й�ȣ"/><br/>
			<a href="../account/findPassword.html">��й�ȣ�� �����̳���?</a>	
			</td>
		</tr>
		<tr align="center">
			<td>
			<input type="submit" value="�α���"/><br/>
			</td>
		</tr>
		<tr align="center">
			<td>
			<img src="../image/dd.png">
			</td>
		</tr>
		<tr align="center">
			<td>
			<input id="fb_login" type="button" value="Facebook���� �α���" onClick="javascript:loginFB()"/><br/>
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
			<form:errors path="user_email"/><!-- ������ ������ ���۵Ǵ� �±� -->
			</font>
			<font color="red"><br/>
			<form:errors path="user_password"/><!-- ������ ������ ���۵Ǵ� �±� -->
			</font>
			
			</td>
		</tr>
	</table>
	</td></tr>
	</table>
	</form:form>
	
	<!-- facebook login�� from -->
	<form:form id="fb_form" action="../login/fb_login.html" method="post" modelAtrribute="UserInfo">
		<input type="hidden" id="fb_name" name="user_name"/>
		<input type="hidden" id="fb_email" name="user_email"/>
	</form:form>
	
	<br/>
	<table border="1" width="80%">
		<tr>
			<td align="center" >
			������ �����Ű���? <a href="../account/input.html">�����ϱ�</a>
			</td>
		</tr>
	</table>
	</div>
</td>
</tr>
</table>



</body>
</html>