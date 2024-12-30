<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Header -->
<%@ include file="../header.jsp"%>
<!-- Nav -->
<%@ include file="../nav.jsp"%> 


<main role="main" style="height: 850px;">
  <div class="container">
    <div>
    <p class="sub_title font16_bold">거래처 수정</p>
    <div class="mb-3" style="position: relative;">
        <ul class="ul-1" style="margin-bottom: 5px;">
            <li class="num_font13_bold">거래처명</li>
            <li style="display: flex; flex-direction: row;">
                <input type="text" style="width: 200px; height: 40px;" class="form-control font12" placeholder="거래처명을 입력하세요">
                <button type="button" class="btn btn-secondary font12" style="width: 100px; height: 40px; margin-left:10px;">
                    중복체크
                </button>   
            </li>
            <li class="num_font13_bold">거래처 코드</li>
            <li style="display: flex; flex-direction: row;">
                <input type="text" style="width:120px; height: 40px;" class="form-control font12" readonly>&nbsp;&nbsp;※ 거래처 코드는 자동 생성 됩니다.
            </li>
        </ul> 
        <ul class="ul-1">
            <li class="num_font13_bold">대표자명</li>
            <li>
                <input type="text" style="width:150px; height: 40px;" class="form-control font12">
            </li>
            <li class="num_font13_bold">사업자 번호</li>
            <li style="display: flex; flex-direction: row;">
                <input type="text" style="width:150px; height: 40px;" class="form-control font12">&nbsp;&nbsp;※ "-" 포함
            </li>
        </ul> 
        <ul class="ul-1" style="margin-bottom: 5px;">
            <li class="num_font13_bold">업태</li>
            <li>
                <input type="text" style="width:200px; height: 40px;" class="form-control font12">
            </li>
            <li class="num_font13_bold">종목</li>
            <li>
                <input type="text" style="width:250px; height: 40px;" class="form-control font12">
            </li>
        </ul> 
        <ul class="ul-1">
            <li class="num_font13_bold">대표 번호</li>
            <li>
                <input type="text" style="width: 160px; height: 40px;" class="form-control font12" placeholder="대표 연락처를 입력하세요"> ※ "-" 포함
            </li>
            <li class="num_font13_bold">팩스 번호</li>
            <li style="display: flex; flex-direction: row;">
                <input type="text" style="width: 160px; height: 40px;" class="form-control font12" placeholder="팩스 번호를 입력하세요">&nbsp;&nbsp;※ "-" 포함
            </li>
        </ul> 
        <ul class="ul-1" style="margin-top: 5px;">
            <li class="num_font13_bold">주소찾기</li>
            <li style="width: 85%; display: flex; flex-direction: row;">
                <input type="text" style="width: 100px; height: 40px; margin-right: 5px;" maxlength="5" class="form-control font12" readonly>
                <button type="button" class="btn btn-secondary font12" style="width: 100px; height: 40px;">
                    주소찾기
                </button>
            </li>
            <li></li>
            <li></li>
        </ul> 
        <ul class="ul-1" style="margin-bottom: 5px;">
            <li class="num_font13_bold">도로명 주소</li>
            <li>
                <input type="text" style="height: 40px;" class="form-control font12" readonly>
            </li>
            <li class="num_font13_bold">상세주소</li>
            <li>
                <input type="text" style="height: 40px;" class="form-control font12" placeholder="상세주소를 입력하세요">
            </li>
        </ul> 
     </div>
      <div class="mb-3" style="text-align: right;">
      <button type="button" class="btn btn-danger font12" style="width: 100px; height: 40px; margin-right: 5px;">거래처 등록</button> 
      <button type="button" class="btn btn-dark font12" style="width: 100px; height: 40px;" onclick="location.href='./account.jsp'">취소하기</button> 
      </div>
    </div>
    </div>
  </div>
</main>







<!-- Footer -->
<%@ include file="../footer.jsp"%>