
<%
	HttpSession sess = request.getSession(false);
	
if (session == null || 
	session.getAttribute("id") == null || 
	session.getAttribute("name") == null || 
	session.getAttribute("email") == null || 
	session.getAttribute("mpart") == null || 
	session.getAttribute("mhp") == null || 
	session.getAttribute("mspot") == null) {
	
%>
	<script>
	alert('비정상적인 접근입니다. 로그인 페이지로 이동합니다.');
    location.href = '/member/wmsLogin.jsp';
	</script>
<%
	return; 
	}

	String id = (String)sess.getAttribute("id");
	String name = (String)sess.getAttribute("name");
	String email = (String)sess.getAttribute("email");
	String mpart = (String)sess.getAttribute("mpart");
	String mspot = (String)sess.getAttribute("mspot");
	String mhp = (String)sess.getAttribute("mhp");
	
	//out.print("　　　--세션값 참고하세요--　　　");
	//out.print("id("+ sess.getAttribute("id")+ ")　　");	//수원지점
	//out.print("name("+sess.getAttribute("name")+ ")　　");	// 이름
	//out.print("email("+sess.getAttribute("email")+ ")　　");	//이메일
	//out.print("mpart("+sess.getAttribute("mpart")+ ")　　"); // 본사
	//out.print("mspot("+sess.getAttribute("mspot")+ ")　　");	// 지점 이름
	//out.print("전화번호 : mhp("+sess.getAttribute("mhp")+ ")　　");	// 전화번호
	//out.print("　>> 앞에있는값이 세션 id값입니다!!");
%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="cr" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
  <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
  <a class="navbar-brand" href="/member/wmsMain.do">ADMINISTRATOR</a>

  <div class="collapse navbar-collapse" id="navbarsExampleDefault">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item dropdown" style="width:100px;">
        <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" aria-expanded="false">입고관리</a>
        <div class="dropdown-menu">
          <a class="dropdown-item" href="../storage/storageInstore.do">상품입고</a>
          <a class="dropdown-item" href="../storage/storageList.do">재고 및 창고이동</a>
          <a class="dropdown-item" href="../storage/storagePalette.do">재고 팔레트 이동</a>
        </div>
      </li>
      <li class="nav-item dropdown" style="width:100px;">
        <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" aria-expanded="false">오더관리</a>
        <div class="dropdown-menu">
          <a class="dropdown-item" href="/order/orderMain.do">오더등록 및 현황</a>
          <a class="dropdown-item" href="/shipment/shipmentMain.do">배송선택(본사,지점)</a>
        </div>
      </li>
      <li class="nav-item dropdown" style="width:160px;">
        <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" aria-expanded="false">창고 및 기사배정</a>
        <div class="dropdown-menu">
          <a class="dropdown-item" href="../storage/storageMain.do">창고리스트</a>
          <a class="dropdown-item" href="../storage/storageInsert.do">창고등록</a>
          <a class="dropdown-item" href="../storeDelivery/storeDelivery.do">배송기사 배정</a>
        </div>
      </li>
      <li class="nav-item dropdown" style="width:110px;">
        <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" aria-expanded="false">배송 관리</a>
        <div class="dropdown-menu">
          <a class="dropdown-item" href="../deliveryShip/deliveryShip.do">배송현황 및 운송장 출력</a>
        </div>
      </li>
      <li class="nav-item dropdown" style="width:140px;">
        <a class="nav-link dropdown-toggle" href="" data-toggle="dropdown" aria-expanded="false">배송 기사관리</a>
        <div class="dropdown-menu">
          <a class="dropdown-item" href="../deliveryList/deliveryMain.do">배송기사 리스트</a>
          <a class="dropdown-item" href="../deliveryState/deliveryState.do">배송 기사별 배송현황</a>
        </div>
      </li>
      <li class="nav-item dropdown" style="width:100px;">
        <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" aria-expanded="false">환경설정</a>
        <div class="dropdown-menu">
          <a class="dropdown-item" href="../config/configMain.do">관리자 현황</a>
          <a class="dropdown-item" href="../office/officeMain.do">지점 현황</a>
          <a class="dropdown-item" href="../account/accountMain.do">거래처 현황</a>
          <a class="dropdown-item" href="../palette/paletteMain.do">팔레트 현황</a>
        </div>
      </li>
      
   		<!-- QR
       <li class="nav-item dropdown" >
        <a class="nav-link dropdown-toggle" href="" target="_blank" id="sss"  aria-expanded="false">모바일 페이지</a>
          <a href="" target="_blank" id="sss"></a>
          <div id="iii" style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); max-width: 80%; max-height: 80%; z-index: 1000;">
            <img id="views" src="" style="width: 400px; height: 400px;">
            <button id="ccc" style="position: absolute;  top: 0; right: 0; background: none; border: none; color: gray; font-size: 40px; cursor: pointer;">☒</button>
       	 </div>
      </li>
       -->
       
       
       <!-- 
       <li class="nav-item dropdown" style="width:100px;">
        <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" aria-expanded="false">모바일 페이지</a>
        <div class="dropdown-menu">
          <a class="dropdown-item" href="../deliveryMobile/mobileLogin.jsp">모바일 페이지 바로가기</a>
        </div>
      </li>
       -->
       

	<li class="nav-item dropdown" style="width:100px;">
	    <a class="nav-link dropdown-toggle" href="#" data-toggle="modal" data-target="#mobileModal">모바일 페이지</a>
	    <div class="dropdown-menu">
	        <a href="javascript:void(0);" class="dropdown-item" data-toggle="modal" data-target="#mobileModal">모바일 페이지 바로가기</a>
	    </div>
	</li>

	


      
    </ul>
    
     <!-- <span style="color: white; margin-right: 5px;">[<%=mpart%>]&nbsp;&nbsp;<a href="#"><%=name%> (<%=id%>)</a> 님 환영합니다.</span> --> 
     	<cr:if test="${sessionScope.mpart == '본사'}">
    		<span style="color: white; margin-right: 5px;">[${mpart}]&nbsp;&nbsp;<a href="../config/configMain.do">${name} (${id})</a> 님 환영합니다.</span>
		</cr:if>

		<cr:if test="${sessionScope.mpart == '지점'}">
    		<span style="color: white; margin-right: 5px;">[${mspot}]&nbsp;&nbsp;<a href="../config/configMain.do">${name} (${id})</a> 님 환영합니다.</span>
		</cr:if>
	
	
	
      <button class="btn btn-outline-success my-2 my-sm-0" type="button" onclick="location.href='/member/logout.do'">로그아웃</button>
  </div>
</nav>




	<div class="modal fade" id="mobileModal" tabindex="-1" role="dialog" aria-labelledby="mobileModalLabel" aria-hidden="true">
	    <div class="modal-dialog modal-s" role="document">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title" id="mobileModalLabel"> 배송기사 모바일 전용 페이지</h5>
	                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	                    <span aria-hidden="true">&times;</span>
	                </button>
	            </div>
	            <div class="modal-body">
	                <!-- 모바일 페이지를 iframe을 통해 로드 -->
	                <iframe src="../deliveryMobile/mobileLogin.jsp" style="width: 100%; height: 600px; border: none;"></iframe>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	            </div>
	        </div>
	    </div>
	</div>
