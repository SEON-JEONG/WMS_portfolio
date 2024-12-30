<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- Header -->
<%@ include file="../header.jsp"%>
<!-- Nav -->
<%@ include file="../nav.jsp"%> 


<main role="main" style="height: auto;">
<form id="f1" enctype="multipart/form-data">
  <div class="container">
    <div>
    <p class="sub_title font16_bold">배송기사 등록</p>
    <div class="mb-3" style="position: relative;">
        <ul class="ul-2">
            <li class="num_font13_bold">사원번호</li>
            <li style=" width:85%; display: flex; flex-direction: row;">
                <input type="text" id="dcode" name="dcode" value="" style="width: 200px; height: 40px;" class="form-control font12" placeholder="사원번호를 입력해 주세요" readonly>
                <button type="button" class="btn btn-secondary font12" style="width: 120px; height: 40px; margin-left:10px;" onclick="codeCk()">
                    사원번호 생성
                </button>
                <font style="font-size: 12px; color: red;">&nbsp;&nbsp;※ 사원번호는 자동생성 됩니다.</font>  
            </li>
        </ul> 
     </div>
     <div>
        <div class="mb-3" style="position: relative;">
        <ul class="ul-2" style="margin-bottom: 5px;">
            <li class="num_font13_bold">이름</li>
            <li>
                <input type="text" id="dname" name="dname" style="width:150px; height: 40px;" class="form-control font12" placeholder="이름을 입력해 주세요">
            </li>
            <li class="num_font13_bold">지역거점 구분</li>
            <li style="display: flex; flex-direction: row;">
                <input type="text" id="dspot" name="dspot" value="<%= mspot %>" style="width: 200px; height: 40px;" class="form-control font12" readonly>
            </li>
        </ul>
        </div> 
        <div class="mb-3" style="position: relative;">
        <ul class="ul-1">
            <li class="num_font13_bold">패스워드</li>
            <li class="font14">
                <input type="password" id="dpass" name="dpass" style="width: 200px; height: 40px;" class="form-control font12" placeholder="패스워드를 입력해주세요">
            </li>
            <li class="num_font13_bold">패스워드 확인</li>
            <li>
                <input type="password" id="dpassCk" name="dpassCk" style="width: 200px; height: 40px;" class="form-control font12" placeholder="동일한 패스워드를 입력해주세요">
            </li>
        </ul> 
        </div>
        <div class="mb-3" style="position: relative;">
            <ul class="ul-1">
                <li class="num_font13_bold">이메일</li>
                <li class="font14">
                    <input type="text" id="demail" name="demail" style="width: 300px; height: 40px;" class="form-control font12" placeholder="이메일을 입력하세요">
                </li>
                <li class="num_font13_bold">주민번호</li>
                <li style="display: flex; flex-direction: row;">
                    <!-- 두개 input값 아래에 통합 -->
                    <input type="hidden" name="didnum" id="didnum" value="">
                    <input type="text" id="id1" value="" style="width: 100px; height: 40px;" class="form-control font12" maxlength="6" placeholder="앞자리 6자리">&nbsp;-&nbsp; 
                    <input type="text" id="id2" value="" style="width: 40px; height: 40px;" class="form-control font12" maxlength="1">********
                </li>
            </ul> 
            </div>
            <div class="mb-3" style="position: relative;">
                <ul class="ul-1">
                    <li class="num_font13_bold">연락처</li>
                    <li class="font14">
                        <input type="text" id="dhp" name="dhp" style="width: 200px; height: 40px;" class="form-control font12" placeholder=" - 없이 숫자만 입력" maxlength="11">
                    </li>
                    <li class="num_font13_bold">증명사진</li>
                    <li style="display: flex; flex-direction: row;">
                        <input type="file" id="dimgnm" name="dimgnmf" style="width:300px; height: 40px;" class="form-control font12">
                    </li>
                </ul> 
                </div>
      <div class="mb-3" style="text-align: right;">
      <button type="button" class="btn btn-danger font12" style="width: 100px; height: 40px; margin-right: 5px;" onclick="deliverySubmit()">등록하기</button> 
      <button type="button" class="btn btn-dark font12" style="width: 100px; height: 40px;" onclick="deliveryMain()">취소하기</button> 
      </div>
    </div>
  </div>
  </form>
</main>


<script src="../js/deliveryInsert.js?v=<%=sf.format(today)%>"></script>
<!-- Footer -->
<%@ include file="../footer.jsp"%>
