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
    <title>Ȩȭ��</title>
    <!-- <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.1.js"></script> --> 
	
   <style type="text/css">
	.profile {
	    object-fit: cover;
	    object-position: bottom;
	    border-radius: 50%;
	    border : 1px solid lightgray;
	}
	.ui-input-search.ui-custom { border: none; box-shadow: none; }
	</style>

</head>
<body>
		<div data-role="page" id="page1" style="background-color:MintCream;">
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
				<input name="search" id="search" value="" placeholder="�˻�" type="search" data-theme="b" style="font-size:11px;"/>
			</div>
		</div>
		
		<div data-role="content" style="margin:0; padding:0;">		
			<script>
			var flag = 0;
			var delete_check = 0;
			$(document).ready(function(){
				// 5.9 jung
				setInterval(function(){			
					if(flag==1){
						$('#clip_popup')[0].click();
						flag=0;
						console.log("�˾�Ŭ��");
					}else if(flag==2){
						$('#unclip_popup')[0].click();
						flag=0;
						console.log("�˾�Ŭ��");
					}else if(delete_check==1){
						//alert("delete_check : "+delete_check);
						$('#delete_popup')[0].click();
						delete_check=0;
						console.log("�˾�Ŭ��");
					}
				},100);
				
			
			});
						
			//5.9
			//jung			
			function deleteCheck(recipe_id){
				$('.btn_cancel')[0].click();
				$('#delete_yes').attr('href','../mobile_Post/m_delete_recipe.html?recipe_id='+recipe_id);
			
				//var temp = $('#delete_yes').attr('href');
				//alert(temp);
				setTimeout(function(){
					delete_check = 1;
				},300);				
			}
			
			function clipRecipe(recipe_id, seleted_recipe){
				//alert("������ ��ũ�� �޼��� : "+recipe_id+"/"+seleted_recipe);
				var sr = $('#'+seleted_recipe).html();
				
				//���÷��� ���� �ٽ� �����Ǻ��� ������ ���
				if(sr == '�����ǺϿ��� �����ϱ�'){
					deleteCilpedRecipe(recipe_id, seleted_recipe);
					return;
				}
				
				//��ũ���� �� ���
				$.ajax({
					url:"http://localhost:8080/FoodPalette_Web/mobile_Recipebook/m_clip_recipe.html?recipe_id="+recipe_id,
					type:"get",
					//dataType:"text",
					success:function(data){
						//alert("�����ǺϿ� ��ũ�� �Ǿ����ϴ�.");
						$('#'+seleted_recipe).html("�����ǺϿ��� �����ϱ�");
						$('.btn_cancel')[0].click();
						setTimeout(function(){
							flag=1;
							},300);
						
					
					},
					error:function(request,status,error){
						alert("error\request : " + request + "\n\n" + "status : " + request.status + "\n\n" + "error : " + request.error);
					}
				});
			}

			function deleteCilpedRecipe(recipe_id, seleted_recipe){
				//alert("�����ǽ�ũ�� ���� �޼��� : "+recipe_id+"/"+seleted_recipe);
				var sr = $('#'+seleted_recipe).html();
				
				//���÷��� ���� �ٽ� ��ũ���� �� ���
				if(sr == '�����ǺϿ� ��ũ���ϱ�'){
					clipRecipe(recipe_id, seleted_recipe);
					return;
				}
				
				//��ũ���� ������ ���
				$.ajax({
					url:"http://localhost:8080/FoodPalette_Web/mobile_Recipebook/m_delete_clip_recipe.html?recipe_id="+recipe_id,
					type:"get",
					//dataType:"text",
					success:function(data){
						//alert("�����ǺϿ��� ���� �Ǿ����ϴ�.");
						$('#'+seleted_recipe).html('�����ǺϿ� ��ũ���ϱ�');
						$('.btn_cancel')[0].click();
						setTimeout(function(){
							flag = 2;
						},300);
						
					
					},
					error:function(request,status,error){
						alert("error\request : " + request + "\n\n" + "status : " + request.status + "\n\n" + "error : " + request.error);
					}
				});	
			}
			
			
			/*5.1 jung */

			</script>
			
			<!-- �����Ǻ� ��ũ���� �˾� -->
		  <a class="ui-btn ui-corner-all ui-shadow ui-btn-inline" id="clip_popup" href="#clip_overlay" data-rel="popup" data-position-to="window" style="display : none;">popup</a> 
	      <div class="result_popup" id="clip_overlay" data-role="popup" data-overlay-theme="b" data-transition="turn">
	         <p>�� ��ũ���Ͽ� �����ǰ� ����Ǿ����ϴ�.</p>
	      </div>   
	      <a class="ui-btn ui-corner-all ui-shadow ui-btn-inline" id="unclip_popup" href="#unclip_overlay" data-rel="popup" data-position-to="window" style="display : none;">popup</a> 
	      <div class="result_popup" id="unclip_overlay" data-role="popup" data-overlay-theme="b" data-transition="turn">
	         <p>�� ��ũ���Ͽ��� �����ǰ� �����Ǿ����ϴ�.</p>
	      </div>  
		
		<!-- ������ ������ Ȯ�� �˾�  -->
		<a href="#delete_request" id="delete_popup" data-rel="popup" data-position-to="window" data-transition="pop" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-icon-delete" style="display : none;"></a>	
		<div data-role="popup" id="delete_request" data-overlay-theme="b" data-dismissible="false">
			<div data-role="header">
			<h1>����Ȯ��</h1>
			</div>
			<div data-role="main" class="ui-content">
				<h3 class="ui-title">������ �����Ͻðڽ��ϱ�?</h3>
				<a id="delete_yes" class="ui-btn ui-corner-all ui-shadow ui-btn-a" rel="external">��</a>
				<a href="#" class="ui-btn ui-corner-all ui-shadow ui-btn-a" data-rel="back">�ƴϿ�</a>
			</div>		
		</div>		      
						
			<c:set var="num" value="0"/>
			
			<c:if test="${empty LIST}">
				<table width="100%" style="border:1px solid lightgray;">
				<tr>
					<td align="center" style="padding-top:5px; padding-bottom:5px;">
					<font color="gray" style="font-size:10px;">
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
			
				<table id="recipe_container${num}" align="center" style="background-color:white; border:1px solid lightgray; margin-top:50px;" class="ui-corner-all">
					<tr>
						<td width="35px" style="padding:5px; border-right:0px solid white;">
							<img src="${pageContext.request.contextPath}/upload/${recipe.user_profile_img}" width="35px" height="35px" class="profile"
							style="object-fit: cover; object-position: bottom; border-radius: 50%; border : 1px solid lightgray;"/>
						</td>
						<td width="60px" align="left" style=" margin:0;">
							<font style="font-weight:bold; font-size:11px;">${recipe.user_nick}</font>
						</td>		
						<!-- �޴�������(�Ʒ�) -->
						<td align="right" style="padding-left:40px; margin:0;">
							<a class="ui-corner-all ui-shadow" href="#positionWindow${num}" data-rel="popup" data-position-to="window">
								<img src="../image/more.png" width="25px" height="25px"/>
							</a>
					
							<!-- 5.8 jung -->		
							<c:choose>
								<c:when test="${sessionScope.user_nick == recipe.user_nick}">
									<div align="center" class="ui-content" id="positionWindow${num}" data-role="popup" data-theme="a" data-overlay-theme="b" data-transition="fade" style="padding:10px;">
										<a style="border-bottom:1px solid lightgray;" href="../mobile_Post/m_modify_img.html?recipe_id=${recipe.recipe_id}&TOTAL=YES" rel="external">
										�� ������ �����ϱ�</a><br>
										<%-- <a style="border-bottom:1px solid lightgray;" href="../mobile_Post/m_delete_recipe.html?recipe_id=${recipe.recipe_id}"> --%>
										<a style="border-bottom:1px solid lightgray;" href="javascript:deleteCheck('${recipe.recipe_id}')" rel="external">
										�� ������ �����ϱ�</a><br>
										<a href="#" data-rel="back">���</a>
									</div>
								</c:when>
								
								<c:when test="${sessionScope.user_nick != recipe.user_nick}">
									<div align="center" class="ui-content" id="positionWindow${num}" data-role="popup" data-theme="a" data-overlay-theme="b" data-transition="fade" style="padding:10px;">
										<c:if test="${recipe.clip_flag == 'NO'}">
										<a style="border-bottom:1px solid lightgray;" href="javascript:clipRecipe('${recipe.recipe_id}','clip_recipe${num}')" id="clip_recipe${num}" rel="external">
										�����ǺϿ� ��ũ���ϱ�</a><br>
										</c:if>
										<c:if test="${recipe.clip_flag == 'YES'}">
										<a style="border-bottom:1px solid lightgray;" href="javascript:deleteCilpedRecipe('${recipe.recipe_id}','del_clip_recipe${num}')" id="del_clip_recipe${num}" rel="external">
										�����ǺϿ��� �����ϱ�</a><br>
										</c:if>
										<a href="#" data-rel="back" class="btn_cancel">���</a>
									</div>
								</c:when>
									
							</c:choose>
							
						</td>
						<td align="right" style="padding-right:15px; border-left:0px solid white;">
							<font color="gray" style="font-size:11px;">${recipe.recipe_posttime_cal}</font>
						</td>
					</tr>
					<tr>
						<td colspan="4">
							<a href="../mobile_List/recipe_selected.html?id=${recipe.recipe_id}" rel="external"><!-- �ܺ��������� �ҷ��ٶ� rel="external"��� -->
								<img src="${pageContext.request.contextPath}/upload/${recipe.recipe_img1}" width="250px"/>
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
							<font style="font-size:12px;">${recipe.recipe_content}</font>
						</td>
					</tr>
					<tr>
						<td colspan="4" style="padding-top:5px; padding-bottom:10px; padding-left:15px;">
							<font color="gray" style="font-size:12px;">${recipe.recipe_hashtag}</font>
						</td>
					</tr>
				</table>
			
			<br/>
			</c:forEach>

		</div>
		
		<div data-role="footer" data-position="fixed" style="background-color:white;">
		<table width="100%" align="center" >
			<tr>
				<td align="center">
					<a href="../mobile_List/recipe_list.html" rel="external">
						<img src="../image/home_icon.png" width="25px" height="25px" style="padding:5px;">
					</a>
				</td>
				<td align="center">
					<a href="../mobile_Recipebook/m_my_clip_list.html" rel="external">
						<img src="../image/book_icon.png" width="25px" height="25px" style="padding:5px;" >
					</a>
				</td>
				<td align="center">
					<a href="../mobile_Post/m_upload_start.html" rel="external">
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