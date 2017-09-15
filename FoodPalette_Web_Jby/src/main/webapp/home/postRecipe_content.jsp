<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="jsp_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script src="http://code.jquery.com/jquery-1.11.3.min.js" ></script>
<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link type="text/css" rel="stylesheet" href="../design/design.css"/>
<script src="../jsfile/Sortable.js"></script>
<style type="text/css">
.body{
	max-width : 100%;
}
.container{
	max-width : 100%;
}

.tile__list img {
	cursor: move;
	margin: 10px;
	border-radius: 30%;
}
</style>
<title>Insert title here</title>
</head>
<body>

<script>
var originTitle = [];
var saveTitle = [];
var result = "";
var originResult ="";

//4.27 jung
$('document').ready(function(){
	saveOriginTitle();      
	 [].forEach.call(document.getElementById('multi').getElementsByClassName('tile__list'), function (el){
	      Sortable.create(el, {
	          group: 'blocks',
	          animation: 150, 
	      });
	  });
	
});

//ó��������
function saveOriginTitle(){
	var imgs = document.getElementsByName("load_img");
	for(var i=0; i<imgs.length; i++){
		originTitle[i] = imgs[i].getAttribute("src");
		console.log("�������� ����: "+originTitle[i]);
	}	
}

//���ĵ� �� ����
function saveNewOrderOfImgFileName(){
	var imgs = document.getElementsByName("load_img");
	for(var i=0; i<imgs.length; i++){
		saveTitle[i] = imgs[i].getAttribute("src");
		console.log("���� ����: "+saveTitle[i]);
	}	
}


//������ �̹��� �̸� �Ķ���� ó��
function saveNewOrderImgInPara(){
	//������ ���� �̸� ����
	saveNewOrderOfImgFileName();
	
	//������ �����̸� �Ķ���� ����
	var str = "";
	for(var i=0; i<saveTitle.length; i++){
		str += '<input type="hidden" id="img_sort_result" name="recipe_img'+(i+1)+'" value="'+saveTitle[i]+'"/>';
	}
	str +='<input type="hidden" name="recipe_img_order" value="'+saveTitle.length+'"/>';
	$(str).appendTo($('#upload_form'));
}

</script>

<form:form action="../post/upload_content.html" method="post" modelAttribute="RecipeInfo" id="upload_form">
<input type="submit" value="���ε�" onClick="javascript:saveNewOrderImgInPara()"/>
	<div align="center" style="margin-top:15px; margin-bottom:15px;">
		<font color="gray" style="font-size:12px;">������ ���콺�� �巡���ؼ� ������ ������ �����ּ���.(�� ���ʺ��� ù��°)</font><br/>
	</div>
	<!-- 4.27 jung -->
	<div class="container" align="center">
		<div id="multi" style="margin-left: 0px">
			<div class="layer tile" >
				<div class="tile__list">
					<c:forEach var="imgName" items="${IMG_NAME}" varStatus="status">
						<img name="load_img" alt="${status.count+1}" src="${pageContext.request.contextPath}/upload/${imgName}" width="100px" height="100px"/>
					</c:forEach>
				</div>
			</div>	
		</div>
	</div>
<br/>
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
				<textarea name="recipe_content" rows="30" cols="100" placeholder="�����Ǹ� �Է����ּ���."></textarea>
			</c:if>
			<c:if test="${!empty recipeInfo.recipe_content}">
				<textarea name="recipe_content" rows="30" cols="100" placeholder="�����Ǹ� �Է����ּ���.">${recipeInfo.recipe_content}</textarea>
			</c:if>
			
		</td>
	</tr>
	<tr>
		<td>
			<c:if test="${empty recipeInfo.recipe_hashtag}">
				<input type="text" name="recipe_hashtag" placeholder="�� ��Ḧ �ؽ��±׷� �Է����ּ���"/>
			</c:if>
			<c:if test="${!empty recipeInfo.recipe_hashtag}">
				<input type="text" name="recipe_hashtag" placeholder="�� ��Ḧ �ؽ��±׷� �Է����ּ���" value="${recipeInfo.recipe_hashtag}"/>
			</c:if>
		</td>
	</tr>
</table>
</form:form>
<!-- �ڷΰ��� �κ� -->
<!-- <form action="../image/back_page.html" method="get">	
	<input type="submit" value="�ڷΰ���">
</form> -->
<br/>

</body>
</html>