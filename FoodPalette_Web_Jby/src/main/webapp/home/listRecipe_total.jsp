<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="jsp_header.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<style type="text/css">
.profile {
    width: 50px; height: 50px;
    object-fit: cover;
    object-position: bottom;
    border-radius: 50%;
    border : 1px solid gray;
}
</style>
<title>Insert title here</title>
<script src="../jsfile/layerpopup_comment.js"></script>
<link type="text/css" rel="stylesheet" href="../design/layerpopup.css" /> 
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>
<script>
$(document).ready(function(){
	var seq = '<c:out value="${FOCUS}"/>';
	console.log("focus:"+seq);
	
	if(seq){
		fnMove(seq);
	}
	function fnMove(seq){
		var offset = $("#" + seq).offset();
        $('html, body').animate({scrollTop : offset.top}, 5);
    }

	$('.btn-example').click(function(){
		console.log("���̾��˾� Ŭ��");
		var $href = $(this).attr('href');
		var id = $(this).attr('id');
		layer_popup($href,id);
	});

	$('#recipe_del').click(function(){
		console.log("�������� ���� Ŭ��");
		deleteCheck();	 
	});
		
});

function deleteCheck(){ 
	if (confirm("������ ���� �Ͻðڽ��ϱ�?")){ 
		 console.log("������ ���� Ŭ��"); 
	}else{  
		 $('#recipe_del').attr('href',' ');
	}  
}
</script>
<c:set var="num" value="0"/>

<c:if test="${ empty LIST }">
	<table width="100%" style="border:1px solid lightgray;">
	<tr>
		<td align="center" style="padding-top:50px; padding-bottom:50px;">
		<font color="gray">
			�Խñ��� �����ϴ�.<br>
			${sessionScope.user_nick}���� �����Ǹ� �����غ�����!
		</font>
		</td>
	</tr>
	</table>
</c:if>

<c:if test="${SEARCH_CONTENT != null && !empty SEARCH_CONTENT}">
	<div align="center" style="margin-top:20px; margin-bottom:20px;">
		�˻���&nbsp; <font color="gray">${SEARCH_CONTENT}</font> &nbsp;�� �˻����
	</div>
</c:if>

<c:set var="num" value="0"/>
<c:forEach var="recipe" items="${LIST}">
<c:set var="num" value="${num+1}"/>

	<table id="recipe_container${num}" align="center" border="1" style="margin-top:50px;">
		<tr>
			<td width="60px" style="padding-top:5px; padding-left:15px; border-right:0px solid white;">
				<img src="${pageContext.request.contextPath}/upload/${recipe.user_profile_img}" class="profile"/>
			</td>
			<td align="left" style="border-left:0px solid white; border-right:0px solid white;">
				<font style="font-weight:bold;">${recipe.user_nick}</font>
			</td>		
			<!-- �޴�������(�Ʒ�) -->
			<td align="right" style="border-left:0px solid white; border-right:0px solid white;">
	
   			<a href="#layer${num}" class="btn-example" id="#dimId${num}">
				<input type="image" name="more" src="../image/more.png" value="button" width="30px" height="30px">
			</a>
					
			<div class="dim-layer" id="dimId${num}">
    			<div class="dimBg"></div>
		    	<div id="layer${num}" class="pop-layer">
			     	<div class="pop-container">
			           	<div class="pop-conts">
			           		<c:choose>
			           		<c:when test="${sessionScope.user_nick == recipe.user_nick}">
					            <div align="center" >
			  		         		<a href="../post/modify_cotent.html?recipe_id=${recipe.recipe_id}&TOTAL=YES&FOCUS=recipe_container${num}" class="btn-layerbtn" id="modi">�� ������ �����ϱ�</a>
			  		         		<%-- ../post/modify_cotent.html?recipe_id=${recipe.recipe_id}&TOTAL=YES --%>
					            </div>
					            <div align="center">
					                <a href="../post/delete_recipe.html?recipe_id=${recipe.recipe_id}&TOTAL=YES" class="btn-layerbtn" id="recipe_del">�� ������ �����ϱ�</a>
					                <%-- ../post/delete_recipe.html?recipe_id=${recipe.recipe_id} --%>
					            </div>
				            </c:when>
				           	<c:when test="${sessionScope.user_nick != recipe.user_nick && recipe.clip_flag == 'NO'}">
					           	<div align="center" >
			  		                <a href="../recipebook/clip_recipe.html?recipe_id=${recipe.recipe_id}&TOTAL=YES&FOCUS=recipe_container${num}" class="btn-layerbtn">�����ǺϿ� ��ũ���ϱ�</a>
					            </div>
					        </c:when>
				           	<c:otherwise>
					           	<div align="center" >
					           		<a href="../recipebook/delete_clip_recipe.html?recipe_id=${recipe.recipe_id}&TOTAL=YES" class="btn-layerbtn" >�����ǺϿ��� �����ϱ�</a>
					           	</div>
				           	</c:otherwise>
				            </c:choose>
				            <div align="center">
				            	<a href="#" class="btn-layerClose">���</a>
	                		</div>     
            			</div>
        			</div>
    			</div>
			</div>			
			</td>
			<td width="100px" align="right" style="padding-right:15px; border-left:0px solid white;">
				${recipe.recipe_posttime_cal}
			</td>
		</tr>
		<tr>
			<td colspan="4">
				<a href="../list/recipe_selected.html?id=${recipe.recipe_id}">
					<img src="${pageContext.request.contextPath}/upload/${recipe.recipe_img1}" width="550px"/>
				</a>
			</td>
		</tr>
		<tr style="border-bottom:0px solid white;">
			<td colspan="4" style="padding-top:5px; padding-left:12px;">
				<jsp:include page="../heart/go_heart.html">
					<jsp:param value="${recipe.recipe_id}" name="recipe_id"/>
					<jsp:param value="${PAGE}" name="page"/>
					<jsp:param value="recipe_container${num}" name="focus"/>
					<jsp:param value="${SEARCH_CONTENT}" name="search_content"/>
				</jsp:include>
			</td>
		</tr>
		<tr style="border-bottom:0px solid white;">
			<td colspan="4" style="padding-top:5px; padding-bottom:15px; padding-left:15px;">
				${recipe.recipe_content}
			</td>
		</tr>
		<tr>
			<td colspan="4" style="padding-top:5px; padding-bottom:10px; padding-left:15px;">
				<font color="gray">${recipe.recipe_hashtag}</font>
			</td>
		</tr>
	</table>

<br/>
</c:forEach>


</body>
</html>