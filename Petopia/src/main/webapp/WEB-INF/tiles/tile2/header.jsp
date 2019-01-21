<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.InetAddress" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

<style>
.navbar {
     margin-bottom: 0;
     background-color: rgb(252, 118, 106);
     z-index: 9999;
     border: 0;
     font-size: 12px !important;
     line-height: 1.42857143 !important;
     letter-spacing: 4px;
     border-radius: 0;
   }
   
   .navbar li a, .navbar .navbar-brand {
     color: white !important;
   }
   
   .navbar-brand{
   	font-size: 30px;
  	font-weight: bold;
  	margin-left: 2.5%;
   }
   .navbar-nav li a:hover, .navbar-nav li.active a {
     font-weight: bold;
   }
   
   .navbar-default .navbar-toggle {
     border-color: transparent;
     color: #fff !important;
   }
       
   .navbar-default .navbar-nav .dropdown .dropdown-toggle:focus,
    .navbar-default .navbar-nav .dropdown .dropdown-toggle:hover
     {
        color: #fff;
        background-color: rgb(252, 118, 106);
     }
   
    /*-- change navbar dropdown color --*/
     .navbar-default .navbar-nav .open .dropdown-menu>li>a,.navbar-default .navbar-nav .open .dropdown-menu {
       background-color: #fff !important;
       color: rgb(252, 118, 106) !important;
     }
     
</style>

<script src='https://developers.kakao.com/sdk/js/kakao.min.js'></script>

<script type="text/javascript">
	$(document).ready(function(){
		
	});
	
	function logOut() {
		alert("dddddd");
		Kakao.init('b5a80832c3cb255d6b0092b12fa51f95'); //카카오에서 제공 myceo.co.kr 수정
		Kakao.Auth.logout(
			function(obj) {
				if(obj==true){}else{}
				 location.href='<%=request.getContextPath()%>/home.pet';
			 }
		);
	} // end of logOut
	
</script>

<div>
	<div class="header">
		<!-- <a href="#default" class="logo">PETOPIA</a>
		<div class="header-right">
			<div class="row">
				<button type="button" class="btn btn-rounder" id="btnRegister">&nbsp;&nbsp;회원가입&nbsp;&nbsp;</button>&nbsp;&nbsp;
				<button type="button" class="btn btn-rounder" id="btnLogin">&nbsp;&nbsp;로그인&nbsp;&nbsp;</button>
			</div>
		</div> -->
		<nav class="navbar navbar-default navbar-fixed-top">
			<div class="container">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span> 
					</button>
					<a class="navbar-brand logo" href="<%= ctxPath %>/home.pet">PETOPIA</a>
				</div>
				<div class="collapse navbar-collapse" id="myNavbar">
					<ul class="nav navbar-nav navbar-right">
						<c:if test="${sessionScope.loginuser == null }">
							<li><a href="<%= ctxPath %>/join.pet">회원가입</a></li>
							<li><a href="<%= ctxPath %>/login.pet" >로그인</a></li>
						</c:if>
						<c:if test="${sessionScope.loginuser != null }">
							<li><a onclick="logOut();" href="<%= ctxPath %>/logout.pet">[${sessionScope.loginuser.nickname }] 로그아웃</a></li>
							<c:if test="${sessionScope.loginuser != null && sessionScope.loginuser.membertype != 3 }"><%-- 관리자일 경우 없애기 --%>
								<li class="dropdown">
									<a class="dropdown-toggle" data-toggle="dropdown" href="#">마이페이지
									<span class="caret"></span></a>
									<ul class="dropdown-menu">
										<li><a href="#">반려동물수첩</a></li>
										<li><a href="<%= ctxPath %>/infoMember.pet">나의정보보기</a></li>
										<li><a href="#">나의병원리뷰</a></li>
										<li><a href="#">나의병원관리</a></li>
									</ul>
								</li>
							</c:if>
						</c:if>
					</ul>
				</div>
			</div>
		</nav>
	</div>
	
	<c:if test="${sessionScope.loginuser == null || sessionScope.loginuser.membertype == 1 }"><%-- 일반회원인 경우 --%>
		<div class="navbar1">
			<div class="dropdown1">
				<div class="row">
					<div class="col-md-2"></div>
					<button type="button" class="btnmenu dropbtn" style="font-size: 16px;">병원/약국찾기</button>
					<button type="button" class="btnmenu dropbtn" style="font-size: 16px;">병원예약관리</button>
					<button type="button" class="btnmenu dropbtn" style="font-size: 16px;">상담</button>
					<button type="button" class="btnmenu dropbtn" style="font-size: 16px;">반려동물수첩</button>
					<button type="button" class="btnmenu dropbtn" style="font-size: 16px;">커뮤니티</button>
				</div>
				<div class="dropdown-content"> 
					<div class="row">
						<div class="col-md-2"></div>
						<div class="column" id="search">
						</div>
						<div class="column" id="reservation">
							<a href="<%= ctxPath %>/reservation.pet">병원예약</a>
							<a href="<%= ctxPath %>/reservationList.pet">예약내역</a>
							<a href="<%= ctxPath %>/deposit.pet">예치금관리</a>
						</div>
						<div class="column" id="consult">
							<a href="#">1:1 문의상담</a>
							<a href="#">화상진료</a>
						</div>
						<div class="column" id="petCare">
							<a href="#">반려동물관리</a>
							<a href="#">반려동물케어</a>
							<a href="#">진료기록관리</a>
							<a href="#">나의 병원리뷰</a>
						</div>
						<div class="column" id="board">
							<a href="#">공지사항</a>
							<a href="#">이벤트</a>
							<a href="#">자유게시판</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</c:if>
	
	<c:if test="${sessionScope.loginuser != null && sessionScope.loginuser.membertype == 3 }"><%-- 관리자인 경우 --%>
		<div class="navbar1">
		   	<div class="dropdown1">
		   		<div class="row">
					<div class="col-md-3"></div>
					<button type="button" class="btnmenu dropbtn" style="font-size: 16px;">회원관리</button>
					<button type="button" class="btnmenu dropbtn" style="font-size: 16px;">리뷰관리</button>
					<button type="button" class="btnmenu dropbtn" style="font-size: 16px;">상담</button>
					<button type="button" class="btnmenu dropbtn" style="font-size: 16px;">커뮤니티관리</button>
				</div>
				
				<div class="dropdown-content"> 
					<div class="row">
						<div class="col-md-3"></div>
						<div class="column" id="adminMember">
							<a href="<%= ctxPath %>/adminMember.pet">일반회원</a>
							<a href="<%= ctxPath %>/adminBiz_member.pet">병원회원</a>
						</div>
						<div class="column" id="adminReview">
						</div>
						<div class="column" id="adminConsult">
							<a href="#">1:1 문의상담</a>
							<a href="#">화상진료</a>
						</div>
						<div class="column" id="adminBoard">
							<a href="#">공지사항</a>
							<a href="#">이벤트</a>
							<a href="#">자유게시판</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</c:if>
</div>
