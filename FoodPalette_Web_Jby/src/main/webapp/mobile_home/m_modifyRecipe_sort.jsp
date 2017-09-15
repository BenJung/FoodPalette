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

<!-- <link type="text/css" rel="stylesheet" href="../design/m_design.css"/>
 -->
 <title>Insert title here</title>
 <style type="text/css">
.body{
	max-width : 100%;
}
.container{
	max-width : 100%;
	
} 
.tile__list{
	
}
.tile__list img {
	cursor: move;
	margin: 0px;
	border-radius: 30%;
	display: block;
	
}

.img_contain {
  position: relative;
  vertical-align : middle;
  width : 250px;
  height : 250px;
}
.overlay {
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  height: 85%;
  width: 120%;
  border-radius: 30%;
  opacity: 0;
  transition: .5s ease;
  background-color: #008CBA;
  vertical-align : middle;
}
.img_contain:hover .overlay {
  opacity: 0.5;
}
.text {
  color: white;
  font-size: 40px;
  font-weight : bold;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  -ms-transform: translate(-50%, -50%);
}
</style>
</head>
<body>


<div data-role="page" id="upload_img">
<script src="../jsfile/Sortable.js"></script>
<script>
var originTitle = [];
var saveTitle = [];
var result = "";
var originResult ="";
//5.2 jung
var sorted_hover = [];

//5.2 jung
$('document').ready(function(){
	saveOriginTitle();      
	 [].forEach.call(document.getElementById('multi').getElementsByClassName('tile__list'), function (el){
	      Sortable.create(el, {
	          group: 'blocks',
	          animation: 150,
	          onUpdate: function (/**Event*/evt) {//이벤트 발생시
	        	//정렬된 순서 앨리먼트 로드
	    		var hover = document.getElementsByName("hover");
	    		
	    		//정렬된 순서대로 id값 저장 및 내용 변경
	    		for(var i=0;i<hover.length;i++){
	    			sorted_hover[i] = hover[i].getAttribute("id");
	    			document.getElementById(sorted_hover[i]).textContent = i+1;
	    		}
	      	}
	      });
	  });
	
});

//처음값저장
function saveOriginTitle(){
	var imgs = document.getElementsByName("load_img");
	for(var i=0; i<imgs.length; i++){
		originTitle[i] = imgs[i].getAttribute("src");
		console.log("오리지널 순서: "+originTitle[i]);
	}	
}

//정렬된 값 저장
function saveNewOrderOfImgFileName(){
	var imgs = document.getElementsByName("load_img");
	for(var i=0; i<imgs.length; i++){
		saveTitle[i] = imgs[i].getAttribute("src");
		console.log("정렬 순서: "+saveTitle[i]);
	}	
}


//정렬한 이미지 이름 파라미터 처리
function saveNewOrderImgInPara(){
	//정렬한 파일 이름 저장
	saveNewOrderOfImgFileName();
	
	//정렬한 파일이름 파라미터 저장
	var str = "";
	for(var i=0; i<saveTitle.length; i++){
		str += '<input type="hidden" id="img_sort_result" name="recipe_img'+(i+1)+'" value="'+saveTitle[i]+'"/>';
	}
	str +='<input type="hidden" name="recipe_img_order" value="'+saveTitle.length+'"/>';
	$(str).appendTo($('#upload_form'));
}
</script>

	<div data-role="header"></div>
	<div data-role="content">	
		<form:form action="../mobile_Post/m_modify_content.html" method="post" modelAttribute="RecipeInfo" id="upload_form" data-ajax="false">
			<input type="submit" value="다음단계로" onClick="javascript:saveNewOrderImgInPara()"/>
			<!-- 기존 내용, 해쉬태그 저장  -->
			<!-- 5.8 jung -->
			<input type="hidden" name="TOTAL" value="${TOTAL}">
			<input type="hidden" name="recipe_img_order" value="${recipeInfo.recipe_img_order}"/>
			<input type="hidden" name="recipe_id" value="${recipeInfo.recipe_id}"/>
			<input type="hidden" name="recipe_content" value="${recipeInfo.recipe_content}"/>
			<input type="hidden" name="recipe_hashtag" value="${recipeInfo.recipe_hashtag}"/>
			
			<div align="center" style="margin-top:15px; margin-bottom:15px;">
				<font color="gray" style="font-size:12px;">사진를 마우스로 드래그해서 사진의 순서를 정해주세요.<br/>(맨 위쪽부터 첫번째)</font><br/>
			</div>
			<!-- 4.27 jung -->
			<div class="container" style="padding-right : 10%;" align="center">
				<div id="multi">
					<div class="layer tile" >
						<div class="tile__list">
							<c:forEach var="imgName" items="${IMG_NAME}" varStatus="status">
								<div class="img_contain">
									<img name="load_img" src="${pageContext.request.contextPath}/upload/${imgName}" width="120%" height="85%"/>
									<div class="overlay">
										<div class="text" id="txt${status.count}" name="hover">${status.count}</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>	
				</div>
			</div>
		</form:form>	
	</div>
	<div data-role="footer"></div>
</div>
</body>
</html>