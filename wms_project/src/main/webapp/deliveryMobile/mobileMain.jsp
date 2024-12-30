<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/functions" %>    
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>    
<%
	Date today = new Date();
	SimpleDateFormat sf =new SimpleDateFormat("yyyMMddhhmmss");	
%>

<%
	HttpSession sess = request.getSession(false);
	
if (session == null || 
	session.getAttribute("dcode") == null || 
	session.getAttribute("name") == null || 
	session.getAttribute("email") == null || 
	session.getAttribute("spot") == null || 
	session.getAttribute("hp") == null || 
	session.getAttribute("approve") == null) {
	
%>
	<script>
	alert('비정상적인 접근입니다. 로그인 페이지로 이동합니다.');
    location.href = '/deliveryMobile/mobileLogin.jsp';
	</script>
<%  

return; 
}

	String id = (String)sess.getAttribute("dcode");
	String name = (String)sess.getAttribute("name");
	String email = (String)sess.getAttribute("email");
	String spot = (String)sess.getAttribute("spot");
	String hp = (String)sess.getAttribute("hp");
	String approve = (String)sess.getAttribute("approve");
%>

<meta charset="UTF-8"><!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="../css/delivery_m.css?v=20241216154654">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap">
<script src="../js/jquery.js"></script>
<script src="../js/mobileMain.js?v=<%=sf.format(today)%>"></script>
<title>DELYVERY SYSTEM</title>
</head>
<body>
    <form>
    <input type="hidden" id="old" value="">
    <input type="file" id="files" accept = "image/*" capture="capture" style="display: none;">
    </form>
    <!--메뉴슬라이드-->
    <meta charset="UTF-8">
<section class="blackscreen" id="blackscreen">
    <div class="s_menu" id="s_menu">
        <span id="menu_outline" class="menu_outline">
        <p class="p_login">
        <span>[기사1]님 환영합니다.</span>
        <span id="login_out"><img src="./img/logout.svg" class="menuico"></span>
        </p>
        <ul class="s_menu_ul" id="s_menu_ul">
            <li>○ 배송오더 리스트</li>
            <!--  <li>■ 배송완료 카운터</li>-->
        </ul>
        </span>
    </div>
</section>    <div class="Mbody">
      <div class="Mtop">
        <meta charset="UTF-8">
<ul>
    <li class="Mtopmenu" id="menus">
    <img src="./img/menu.svg" class="menuico">
    </li>
    <li class="Mtoptitle">DELYVERY SYSTEM</li>
    <li class="Mtophelp">
    <img src="./img/help.svg" class="menuico">
    </li>
</ul>      
</div>         
      <div class="Mtab">
        <table>
            <thead>
                <tr class="Mtabhead">
                    <td style="width:25%;">고객명</td>
                    <td style="width:35%;">연락처</td>
                    <td style="width:20%;">주소</td>
                    <td style="width:20%;">배송</td>
                </tr>
            </thead>
            
            
            
           <form id="f1">
            <tbody>
            
            <c:if test="${empty result}">
		        <tr>
                    <td colspan="4" style="width: 100%;">배송내역이 없습니다.</td>
                </tr>
    		</c:if>
            
            
            
            <c:forEach var="list" items="${result}" varStatus="idx">
                <tr class="deliver_lists">
                    <td style="width:25%;">${list.acustomer}</td>
                    <td style="width:35%;"><a href="tel:${list.ahp}"><div class="Mtabok2">전화연결</div></a></td>
                    <td style="width:20%;"><button type="button" onclick="copyAddress('${list.addr}')" class="Mtabok">확인</button></td>
                    <td style="width:20%;">
                     <c:choose>
		                <c:when test="${list.mobileck == '대기'}">
		                    <button type="button" value="${list.mobileck}" class="Mtabok start_btn" onclick="ma('${list.stracking}','${list.mobileck}')">배송준비</button>
		                </c:when>
		                <c:when test="${list.mobileck == '배송중'}">
		                    <button type="button" value="${list.mobileck}" class="Mtabok gostarts" onclick="mb('${list.stracking}','${list.mobileck}')">배송중</button>
		                </c:when>
		                <c:when test="${list.mobileck == '촬영하기'}">
		                    <label value="${list.mobileck}" class="Mtabok3 color2 cks" for="cap${list.stracking}" style="margin: 0 auto; line-height: 35px;" onclick="mc('${list.stracking}','${list.mobileck}')">촬영하기
		                    <div style="display:none;"><input type="file" name="cam" id="cap${list.stracking}" accept="image/*" capture="camera"/></div>
		                    </label>
		                </c:when>
		                <c:when test="${list.mobileck == '완료하기'}">
		                    <button type="button" value="${list.mobileck}" class="Mtabok3 color1" onclick="md('${list.stracking}','${list.mobileck}')">완료하기</button>
		                </c:when>
           			</c:choose>
	               </td>
                </tr> 
               </c:forEach> 

                
             </tbody>
            </form>                                
        </table>
      </div>
      <div class="Maddbt1"><button type="button" class="Maddbt1_1" onclick="repage()">새로고침</button></div>
    </div>
</body>
</html>    