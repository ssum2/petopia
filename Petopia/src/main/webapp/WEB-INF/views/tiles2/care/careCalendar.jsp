<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	

<style>

	div #title {
		text-align: center; 
		margin-top: 5%;
	}
	
	.pet-box {
		display: inline-block;
	}
	
	.petname {
		display: inline-block;
		margin-left:auto;
		margin-right:auto;
	}
	
	.img {
		display: block; 
		margin: 0px 6px;
		text-align: left;
	}
	
	.img img {
		height: 120px; 
		width: 120px;
		margin-left: auto;
		margin-right: auto;
		border-radius: 100%;
	}
	
  	#wrap {
    	width: 1100px;
	    margin: 0px auto;
	    margin-bottom: 10%;
	    padding-top: 10%;
	}
	
	li {
		list-style-type: none;
	}
	
	ul {
		display: inline-block;
		padding: 0px;
	}
	
	.info {
		margin: 0px auto;
	}

	#external-events {
		float: center;
		 margin: 0px auto;
		/* width: 250px; */
		/* margin-left: 20px; */
		/* border: 1px solid #ccc; */
		/* background: #eee; */
		text-align: center;
	}

	#external-events h4 {
		font-size: 16px;
		margin-top: 0;
		padding-top: 1em;
	}

	#external-events .fc-event {
		display: inline-block;
		margin: 0px auto;
		padding: 10px;
		width: 60px;
		border: 1px solid black;
		background-color: transparent;
		color: black;
		cursor: pointer;
	}

	#external-events p {
		margin: 1.5em 0;
		font-size: 11px;
		color: #666;
	}

	#external-events p input {
		margin: 0;
		vertical-align: middle;
	}

	#calendar {
		float: left;
		width: 70%;
	}
	
	fieldset {
		display: block;
		margin-inline-start: 2px;
		margin-inline-end: 2px;
		padding-block-start: 0.35em;
		padding-inline-start: 0.75em;
		padding-inline-end: 0.75em;
		padding-block-end: 0.625em;
		min-inline-size: min-content;
		border-width: 2px;
		border-style: groove;
		border-color: threedface;
		border-image: initial;
	} 
	
	#table {
		border-collapse: collapse;
		width: 100%;
	}
	
	#table th, td {
		text-align: center;
		padding: 8px;
	}
	
	#table tr:nth-child(even) {
		background-color: #f2f2f2
	}
	
	#table th {
		background-color: #4CAF50;
		color: white;
	}
 
</style>


<script>

	$(document).ready(function() {
		
		getPet();
		getPetcare();

	    /* initialize the external events
	    -----------------------------------------------------------------*/
		$('#external-events .fc-event').each(function() {
	
			// store data so the calendar knows to render an event upon drop
			$(this).data('event', {
				title: $.trim($(this).text()), // use the element's text as the event title
				stick: true // maintain when user navigates (see docs on the renderEvent method)
			});
	
			// make the event draggable using jQuery UI
			$(this).draggable({
				zIndex: 999,
				revert: true,      // will cause the event to go back to its
				revertDuration: 0  //  original position after the drag
			});
	
		});
	
	
		/* initialize the calendar
		-----------------------------------------------------------------*/
		$('#calendar').fullCalendar({
			header: {
	        left: 'prev,next today',
	        center: 'title',
	        right: 'month'
			},
			editable: true,
			droppable: true, // this allows things to be dropped onto the calendar
			drop: function() {
			// is the "remove after drop" checkbox checked?
			if ($('#drop-remove').is(':checked')) {
				// if so, remove the element from the "Draggable Events" list
				$(this).remove();
				}
			}
		});
	
	});// end of $(document).ready()----------------------------------------
	
    function getPet() { 
	      
	      var form_data = {fk_idx : "${fk_idx}"}; 

	      $.ajax({
	         url : "getPet.pet",   
	         type :"GET",                              
	         data : form_data,                          
	         dataType : "JSON",                        
	         success : function(json) {                
	                 $("#displayPetList").empty();
	                                 
	                 var html = "";
	                  
	                  $.each(json, function(entryIndex, entry){ 
	                      
	                     html += "<div align='center' class='pet-box'>"
	                     	   + "	<span class='petname'>" + entry.PET_NAME + "</span>"
	                     	   + "	<div class='img' style='display: block; text-align: left;'><img src='resources/img/care/" + entry.PET_PROFILEIMG + "' /></div>"
	                     	   + "</div>";
	                  	                  
	                  });
	                     
	                  	html += "<a href='petRegister.pet'><img src='resources/img/care/petAdd.png' width='40px;' height='40px;'></a>";
	                  	
	                  $("#displayPetList").append(html);
	          },
	          error: function(request, status, error){
	               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	          }         
	      });
	      
	   } // end of function getPet()-------------------------------------------
 
	    function getPetcare() { 
		      
		      var form_data = {pet_UID : "${pet_UID}"}; 
		      console.log(form_data);

		      $.ajax({
		         url : "getPetcare.pet",   
		         type :"GET",                              
		         data : form_data,                          
		         dataType : "JSON",                        
		         success : function(json) {                
		                 $("#displayPetcare").empty();
		                                 
		                 var html = "<table id='table' class='table table-sm'>"
                   	   			  + "	<thead>"
                   	   			  + "		<tr>"
                   	   			  + "			<th colspan='3'>Handle</th>"
                   	   			  + "		</tr>"
                   	   			  + "	</thead>"
	                   	   		  + "	<tbody>";
			                  
		                  $.each(json, function(entryIndex, entry){ 
		                      
		                     html += "		<tr>"
		                    	   + "			<td>" + entry.CARETYPE_NAME + "</td>"
		                     	   + "			<td>" + entry.CARE_CONTENTS + "</td>"
		                     	   + "			<td>" + entry.CARE_END + "</td>"
		                     	   + "		<tr>";
		                          
		                  });
		                     
		                  	html += "	</tbody>"
		                  		  + "</table>";
		                  	
		                  $("#displayPetcare").append(html);
		          },
		          error: function(request, status, error){
		               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		          }         
		      });
		      
		   } // end of function getPet()-------------------------------------------	   
	   
