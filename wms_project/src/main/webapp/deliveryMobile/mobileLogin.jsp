<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	Date today = new Date();
	SimpleDateFormat sf =new SimpleDateFormat("yyyMMddhhmmss");	
%>       

<meta charset="UTF-8"><!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="../css/delivery_m.css?v=<%=sf.format(today)%>">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap">
<title></title>
</head>
<body>
    <div class="Mbody">
       <div class="Mtitle">DELYVERY<br>SYSTEM<br>(배송기사 모바일 전용)</div>
       <form name="fm" id="fm">
       <div class="Mlogin">
           <ul>
               <li><input type="text" class="Mloginput" name="deliver_id" id="deliver_id" placeholder="기사님 사원번호를 입력하세요"></li>
               <li><input type="password" class="Mloginput" name="deliver_pw" id="deliver_pw" placeholder="기사님 패스워드를 입력하세요"></li>
               <li><label style="width: 100%;"><input type="checkbox" class="Mlogcheck" name="deliver_check" value="Y" > 아이디 및 패스워드 저장</label></li>
               <li><button type="button" class="Mloginbt" id="login_btn" >로그인</button></li>
           </ul>
       </div>
       </form>
    </div>
</body>
<script src="../js/mobileLogin.js?v=<%=sf.format(today)%>"></script>
</html>    