<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%String ctxPath = request.getContextPath();%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<%@page import="java.text.SimpleDateFormat"%>

<%@page import="java.util.Calendar"%>


<style>


.divbox1{ /*전체 */
   margin-top: 3%;
   width:75%;
   background-color: #eaebed; 
   border: 0px solid gray;
   border-radius:10px;
   margin-bottom: 1%;
}

.divbox2{ /* 이미지 */
margin-top:3%;
display:inline-block;
}

.divbox3{ 
/* 펫정보*/
border: 1px solid gray; 
witdh:80%; 
height:20%; 
margin-top:3%;
padding-left:1%;
background-color:white;
padding-bottom:3%;
border-radius:10px;
}

.divbox4{ 
/* 캘린더 자리 */
 margin-top:3%;
 margin-bottom:5%;
 border: 1px solid gray;
 witdh:80%; 
 
 margin-top:3%;
 padding:3% 3% 3% 3%;
 border-radius:10px;
 background-color:white;
}

.divbox5{ /* 마지막 탭  */
background-color:white;
border: 1px solid gray;
border-top-style:none;
margin-top:5%;

padding-top:1%;
border-radius:10px; 
margin-bottom: 1%;
width:100%;

}
.btn2{
background-color:rgb(252, 118, 106);
color:white;
width:20%;
height:5%;
border-radius:15px;
margin-left: 38%;
margin-top: 1%;
margin-bottom: 2%;
}
.h3_1 {
margin-left: 1%;
margin-top:2%;
color:rgb(252, 118, 106);
}

.span{
	 
  } 

</style>
<link rel="stylesheet" href="<%=ctxPath%>/resources/css/fullcalendar.css"> 
<link rel="stylesheet" href="<%=ctxPath%>/resources/css/fullcalendar.min.css">

