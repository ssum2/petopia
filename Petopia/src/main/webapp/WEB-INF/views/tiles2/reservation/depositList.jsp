<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>
<style>
/* [190130] 페이지바 css 추가 */
.pagination {
    display: block;
    padding-left: 0;
    margin: 20px 0;
    border-radius: 4px;
}

.pagination a {
  color: black;
  padding: 8px 16px;
  text-decoration: none;
  transition: background-color .3s;
}

.pagination a.active_p {
  background-color: rgb(255, 110, 96);
  color: white;
  pointer-events: none;
  cursor: default;
}
/* The Modal (background) */
.modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 1; /* Sit on top */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
  padding-top: 60px;
}

/* Modal Content/Box */
.modal-content {
  background-color: #fefefe;
  margin: 5% auto 15% auto; /* 5% from the top, 15% from the bottom and centered */
  border: 1px solid #888;
  width: 80%; /* Could be more or less, depending on screen size */
}

/* The Close Button (x) */
.close {
  position: absolute;
  right: 25px;
  top: 0;
  color: #000;
  font-size: 35px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: red;
  cursor: pointer;
}

/* Add Zoom Animation */
.animate {
  -webkit-animation: animatezoom 0.6s;
  animation: animatezoom 0.6s
}

@-webkit-keyframes animatezoom {
  from {-webkit-transform: scale(0)} 
  to {-webkit-transform: scale(1)}
}
  
@keyframes animatezoom {
  from {transform: scale(0)} 
  to {transform: scale(1)}
}

