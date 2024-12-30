<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="cr" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- Header -->
<cr:import url="../header.jsp"/>
<!-- Nav -->
<cr:import url="../nav.jsp"/>

<main role="main" style="height: 850px;">
	<div class="container">
		<div>
    		<p class="sub_title font16_bold">지점 등록</p>
    		<form id="frm" method="post">
	    		<div class="mb-3" style="position: relative;">
	        	<ul class="ul-2">
	            	<li class="num_font13_bold">지점명</li>
	            	<li style="width: 85%; display: flex; flex-direction: row;">
	                	<input type="text" name="officename" style="width: 200px; height: 40px;" class="form-control font12" placeholder="지점명을 입력하세요">
	                	<button type="button" onclick="officename_validate()" class="btn btn-secondary font12" style="width: 100px; height: 40px; margin-left:10px;">
							중복체크
		                </button>   
		            </li>
				</ul> 
				</div>
				<div class="mb-3" style="position: relative;">
					<ul class="ul-1">
					    <li class="num_font13_bold">지점 담당자</li>
					    <li style="width: 85%; display: flex; flex-direction: row;">
					        <input type="text" name="mname" id="mname" value="" style="width: 160px; height: 40px; margin-right: 5px;" class="form-control font12" placeholder="지점 담당자 선택" readonly>
					        <button type="button" onclick="open_poplist()" class="btn btn-secondary font12" style="width: 100px; height: 40px;">아이디 찾기</button>&nbsp;&nbsp;<font style="font-size: 12px; color: red;">※ 해당 지점 담당자 선택시 추후 변경이 가능 합니다.</font>
					    </li>
					    <li></li>
					    <li></li>
					</ul> 
					<ul class="ul-1" style="margin-bottom: 5px;">
					    <li class="num_font13_bold">담당자 연락처</li>
					    <li>
					        <input type="text" name="mhp" id="mhp" value="" style="height: 40px;" class="form-control font12" readonly>
					    </li>
					    <li class="num_font13_bold">담당자 이메일</li>
					    <li>
					        <input type="text" name="memail" id="memail" value="" style="height: 40px;" class="form-control font12" readonly>
					    </li>
					</ul> 
					<ul class="ul-1">
					    <li class="num_font13_bold">대표 연락처</li>
					    <li>
					        <input type="text" name="otel" style="width: 160px; height: 40px;" class="form-control font12" placeholder="대표 연락처를 입력하세요">
					    </li>
					    <li class="num_font13_bold"></li>
					    <li></li>
					</ul> 
					<ul class="ul-1" style="margin-top: 5px;">
					    <li class="num_font13_bold">주소찾기</li>
					    <li style="width: 85%; display: flex; flex-direction: row;">
					        <input type="text" id="opost" name="opost" style="width: 100px; height: 40px; margin-right: 5px;" maxlength="5" class="form-control font12" readonly>
					        <button type="button" onclick="sample2_execDaumPostcode()" class="btn btn-secondary font12" style="width: 100px; height: 40px;">
					            주소찾기
					        </button>
					    </li>
					    <li></li>
					    <li></li>
					</ul>
					<!-- 주소찾기 창 띄우는 공간 -->
					<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
						<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
					</div>
					<ul class="ul-1" style="margin-bottom: 5px;">
					    <li class="num_font13_bold">도로명 주소</li>
					    <li>
					        <input type="text" id="oroad" name="oroad" style="height: 40px;" class="form-control font12" readonly>
					    </li>
					    <li class="num_font13_bold">상세주소</li>
					    <li>
					        <input type="text" id="oaddress" name="oaddress" style="height: 40px;" class="form-control font12" placeholder="상세주소를 입력하세요">
					    </li>
					</ul> 
				</div>
				<div class="mb-3" style="text-align: right;">
					<button type="button" onclick="complete_insert()" class="btn btn-danger font12" style="width: 100px; height: 40px; margin-right: 5px;">등록하기</button>
					<button type="button" onclick="cancel_insert()" class="btn btn-dark font12" style="width: 100px; height: 40px;">취소하기</button>
				</div>
			</form>
		</div>
	</div>
</main>

<!-- 카카오 우편번호 스크립트 추가 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!-- 스크립트 자동 업데이트 -->
<script src="../js/office.js?=${sf.format(today)}"></script>
<!-- Footer -->
<cr:import url="../footer.jsp"/>