<script type="text/javascript" src="<%=ctxPath%>/resources/js/ko.js"></script>
<script type="text/javascript">
    
	$(document).ready(function(){
		//ajaxData();
		 $(".petimg").click(function(){
			var classes = $(this).attr('class');
			 //alert(classes); petimg petUid3
			 var str_classes = String(classes); // String으로 변환
			 var index = str_classes.indexOf('petUid'); // petUid의 자릿수
			 //alert(index); // 7
			 var petUid = str_classes.substring(index+6);
			 //alert(petUid);
			
			 $("#petUidNo").val(petUid);
			 
			// 펫정보 불러오기
			// showPet(petUid);  --- 1
			// 함수 showPet은 puid를 이용하여 한 마리의 반려동물 정보 불러오기 (ajax)

			// 캘린더
			
			
			
		 }); // 반려동물 누르면
		 
		 
		 
		
		 $("#register").click(function(){
			 
			var frm=document.registerFrm;
			frm.addaction = "<%=ctxPath%>/InsertMyChartEnd.pet";
			frm.method="POST";
			frm.submit();
		 });
		 
		 $('#calendar').fullCalendar({
			 selectable: true,
		      header: {
		        left: 'prev,next today',
		        center: 'title',
		        right: 'month,agendaSevenDay,agendaDay' 
		      },
		      contentHeight: 600,
		      views: {
		    	  agendaSevenDay: {
		    	     type: 'agenda',
		    	     duration: { days: 7 },
		    	     buttonText: 'week'
		    	   }
			  },
			  defaultView: 'month',
			  visibleRange: function(currentDate) {
		          return {
		            start: currentDate.clone().subtract(1, 'days'),
		            end: currentDate.clone().add(7, 'days') // exclusive end, so 3
		          };
		      },
		      lang: "ko",
		      events: function(start, end, timezone, callback){
		    	  
		    	  var data = {"fk_pet_uid":$("#petUidNo").val()};
		    	  
		    	  $.ajax({
		    		  url: "<%=request.getContextPath()%>/selectMyPrescription.pet",
		    		  type: "GET",
		    		  data: data,
		    		  dataType: "JSON",
		    		  success: function(json){
		    			  var events=[];
		    			  $.each(json, function(entryIndex,entry){
		    				  
		    				  events.push({
		        					id: entry.chart_uid,
		            				title: entry.chart_type, 
		            				start: entry.reservation_date,
		            				end: entry.reservation_date,
		            				backgroundColor: "gray"
		        				});
		    			  });
		    			  callback(events);
		    		  },
		    		  error: function(request, status, error){
		        			if(request.readyState == 0 || request.status == 0) return;
		        			//else alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        		}
		    	  }); // end of ajax();
		    	 
		      }
		      
		  });
	});// end of $(document).ready()----------------------
	
	
</script>
<div class="container divbox1">
   <h3 class="h3_1">진료기록 관리하기</h3>
   <div class="row" >
   
	   <c:forEach items="${pmaplist}" var="pvo" varStatus="status">
		    <div class="col-md-3" style="display:inlineblock;float:left;">
		    <input type="hidden" value="${pvo.pet_UID}" id="imgpuid${pvo.pet_UID}">
		    <img src="<%=ctxPath%>/resources/img/chart/${pvo.pet_profileimg}" class="petimg petUid${pvo.pet_UID}" width="50%"style="border-radius: 50%;display:block;"> 
		    <span style="font-weight: bold;padding-left: 10%;">[${pvo.pet_name}] 님</span>
		    </div>
	    </c:forEach>
  
   </div>
  
  <div class="divbox3">
	   <div class="container" Style="width:100%;">
	   <input type="text" id="petUidNo" value="${minpinfo.pet_UID}">
			  <p style="padding-top:1%;">생년월일: ${minpinfo.pet_birthday}</p>
			  <p>성별:   ${minpinfo.pet_gender}</p>
			  <p>몸무게: ${minpinfo.pet_weight} kg</p>
	   </div>
  </div>
  
<div class="divbox4" id="content" style="width:100%" >
	<div id="calendar">
	</div>
</div>
 <!-- 달력칸  -->
 
<div class="tab-content divbox5 container">
   <div class="container" Style="width:100%;">
	    <ul class="nav nav-tabs">
		    <li class="active"><a data-toggle="tab" href="#home">Home</a></li>
		    <li><a data-toggle="tab" href="#menu1">Menu 1</a></li>
		    <li><a data-toggle="tab" href="#menu2">Menu 2</a></li>
		    <li><a data-toggle="tab" href="#menu3">Menu 3</a></li>
	    </ul>
    </div>
    <form name="registerFrm">
    <div id="home" class="tab-pane fade in active" style="padding-left:2%;">
      
       <h3></h3>
       <p>진료예약일자:  </p>
       <p>방문일자: </p>
       <hr Style="width:100%; height:2%;"></hr>
       <div class="span col-md-10"><h3 style="font-weight:bold;color:pink; margin-top:0">진료결과 </h3></div>
       <div class="span col-md-10"><p>담당수의사: </p><input type="text" name="docname" style="margin-bottom: 1%;"/></div>
       <div class="span col-md-10"><p>처방약: </p><input type="text" name="mname" style="margin-bottom: 1%;"/></div>
        <div  class="span col-md-10"><span>하루 복용 횟수 :</span>
	      <select name="mtimes" style="margin-bottom: 1%;">
	        <option value="1">1</option>
	        <option value="2">2</option>
	        <option value="3">3</option>
	      </select>
	     </div>
        <div class="span col-md-10"><p>복용량: </p><input type="text" name="ms" style="margin-bottom: 1%;"/></div>
       <div class="span col-md-10"><p>주의사항: </p><textarea name="caution" style="width:40%;height:20%; margin-bottom: 1%;"></textarea></div>
       <div class="span col-md-10"><p>내  용: </p><textarea name="memo" style="width:40%;height:20%;"></textarea></div>
        <hr style="width:100%; height:2%;"></hr>
        <div style="margin-left: 70%;">
	       <p>예치금: </p>
	       <p>본인 부담금:</p>
	       <p>진료비 총액:</p>
       </div>
      </div>
        <input type="hidden" value="${sessionScope.loginuser.name}" name="name"/>
        </form>
        <button type="button" class="btn2" id="register">등록하기</button>
    </div>
   
</div>