/* Change styles for span and cancel button on extra small screens */
@media screen and (max-width: 300px) {
  span.psw {
     display: block;
     float: none;
  }
  .cancelbtn {
     width: 100%;
  }
}
</style>
<%-- [190126] 일반회원 예치금 목록 --%>
<script type="text/javascript">
	$(document).ready(function(){
		all("1");
		
		$("#all").click(function(){
			all("1");
		});
		
		$("#charged").click(function(){
			charged("1");
		});
		
		$("#used").click(function(){
			used("1");	// [190129] 함수 수정
		});
		
	});
	
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	function all(currentShowPageNo){
		var form_data = {"currentShowPageNo":currentShowPageNo
						, "type": "-1"};
		
		$.ajax({
			url: "<%= ctxPath %>/depositHistory.pet",
			data: form_data,
			type: "GET",
			dataType: "JSON",
			success : function(json){
				var html = "";
				$.each(json, function(entryIndex, entry){
					html += "<tr><td>"+entry.deposit_UID+"</td>"+
							"<td>"+entry.depositcoin+"</td>"+
							"<td>"+entry.deposit_date+"</td>"+
							"<td>"+entry.showDepositStatus+"</td>"+
							"<td>";
					if(entry.deposit_status=="1"){
						html += "<button type='button' class='btn btn-danger' onClick='goCancleDeposit("+entry.deposit_UID+");'>충전취소</button>";
					}
					else if(entry.deposit_status=="3"){ // [190129] 상태 숫자 변경
						html += "<button type='button' class='btn btn-default' onClick='goRvDetail("+entry.fk_payment_UID+");'>예약상세</button>";
					}
					else if(entry.deposit_status=="2"){	// [190129] 상태 숫자 변경
						html += "<span style='text-align: center;'>환불완료</span>";
					}
					else if(entry.deposit_status=="0"){ // [190129] 상태 숫자 변경
						html += "<span style='text-align: center;'>출금완료</span>";
					}
					html += "</td></tr>";		
				}); // end of each
				$("#allContents").empty().html(html);
				makePageBar(currentShowPageNo, "-1");

			},
			error: function(request, status, error){
				if(request.readyState == 0 || request.status == 0) return;
				else alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}

		}); // end of ajax
	}
	
	
	function charged(currentShowPageNo){
		var form_data = {"currentShowPageNo":currentShowPageNo
						, "type": "1"};
		
		$.ajax({
			url: "<%= ctxPath %>/depositHistory.pet",
			data: form_data,
			type: "GET",
			dataType: "JSON",
			success : function(json){
				var html = "";
				$.each(json, function(entryIndex, entry){
					html += "<tr><td>"+entry.deposit_UID+"</td>"+
							"<td>"+entry.depositcoin+"</td>"+
							"<td>"+entry.deposit_date+"</td>"+
							"<td>";
					if(entry.deposit_status=="1"){
						html += "<button type='button' class='btn btn-danger' onClick='goCancleDeposit("+entry.deposit_UID+");'>충전취소</button>";
					}
					else if(entry.deposit_status=="3"){
						html += "<span style='text-align: center;'>환불완료</span>";
					}
					else if(entry.deposit_status=="4"){
						html += "<span style='text-align: center;'>출금완료</span>";
					}
					html += "</td></tr>";		
				}); // end of each
				$("#chargedContents").empty().html(html);
				makePageBar(currentShowPageNo, "1");

			},
			error: function(request, status, error){
				if(request.readyState == 0 || request.status == 0) return;
				else alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}

		}); // end of ajax
	}
	

	function used(currentShowPageNo){
		var form_data = {"currentShowPageNo":currentShowPageNo
						, "type": "3"};	// [190129] 타입 숫자 변경
		
		$.ajax({
			url: "<%= ctxPath %>/depositHistory.pet",
			data: form_data,
			type: "GET",
			dataType: "JSON",
			success : function(json){
				var html = "";
				$.each(json, function(entryIndex, entry){
					html += "<tr><td>"+entry.deposit_UID+"</td>"+
							"<td>"+entry.depositcoin+"</td>"+
							"<td>"+entry.deposit_date+"</td>"+
							"<td>"+
							"<button type='button' class='btn btn-default' onClick='goRvDetail("+entry.fk_payment_UID+")'>예약상세</button>"+
							"</td></tr>";		
				}); // end of each
				$("#usedContents").empty().html(html);
				makePageBar(currentShowPageNo, "2");

			},
			error: function(request, status, error){
				if(request.readyState == 0 || request.status == 0) return;
				else alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}

		}); // end of ajax
	}
	
	// [190130] 수정
	function makePageBar(currentShowPageNo, type){
		var form_data = {sizePerPage:"10",
						type: type};
		$.ajax({
			url: "<%= request.getContextPath()%>/depositHistoryPageBar.pet",
			data: form_data,
			type:"GET",
			dataType:"JSON",
			success: function(json){
				
				if(json.totalPage > 0){
					var totalPage = json.totalPage;
					var pageBarHTML = "";
					var blockSize = 10;
					
					var loop = 1; 
					
					var pageNo = Math.floor((currentShowPageNo-1)/blockSize)*blockSize+1;
					if(json.type==-1){
						if( pageNo!= 1){
							pageBarHTML += "&nbsp;<a href='javascript:all(\""+(pageNo-1)+"\");'>&laquo;</a>&nbsp;";
						}
						while(!(loop>blockSize || pageNo > totalPage)){
							if(pageNo == currentShowPageNo){
								pageBarHTML += "&nbsp;<a class='active_p'>"+pageNo+"</a>&nbsp;";
							}
							else{
								pageBarHTML += "&nbsp;<a href='javascript:all(\""+pageNo+"\");'>"+pageNo+"</a>&nbsp;";
							}
							
							loop++;
							pageNo++;
						}
						
						if( !(pageNo>totalPage)){
							pageBarHTML += "&nbsp;<a href='javascript:all(\""+pageNo+"\");'>&raquo;</a>&nbsp;";
						}
						
						$("#pageBarAll").empty().html(pageBarHTML);
					}
					else if(json.type==1){
						if(pageNo!= 1){
							pageBarHTML += "&nbsp;<a href='javascript:charged(\""+(pageNo-1)+"\");'>&laquo;</a>&nbsp;";
						}
						while(!(loop>blockSize || pageNo > totalPage)){
							if(pageNo == currentShowPageNo){
								pageBarHTML += "&nbsp;<a class='active_p'>"+pageNo+"</a>&nbsp;";
							}
							else{
								pageBarHTML += "&nbsp;<a href='javascript:charged(\""+pageNo+"\");'>"+pageNo+"</a>&nbsp;";
							}
							
							loop++;
							pageNo++;
						}
						
						if( !(pageNo>totalPage)){
							pageBarHTML += "&nbsp;<a href='javascript:charged(\""+pageNo+"\");'>&raquo;</a>&nbsp;";
						}
						
						$("#pageBarCharged").empty().html(pageBarHTML);
					}
					else if(json.type==2){
						if( pageNo!= 1){
							pageBarHTML += "&nbsp;<a href='javascript:used(\""+(pageNo-1)+"\");'>&laquo;</a>&nbsp;";
						}
						while(!(loop>blockSize || pageNo > totalPage)){
							if(pageNo == currentShowPageNo){
								pageBarHTML += "&nbsp;<a class='active_p'>"+pageNo+"</a>&nbsp;";
							}
							else{
								pageBarHTML += "&nbsp;<a href='javascript:used(\""+pageNo+"\");'>"+pageNo+"</a>&nbsp;";
							}
							
							loop++;
							pageNo++;
						}
						if( !(pageNo>totalPage)){
							pageBarHTML += "&nbsp;<a href='javascript:used(\""+pageNo+"\");'>&raquo;</a>&nbsp;";
						}
						$("#pageBarUsed").empty().html(pageBarHTML);
					}
					
				}
				else{
					if(json.type==-1){
						$("#pageBarAll").empty();
					}
					else if(json.type==1){
						$("#pageBarCharged").empty();
					}
					else if(json.type==2){
						$("#pageBarUsed").empty();
					}
					pageBarHTML = "";
				}
			},
			error: function(request, status, error){
				if(request.readyState == 0 || request.status == 0) return;
				else alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
			
		});
		
	} // end of makeCommentPageBar
	
	function goRvDetail(payment_UID){
		var form_data = {"payment_UID": payment_UID};
		
		$.ajax({
			url: "reservationDetail.pet",
			type: "GET",
			data: form_data,
			dataType: "JSON",
			success: function(json){
				$("#modal_reservation_UID").html(json.reservation_UID);
				$("#modal_biz_name").html(json.biz_name);
				$("#modal_phone").html(json.phone);
				$("#modal_pet_type").html(json.pet_type);
				$("#modal_pet_name").html(json.pet_name);
				$("#modal_rv_type").html(json.rv_type);
				$("#modal_reservation_date").html(json.reservation_date);
				$("#modal_bookingdate").html(json.bookingdate);
				$("#modal_reservation_status").html(json.reservation_status);
				$("#modal_payment_date").html(json.payment_date);
				$("#modal_payment_point").html(json.payment_point);
				$("#modal_payment_pay").html(json.payment_pay);
				$("#modal_payment_total").html(json.payment_total);
			},// end of success
			error: function(request, status, error){
				if(request.readyState == 0 || request.status == 0) return;
				else alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});// end of $.ajax
		document.getElementById('id01').style.display='block';

	}
</script>	    
<div class="container" style="margin-bottom: 8%;">
	<div  style="margin-top: 8%;">
  		<h2>Deposit History</h2>
  		<p>예치금 사용내역을 확인할 수 있습니다.</p>
	</div>
  <ul class="nav nav-tabs">
    <li class="active"><a data-toggle="tab" id="all" href="#home">전체</a></li>
    <li><a data-toggle="tab" id="charged" href="#menu1">충전내역</a></li>
    <li><a data-toggle="tab" id="used" href="#menu2">사용내역</a></li>
  </ul>

  <div class="tab-content">
    <div id="home" class="tab-pane fade in active">
      <h3>전체 사용 내역</h3>
      	<div class="table-responsive">
      	<table class="table">
      		<thead>
      		<tr>
      			<th>NO</th>
      			<th>금액</th>
      			<th>충전/사용일</th>
      			<th>상태</th>
      			<th>변경</th>
      		</tr>
      		</thead>
      		<tbody id="allContents">
      		</tbody>
      	</table>
      	<div id="pageBarAll" class="text-center pagination"></div>
      	</div>
    </div>
    <div id="menu1" class="tab-pane fade">
      <h3>충전내역</h3>
      <div class="table-responsive">
      	<table class="table">
      		<thead>
      		<tr>
      			<th>NO</th>
      			<th>금액</th>
      			<th>충전일</th>
      			<th>취소/환불</th>
      		</tr>
      		</thead>
      		<tbody id="chargedContents">
      		</tbody>
      	</table>
      	<div id="pageBarCharged" class="text-center pagination"></div>
      	</div>
    </div>
    <div id="menu2" class="tab-pane fade">
      <h3>사용내역</h3>
      <div class="table-responsive">
      	<table class="table">
      		<thead>
      		<tr>
      			<th>NO</th>
      			<th>금액</th>
      			<th>사용일</th>
      			<th>예약상태</th>
      		</tr>
      		</thead>
      		<tbody id="usedContents">
      		</tbody>
      	</table>
      	<div id="pageBarUsed" class="text-center pagination"></div>
      	</div>
    </div>
  </div>
</div>

<%-- [190130] 모달창, 자바스크립트 추가 --%>
<div id="id01" class="modal">
  
    <div class="imgcontainer">
      <span onclick="document.getElementById('id01').style.display='none'" class="close" title="Close Modal">&times;</span>
    </div>

    <div class="container">
    	<div class="row">
    		<div class="col-md-3">예약번호</div>
    		<div class="col-md-3" id="modal_reservation_UID"></div>
    	</div>
    	<div class="row">
    		<div class="col-md-3">병원명</div>
    		<div class="col-md-3" id="modal_biz_name"></div>
    	</div>
    	<div class="row">
    		<div class="col-md-3">연락처</div>
    		<div class="col-md-3" id="modal_phone"></div>
    	</div>
    	<div class="row">
    		<div class="col-md-3">진료과</div>
    		<div class="col-md-3" id="modal_pet_type"></div>
    	</div>
    	<div class="row">
    		<div class="col-md-3">반려동물명</div>
    		<div class="col-md-3" id="modal_pet_name"></div>
    	</div>
    	<div class="row">
    		<div class="col-md-3">진료타입</div>
    		<div class="col-md-3" id="modal_rv_type"></div>
    	</div>
    	<div class="row">
    		<div class="col-md-3">진료일시</div>
    		<div class="col-md-3" id="modal_reservation_date"></div>
    	</div>
    	<div class="row">
    		<div class="col-md-3">예약일시</div>
    		<div class="col-md-3" id="modal_bookingdate"></div>
    	</div>
    	<div class="row">
    		<div class="col-md-3">예약상태</div>
    		<div class="col-md-3" id="modal_reservation_status"></div>
    	</div>
    	<div class="row">
    		<div class="col-md-3">결제일시</div>
    		<div class="col-md-3" id="modal_payment_date"></div>
    	</div>
    	<div class="row">
    		<div class="col-md-3">결제포인트</div>
    		<div class="col-md-3" id="modal_payment_point"></div>
    	</div>
    	<div class="row">
    		<div class="col-md-3">실 예치금결제 금액</div>
    		<div class="col-md-3" id="modal_payment_pay"></div>
    	</div>
    	<div class="row">
    		<div class="col-md-3">총 결제금액</div>
    		<div class="col-md-3" id="modal_payment_total"></div>
    	</div>
    </div>

    <div class="container" style="background-color:#f1f1f1">
    </div>
</div>

<script>
// Get the modal
var modal = document.getElementById('id01');

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}
</script>