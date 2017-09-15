<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="jsp_header.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
<link type="text/css" rel="stylesheet" href="../design/design.css"/>
</head>
<body>
<script>
$(document).ready(function() {
    //add more file components if Add is clicked
    $('#addFile').click(function() {
    	console.log("���Ͼ��ε� �߰�");
        var fileIndex = $('#fileview tr').length;
        if(fileIndex<=9){
	        $('#fileview').append(
	                '<tr>'+
	                '   <td></td>'+
	                '   <td><input class="upload_img" name="img_food['+ fileIndex +']" type="file"/></td>'+
	                '</tr>'
			);
        }else{
        	alert("������ 10�� �̻� ���ε��� �� �����ϴ�.");
        }
    });       
   
});
</script>
<form:form action="../post/upload_img.html" method="post" modelAttribute="RecipeInfo" enctype="multipart/form-data">
<div id="upload_heaer" align="center">
	<input type="submit" value="����"/>
	<!-- <input type="submit" value="����" onClick="javascript:getTag()"/> -->
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
			<font color="gray" style="font-size:12px;">�����ǿ� ����� ������ �÷��ּ���. (��� 5MB�̳�, �ִ� 10�� ���ε� ����)</font>
	    </div>
	    <table id="fileview">
	        <tr>
	        	<td><input id="addFile" type="button" value="+"/></td>
	            <td><input class="upload_img" name="img_food" type="file" multiple="multiple"/></td>
	        </tr>        
	    </table>
    <br/>
</div>
</form:form>
</body>
</html>