<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>

<style type="text/css">
	.chatbody {font-family: NanumGothic, 나눔 고딕, 맑은 고딕, dotum;}
	.modal-header {background-color: rgb(252, 118, 106);}
	.modal-body {background-color: rgb(252, 118, 106);}
	.modal-footer {background-color: rgb(252, 118, 106);}
	.modal-title {
    color: white;
    font-family: 'Roboto', 'Open Sans', 'Lucida Grande', sans-serif;}

</style>

<script type="text/javascript">
	$(document).ready(function(){
		
	}); // end of document.ready
	
	function goChat() {
		var frm = document.chatFrm;
		frm.method = "GET";
		frm.action = "<%=request.getContextPath() %>/videochat.pet";
		frm.submit();
	}
</script>

<form name="chatFrm">
	<div class="container" style="margin-left: 20%; margin-top: 10%; min-height: 70%;">
	<div class="row">
	  <div class="chat" >
	    	<h2>화상 진료</h2>
	  </div>
	</div>
	  <div class="chatbody" style="weight: 100%; height: 100%; padding:40px; border-top: 1px solid #dfdfdf; border-bottom: 1px solid #dfdfdf; margin-right: 20%; background-color: #fbfbfb;">
		<img src="<%=ctxPath%>/resources/img/chat/chat1.png" style="margin-top: 8%; position: absolute;">
	  	<span style="font-weight: bold; font-size: 18px;">
	  		온라인 채팅ㆍ화상 상담</br></br>
	  	</span>
	  	<span style="font-size: 15px; margin-top: 20px;">
	  		걱정되시는 점 및 진료 선행 상담 부터 반려동물 생활 까지  궁금한 내용을</br>
	  		채팅 및 화상 상담을 통해 상담안내하여 드립니다.
	  	</span>
	  	<span style="font-size: 12px;">
	  	</br></br>
	  	<span style="font-weight: bold;">ㆍ온라인 상담시간 :</span> 09:00 ~ 18:00 </br>
		<span style="font-weight: bold;">ㆍ이용문의 :</span> 010-1234-5678
		</span>
		<button type="button" data-toggle="modal" data-target="#videochat" data-dismiss="modal" style="cursor: pointer; margin-top:60%; float:right;">상담하기</button>
	  	
	  </div>  
	</div>
	
	<div class="modal fade" id="videochat" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
			 <div class="modal-header">
				<button type="button" class="close myclose" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">화상상담 코드 입력</h4>
			 </div>
			 <div class="modal-body" style="height: 150px; width: 100%;">
			 	<iframe class="iframe" style="border: none; width: 100%; height: 120px;" src="<%= request.getContextPath() %>/videocode.pet"></iframe>
			 </div>
			 <div class="modal-footer">
			 	<button type="button" class="btn btn-default myclose" data-dismiss="modal">닫기</button>
			 </div>
			</div>
		</div>
	</div>
	
</form>