</script>


<!-- container 시작 -->
<div class="container">
	<div id="title"><h2>케어관리</h2></div>
	
	<!-- profile 시작 -->
	<div class="row profilebody">
		<div class="col-sm-12">
			<div id="displayPetList" class="fl"> 

			</div>
		</div>	
	</div>
	<!-- profile 끝 -->
	
	<!-- 메인 content 시작 -->
	<div class="row">
		<div id='wrap'>
		   
			<!-- calendar 시작 -->	
		    <div id='calendar' class="col-sm-9">
		    
		    </div>
		    <!-- calendar 끝-->
		   
			<!-- info 사이드 시작 -->
			<div class="col-sm-3" >			 
				<div align='center'>
					<span class="petname">케어명</span>
					<div><img src="resources/img/care/feeding-a-dog.png" style="height: 100px; width: 100px;" /></div>
					<div class="petname info" align='center'>케어경고알림</div>
		  		</div>
		  			
				<div id='external-events' align="center">
					<li>
				      	<div>
				      		<ul><a href="careRegister.pet?fk_pet_UID=${pet_UID}&fk_caretype_UID=1" class="fc-event btn btn-lg btn-default"><span class="glyphicon glyphicon-cutlery"></span>&nbsp;식사</a></ul>
				      		<ul><a href="careRegister.pet?fk_pet_UID=${pet_UID}&fk_caretype_UID=2" class="fc-event btn btn-lg btn-default"><span class="glyphicon glyphicon-trash"></span>&nbsp;용변</a></ul> 
				      	</div>
				      	<div>
				      		<ul><a href="careRegister.pet?fk_pet_UID=${pet_UID}&fk_caretype_UID=3" class="fc-event btn btn-lg btn-default"><span class="glyphicon glyphicon-glass"></span>&nbsp;양치</a></ul>
				      		<ul><a href="careRegister.pet?fk_pet_UID=${pet_UID}&fk_caretype_UID=4" class="fc-event btn btn-lg btn-default"><span class="glyphicon glyphicon-tint"></span>&nbsp;목욕</a></ul>
				      	</div>
				      	<div>
				      		<ul><a href="careRegister.pet?fk_pet_UID=${pet_UID}&fk_caretype_UID=5" class="fc-event btn btn-lg btn-default"><span class="glyphicon glyphicon-calendar"></span>&nbsp;달력</a></ul> 
				      		<ul><a href="careRegister.pet?fk_pet_UID=${pet_UID}&fk_caretype_UID=6" class="fc-event btn btn-lg btn-default"><span class="glyphicon glyphicon-pencil"></span>&nbsp;메모</a></ul>
						</div>
					</li>
		 
					<p>
						<input type='checkbox' id='drop-remove' />
						<label for='drop-remove'>remove after drop</label>
					</p> 
			    </div>
	    	</div> 
		 
		    <div style='clear:both'></div>
		  
		</div>
	</div>

	<!-- File Button -->
	<fieldset>
		<div class="row">
			<div id="displayPetcare" class="col-sm-12">
			
			<!-- 
			<table class="table table-sm">
				<thead>
					<tr>
						<th colspan="3">Handle</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>Mark</td>
						<td>Otto</td>
						<td>@mdo</td>
					</tr>
					<tr>
						<td>Jacob</td>
						<td>Thornton</td>
						<td>@fat</td>
					</tr>
					<tr>
						<td colspan="2">Larry the Bird</td>
						<td>@twitter</td>
					</tr>
				</tbody>
			</table> 
			-->
			
			</div>
		</div>
	</fieldset>

 
</div>
<!-- container 끝 -->	 








