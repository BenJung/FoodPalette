<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="jsp_header.jsp" %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>����������</title>

<style type="text/css">
.profile {
    width: 100px; height: 100px;
    object-fit: cover;
    object-position: bottom;
    border-radius: 50%;
    border : 1px solid gray;
}
</style>
</head>
<body>
<script type="text/javascript">

var file;

function checkProfile(){
	file = document.getElementById("profile_upload");
	console.log("file : "+file.value);
	
	if(file.value!=null){
		uploadProfile();	
	}
	
}
function uploadProfile(){
	console.log("���ε��� �������̹����� : "+file.value);
	var profile_form = document.getElementById("profile_form");
	profile_form.submit();
}

</script>

<table width="50%" style="margin-top:20px; margin-bottom:20px;">
<tr>
	<td width="100px;" align="right"">
		<form:form id="profile_form" action="../mypage/update_profile.html" method="post" modelAtrribute="profileUtil"
		enctype="multipart/form-data">
			<input type="file" id="profile_upload" name="user_profile_img" style="display: none;" onChange="javascript:checkProfile()"> 
			<!-- �������̹����� Ŭ���ϸ� ���Ͼ��ε带 ���ؼ� �����ʻ������� �ϵ��� ���� -->
			<img src="${pageContext.request.contextPath}/upload/${sessionScope.profile}" class="profile"
			onClick="document.all.profile_upload.click();">	
		</form:form>
	</td>

	<td align="left" width="120px" valign="bottom" style="padding-left:10px; padding-bottom : 15px; font-weight:bold;">
		${sessionScope.user_nick}
	</td>
	<td width="50px" align="left" valign="bottom">
		<a href="../mypage/logout.html">
			<input type="button" value="�α׾ƿ�"/>
		</a>
	</td>
	<c:choose>
	<c:when test="${sessionScope.FB_CHECK == 'YES'}">
		<td width="120px""></td>
	</c:when>
	<c:otherwise>
		<td width="50px" align="left" valign="bottom">
			<a href="../mypage/go_changePwd.html">
				<input type="button" value="��й�ȣ ����"/>
			</a>
		</td>
	</c:otherwise>
	</c:choose>
		
</tr>

<tr align="center">
	<td colspan="4">
	<spring:hasBindErrors name="profileUtil">
		<font color="red">
		<c:forEach var="error" items="${errors.globalErrors}">
		<spring:message code="${error.code}"/>
		</c:forEach>
		</font>
	</spring:hasBindErrors>
	</td>
</tr>
</table>

<!-- ���ǰԽù� -->
<table align="center" width="100%">
<tr style="border-top:1px solid lightgray;">
	<td align="left" colspan="3" style="padding-left:40px; padding-top:20px; padding-bottom:40px;">
		<font color="gray" style="font-weight:bold;">
			���� �Խù� &nbsp;${MAXPID}��
		</font>
	</td>
</tr>

<c:choose>
<c:when test="${empty FIRST_IMGS[0]}">
<tr>
	<td align="center">
		<div style="margin-bottom:60px;">
			<font color="gray">���� �ø� �Խù��� �����ϴ�.</font>
		</div>
	</td>
</tr>
</c:when>
<c:otherwise>
<c:forEach var="i" begin="0" end="${MAX-1}"><!-- �� �Խù�����/3��ŭ �ݺ� -->
<tr border="0">
	<c:forEach var="num" begin="${TR_INDEX[i]*3-2}" end="${TR_INDEX[i]*3}"><!-- ù��°�Խù����� 3���� �ѷ���. 1��*1��°,1*2,1*3 / 4,5,6 / 7,8,9 -->
	<c:if test="${!empty FIRST_IMGS[num-1]}">
	<td align="center" border="0">
		<a href="../list/recipe_selected.html?id=${RECIPE_ID[num-1]}">
				<!-- �Խù��� ù��°�̹��� �ѷ���  -->
				<img src="${pageContext.request.contextPath}/upload/${FIRST_IMGS[num-1]}" width="400px" height="350px"/>
		</a>
	</td>
	</c:if>
	</c:forEach>
</tr>
</c:forEach>
</c:otherwise>
</c:choose>

</table>
</body>
</html>