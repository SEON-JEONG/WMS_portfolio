<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %>


<!-- Header -->
<%@ include file="../header.jsp"%>
<!-- Nav -->
<%@ include file="../nav.jsp"%>   



 
<main role="main" style="height: 850px;">
  <div class="container">
    <div>
    <p class="sub_title font16_bold">창고 등록</p>
    <form id="frm" method="post" onsubmit="return insert12();">
    <input type="hidden" name="suse" id="suse" value="">
    <input type="hidden" name="mid" value="${sessionScope.id}">
    <input type="hidden" name="sdeleted" value="1">
    
    <div class="mb-3" style="position: relative;">
        <ul class="ul-2">
            <li class="num_font13_bold">창고코드</li>
            <li style="display: flex; flex-direction: row;">
                <input type="text" id="scode" name="scode" value="${scode}" style="width: 150px; height: 40px;" class="form-control font12" maxlength="5" readonly> <font style="font-size: 12px; color: red;">&nbsp;&nbsp;※ 창고코드는 자동생성</font>
            </li>
            <li class="num_font13_bold">창고명</li>
            <li style="display: flex; flex-direction: row;">
                <input type="text" name="sname" style="width: 250px; height: 40px;" class="form-control font12" maxlength="5" placeholder="창고명을 입력해 주세요">
            </li>
        </ul> 
     </div>
     <div>
        <div class="mb-3" style="position: relative;">
        <ul class="ul-2" style="margin-bottom: 5px;">
            <li class="num_font13_bold">지점위치</li>
            <li style="width:85%; display: flex; flex-direction: row;">
                <input type="text" name="sspot" value="${sessionScope.mspot}" style="width: 180px; height: 40px;" class="form-control font12" readonly>
            </li>
        </ul>
        </div> 
        <div class="mb-3" style="position: relative;">
            <ul class="ul-1" style="margin-top: 5px;">
                <li class="num_font13_bold">주소찾기</li>
                <li style="width: 85%; display: flex; flex-direction: row;">
                    <input type="text" id="spost" name="spost" style="width: 100px; height: 40px; margin-right: 5px;" maxlength="5" class="form-control font12" readonly>
                    <button type="button" onclick="sample3_execDaumPostcode()" class="btn btn-secondary font12" style="width: 100px; height: 40px;">
                        주소찾기
                    </button>
                </li>
                <li></li>
                <li></li>
            </ul> 
            <!-- 주소찾기 창 띄우는 공간 -->
					<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 0;position:relative">
				<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
					</div>
            <ul class="ul-1" style="margin-bottom: 5px;">
                <li class="num_font13_bold">도로명 주소</li>
                <li>
                    <input type="text" id="saddress1" name="saddress1" style="height: 40px;" class="form-control font12" readonly>
                </li>
                <li class="num_font13_bold">상세주소</li>
                <li>
                    <input type="text" id="saddress2" name="saddress2" style="height: 40px;" class="form-control font12" placeholder="상세주소를 입력하세요">
                </li>
            </ul> 
            <ul class="ul-1" style="margin-bottom: 5px;">
                <li class="num_font13_bold">담당자명</li>
                <li>
                    <input type="text" name="smname" style="height: 40px;" class="form-control font12" value="${sessionScope.name}">
                </li>
                <li class="num_font13_bold">담당자 연락처</li>
                <li>
                    <input type="text" name="smhp" style="height: 40px;" class="form-control font12" value="${sessionScope.mhp}">
                </li>
            </ul>
            <ul class="ul-1" style="margin-bottom: 5px;">
                <li class="num_font13_bold">사용 유/무</li>
                <li>
                    <label style="margin-right: 40px;">
                        <input type="radio" id="use" name="suse" value="1" style="vertical-align:-2px; width: 15px; height:15px;" checked> 사용중
                    </label>
                    <label>
                        <input type="radio" id="not" name="suse" value="0" style="vertical-align:-2px; width: 15px; height:15px;"> 미사용중
                    </label>
                </li>
                <li class="num_font13_bold"></li>
                <li>
                    
                </li>
            </ul>
        </div>
      <div class="mb-3" style="text-align: right;">
      <button type="button" class="btn btn-danger font12" style="width: 100px; height: 40px; margin-right: 5px;" onclick="insert12()">등록하기</button> 
      <button type="button" class="btn btn-dark font12" style="width: 100px; height: 40px;" onclick="back1()">취소하기</button> 
      </div>
      </form>
    </div>
  </div>
</main>
<!-- Footer -->
<%@ include file="../footer.jsp"%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="../js/storage.js?v="<%= sf.format(today) %>></script>