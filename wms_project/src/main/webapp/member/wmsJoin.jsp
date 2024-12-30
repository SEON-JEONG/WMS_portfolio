<!-- 스크립트 자동 업데이트 -->
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ taglib prefix="cr" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	Date today = new Date();
	SimpleDateFormat sf =new SimpleDateFormat("yyyMMddhhmmss");	
%>    

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>이행 물류 시스템</title>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="../css/bootstrap.css?v=1">
    <link rel="stylesheet" href="../css/default.css?v=20241124">
    <script src="../js/wmsJoin.js?v=<%=sf.format(today)%>"></script>
</head>
<body style="position: relative;">

    <form id="f1" >    
    <div class="container" style="position: relative; top:15vh; width: 750px;">	
        <h6 style="text-align: center; height: 40px; line-height: 40px;">
            <u>ADMINISTRATOR MEMBERSHIP</u>
        </h6>
                
        <div>
            <div class="mb-3" style="position: relative;">
            <ul class="ul-1">
                <li class="num_font13_bold">소 속</li>
                <li style="width: 85%; display: flex; flex-direction: row;">
                    <select name="mpart" id="mpart" style="width: 100px; height: 40px; margin-right: 5px;" class="form-control font12" onchange="part_click()">
                        <option value="본사">본사</option>
                        <option value="지점">지점</option>
                    </select>
                    <select name="mspot" id="mspot" style="width: 180px; height: 40px;" class="form-control font12" hidden>
                        <option value="N">선택해주세요</option>
                        <cr:forEach var="office" items="${all}">
                        	<option value="${office.officename}">${office.officename}</option>
                    	</cr:forEach>
                    </select>
                </li>
                <li></li>
                <li></li>
            </ul> 
            <ul class="ul-1">
                <li class="num_font13_bold">담당자명</li>
                <li>
                    <input name="mname" id="mname" type="text" style="height: 40px;" class="form-control font12" placeholder="담당자명을 입력하세요">
                </li>
                <li class="num_font13_bold">직 책</li>
                <li>
                    <select name="mjob" id="mjob" style="width: 150px; height: 40px;" class="form-control font12">
                        <option value="">선택해주세요</option>
                        <option value="임원">임원</option>
                        <option value="실장">실장</option>
                        <option value="부장">부장</option>
                        <option value="팀장">팀장</option>
                        <option value="차장">차장</option>
                        <option value="과장">과장</option>
                        <option value="대리">대리</option>
                        <option value="주임">주임</option>
                        <option value="사원">사원</option>
                    </select>
                </li>
            </ul> 
            <ul class="ul-1" style="margin-top: 5px;">
                <li class="num_font13_bold">아이디</li>
                <li style="width: 85%; display: flex; flex-direction: row;">
                    <input name="mid" id="mid" type="text" style="width: 160px; height: 40px; margin-right: 5px;" class="form-control font12" placeholder="아이디를 입력하세요">
                    <button type="button" class="btn btn-secondary font12" style="width: 100px; height: 40px;" onclick="idcheck()">중복체크</button>
                </li>
                <li></li>
                <li></li>
            </ul> 
            <ul class="ul-1" style="margin-bottom: 5px;">
                <li class="num_font13_bold">패스워드</li>
                <li>
                    <input name="mpass" id="mpass" type="password" style="height: 40px;" class="form-control font12" placeholder="패스워드를 입력하세요">
                </li>
                <li class="num_font13_bold">패스워드 확인</li>
                <li>
                    <input id="repw" type="password" style="height: 40px;" class="form-control font12" placeholder="동일한 패스워드를 입력하세요">
                </li>
            </ul> 
            <ul class="ul-1" style="margin-bottom: 5px;">
                <li class="num_font13_bold">이메일</li>
                <li style="width: 85%; display: flex; flex-direction: row;">
                    <input name="memail" id="memail" type="text" style="width: 360px; height: 40px;" class="form-control font12" placeholder="이메일을 입력하세요">
                </li>
                <li></li>
                <li></li>
            </ul> 
            <ul class="ul-1" style="margin-bottom: 5px;">
                <li class="num_font13_bold">연락처</li>
                
                <!-- 휴대폰번호 -->
                <input type="hidden" name="mhp" vlaue="">
                
                <li style="width: 85%; display: flex; flex-direction: row;">
                    <select id="hp1" value="" style="width: 80px; height: 40px;" class="form-control font12">
                        <option value="010">010</option>
                        <option value="011">011</option>
                        <option value="016">016</option>
                        <option value="017">017</option>
                    </select>&nbsp;-&nbsp;
                    <input id="hp2" type="text" style="width: 100px; height: 40px;" maxlength="4" class="form-control font12">&nbsp;-&nbsp;
                    <input id="hp3" type="text" style="width: 100px; height: 40px;" maxlength="4" class="form-control font12">
                </li>
                <li></li>
                <li></li>
            </ul> 

            </div>
            <div class="mb-3" style="display: flex; flex-direction: row; align-items: center; justify-content: center;">
            <button type="button" class="btn btn-primary font12" style="width: 30%; height: 40px; margin-right: 10px;" onclick="login_check()">신청하기</button>   
            <button type="button" class="btn btn-secondary font12" style="width: 30%; height: 40px;" onclick="location.href='./wmsLogin.jsp'">취소하기</button>  
            </div>   
            <div class="mb-3 font14">
                ※ 회원가입 후 최고관리자가 승인해야만 로그인이 처리 됩니다.<br>
                ※ 모든 정보는 기록되며, 퇴사시 해당 정보는 접속이 불가능 합니다.
            </div>       
        </div>
    </div>
    </form>
</body>
</html>