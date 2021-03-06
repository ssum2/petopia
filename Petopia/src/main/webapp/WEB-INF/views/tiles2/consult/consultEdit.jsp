<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style type="text/css">
	
	.content {
	   padding-top: 15px;
	   padding-bottom: 15px;
	   background-color: #fffff;
	   /* background-color: rgba(86, 61, 124, .15); */
	   border: 0px solid #999;
	   /* border: 1px solid rgba(86, 61, 124, .2); */
	   margin: 0%;
	   padding: 0.5%;
	   text-align:left;
	}
	
</style>

<!-- include summernote css/js-->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>


<!-- include codemirror (codemirror.css, codemirror.js, xml.js, formatting.js) -->
<link rel="stylesheet" type="text/css" href="//cdnjs.cloudflare.com/ajax/libs/codemirror/3.20.0/codemirror.css">
<link rel="stylesheet" type="text/css" href="//cdnjs.cloudflare.com/ajax/libs/codemirror/3.20.0/theme/monokai.css">
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/codemirror/3.20.0/codemirror.js"></script>
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/codemirror/3.20.0/mode/xml/xml.js"></script>
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/codemirror/2.36.0/formatting.js"></script>


<script type="text/javascript">
	
	$(document).ready(function(){
	    
		$('#cs_contents').summernote({
			callbacks: {
			    onImageUpload: function(files, editor, welEditable) {
			    	for (var i = files.length - 1; i >= 0; i--) {
			    		sendFile(files[i], this, welEditable);
			    	}
				}
			},
			minHeight: 500,
            maxHeight: null,
            focus: true
    	});
		
		// 수정완료버튼
	    $("#btnEdit").click(function(){
	
	        var cs_title = $("#cs_title").val().trim();  
	        if(cs_title=="") {
	        	alert("글제목을 입력하세요!!");
	        	return;
	        }
	        
	        var cs_contents = $("#cs_contents").val().trim();  
	        if(cs_contents=="") {
	        	alert("글을 입력하세요!!");
	        	return;
	        }
	        
	        //폼 submit
	      	var editFrm = document.editFrm;
	      	editFrm.cs_title.value = $("#cs_title").val();
	      	editFrm.cs_contents.value = $("#cs_contents").val();
      	 	editFrm.cs_secret.value = $('input[name="cs_secret"]:checked').val();
	      	editFrm.action = "<%=ctxPath%>/consultEditEnd.pet";
	      	editFrm.method = "POST";
	      	editFrm.submit();
	    });
		
	}); // end of ready()-------------------------------------------
		
	// 썸머노트 파일업로드
	function sendFile(file, editor, welEditable) {
       
 		var form_data = new FormData();
 		form_data.append("file", file);
 	    $.ajax({
 	    	data: form_data,
        	type: "POST",
 	        url : "<%=request.getContextPath()%>/summernoteImageUpload.pet",
 	        cache : false,
	        contentType : false,
	        enctype: 'multipart/form-data',
	        processData : false,
 	        success : function(form_data) {
                $('#cs_contents').summernote('editor.insertImage', "<%=request.getContextPath()%>/resources/img/consult/"+form_data);
 	        }
 	    });
 	}
</script>

<div style="padding-top:8%; margin-bottom: 0.2%;" class="container"> 
	<h3 style="border:0.5px solid #fc766b; border-radius:3px; padding:1%;">&nbsp;&nbsp;&nbsp;1:1상담</h3>
	
	
<form name="editFrm" enctype = "multipart/form-data"> 

	<div align="center" >
			
		<div class="col-xs-12 col-md-12">
		
			<div class="col-xs-12 col-md-12 content">
				<div class="col-xs-3 col-md-2 content">동물 분류</div>
				<div class="col-xs-9 col-md-10 content" style="padding:0px;">
					<select name="cs_pet_type" id="cs_pet_type" style="height:5%; width:100%;" >
						<option value="1" <c:if test="${consultvo.cs_pet_type == 1}">selected</c:if>>강아지</option>
						<option value="2" <c:if test="${consultvo.cs_pet_type == 2}">selected</c:if>>고양이</option>
						<option value="3" <c:if test="${consultvo.cs_pet_type == 3}">selected</c:if>>소동물</option>
						<option value="4" <c:if test="${consultvo.cs_pet_type == 4}">selected</c:if>>기타</option>
					</select>
				</div>
			</div>
			
			<input type="hidden" name="consult_UID" value="${consultvo.consult_UID}"/>
			
			<div class="col-xs-12 col-md-12 content">
				<div class="col-xs-3 col-md-2 content">작성자</div>
				<input type="hidden" name="fk_idx" value="${sessionScope.loginuser.idx}" readonly/>
				<input type="text" name="name" id="name" style="border: 1px solid #999; border-radius:3px;" class="col-xs-9 col-md-10 content" value="${consultvo.name}" readonly/>
			</div>
			
			<div class="col-xs-12 col-md-12 content">
				<div class="col-xs-3 col-md-2 content">글제목</div>
				<input type="text" name="cs_title" id="cs_title" style="border: 1px solid #999; border-radius:3px;" class="col-xs-9 col-md-10 content" value="${consultvo.cs_title}"/>
			</div>
			
			<div class="col-xs-12 col-md-12 content">
				<div class="col-xs-3 col-md-2 content">공개여부</div>
				<div class="col-xs-9 col-md-10 content" style="padding-bottom:2%;" >
				<c:if test="${consultvo.cs_secret==1}"> 
					<input type="radio" name="cs_secret" class="content" id="open" value="1" checked/><label for="open">공개</label>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="cs_secret" class="content" id="secret" value="0"/><label for="secret">비공개</label>
				</c:if>
				
				<c:if test="${consultvo.cs_secret==0}"> 
					<input type="radio" name="cs_secret" class="content" id="open" value="1" /><label for="open">공개</label>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="cs_secret" class="content" id="secret" value="0" checked/><label for="secret">비공개</label>
				</c:if>
				</div>
			</div>
			
			<div class="col-xs-12 col-md-12 content">
				<textarea name="cs_contents" id="cs_contents" style="width:100%; border-radius:3px;" class="summernote" >${consultvo.cs_contents}</textarea>
           		<%-- ** textarea 태그에서 required="required" 속성을 사용하면 스마트 에디터는 오류가 발생하므로 사용하지 않는다. ** --%>
			</div>
		</div>	
		
		<div class="col-xs-12 col-md-12 content">
			<div class="col-xs-10 col-md-9 content"></div>
			<div class="col-xs-2 col-md-3 content">
				<button type="button" style="border: 1px solid #fc766b; border-radius:50px; width:40%; height:5%; color:#fc766b; margin-right:5%;" id="btnEdit">수정</button>
				<button type="button" style="border: 1px solid #fc766b; border-radius:50px; width:40%; height:5%; color:#fc766b;" onClick="javascript:history.back();">취소</button>
			</div>
		</div>
		
	</div> 
	
	</form>
</div> <!-- 전체 -->



	
<br/>
	

	
	

