<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
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
    <link rel="stylesheet" href="../css/bootstrap.css?v=<%=sf.format(today)%>">
    <link rel="stylesheet" href="../css/default.css?v=<%=sf.format(today)%>">
    <script src="../js/wmsLogin.js?v=<%=sf.format(today)%>"></script>
</head>
<body style="position: relative;">



<form id="f" class="form-signin" onsubmit="return logincheck()">
    <div class="container" style="position: relative; top:35vh; width: 450px; height: 280px;">	
        <h6 style="text-align: center; height: 40px; line-height: 40px;">
            <u>ADMINISTRATOR</u>
        </h6>
 
            <div class="mb-3" style="position: relative;">
               <div class="input-group" style="height: 40px;">
                <span class="input-group-text" id="basic-addon1">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-fill" viewBox="0 0 16 16">
                    <path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6"></path>
                    </svg>
                  </span>
                  <input type="text" name="mid" style="height: 40px;"  class="form-control font12" placeholder="아이디를 입력하세요">
               </div>
            </div>
            <div class="mb-3">
                <div class="input-group" style="height: 40px;">
                    <span class="input-group-text" id="basic-addon1">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-key" viewBox="0 0 16 16">
                            <path d="M0 8a4 4 0 0 1 7.465-2H14a.5.5 0 0 1 .354.146l1.5 1.5a.5.5 0 0 1 0 .708l-1.5 1.5a.5.5 0 0 1-.708 0L13 9.207l-.646.647a.5.5 0 0 1-.708 0L11 9.207l-.646.647a.5.5 0 0 1-.708 0L9 9.207l-.646.647A.5.5 0 0 1 8 10h-.535A4 4 0 0 1 0 8m4-3a3 3 0 1 0 2.712 4.285A.5.5 0 0 1 7.163 9h.63l.853-.854a.5.5 0 0 1 .708 0l.646.647.646-.647a.5.5 0 0 1 .708 0l.646.647.646-.647a.5.5 0 0 1 .708 0l.646.647.793-.793-1-1h-6.63a.5.5 0 0 1-.451-.285A3 3 0 0 0 4 5"/>
                            <path d="M4 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0"/>
                        </svg>
                      </span>
                      <input type="password" name="mpass" style="height: 40px;" class="form-control font12" placeholder="패스워드를 입력하세요">
                   </div>
            </div>
            <p class="admintxt">[최고관리자 계정]&nbsp&nbsp 아이디 : admin &nbsp 패스워드 : admin</p>
            <div class="mb-3">
            <button type="submit" class="btn btn-primary font12" style="width: 100%; height: 40px;">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-box-arrow-in-right" viewBox="0 0 16 16">
                <path fill-rule="evenodd" d="M6 3.5a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 .5.5v9a.5.5 0 0 1-.5.5h-8a.5.5 0 0 1-.5-.5v-2a.5.5 0 0 0-1 0v2A1.5 1.5 0 0 0 6.5 14h8a1.5 1.5 0 0 0 1.5-1.5v-9A1.5 1.5 0 0 0 14.5 2h-8A1.5 1.5 0 0 0 5 3.5v2a.5.5 0 0 0 1 0z"></path>
                <path fill-rule="evenodd" d="M11.854 8.354a.5.5 0 0 0 0-.708l-3-3a.5.5 0 1 0-.708.708L10.293 7.5H1.5a.5.5 0 0 0 0 1h8.793l-2.147 2.146a.5.5 0 0 0 .708.708z"></path>
                </svg>
                로그인
            </button>   
            </div>
            
            <div class="mb-3">
            <button type="button" class="btn btn-secondary font12" style="width: 100%; height: 40px;" onclick="location.href='./wmsJoin.do'">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-plus-fill" viewBox="0 0 16 16">
                    <path d="M1 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6"/>
                    <path fill-rule="evenodd" d="M13.5 5a.5.5 0 0 1 .5.5V7h1.5a.5.5 0 0 1 0 1H14v1.5a.5.5 0 0 1-1 0V8h-1.5a.5.5 0 0 1 0-1H13V5.5a.5.5 0 0 1 .5-.5"/>
                  </svg>
                관리자 등록
            </button>  
            </div>   
            <div class="mb-3 font12">
                ※ 사원번호가 없을시 관리자에게 연락 바랍니다.<br>
                ※ 모든 정보는 기록되며, 퇴사시 해당 정보는 접속이 불가능 합니다.
            </div>       
    </div>
</form>

</body>
</html>