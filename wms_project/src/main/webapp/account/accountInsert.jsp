<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Header -->
<%@ include file="../header.jsp"%>
<!-- Nav -->
<%@ include file="../nav.jsp"%> 


<main role="main" style="height: 850px;">

<form id="f1">
  <div class="container">
    <div>
    <p class="sub_title font16_bold">거래처 등록</p>
    <div class="mb-3" style="position: relative;">
        <ul class="ul-1" style="margin-bottom: 5px;">
            <li class="num_font13_bold">거래처명</li>
            <li style="display: flex; flex-direction: row;">
                <input type="text" name="acompany" id="acompany" style="width: 200px; height: 40px;" class="form-control font12" placeholder="거래처명을 입력하세요" onclick="re_company(this)">
                <button type="button" class="btn btn-secondary font12" style="width: 100px; height: 40px; margin-left:10px;" onclick="company_check()">
                    중복체크
                </button>   
            </li>
            <li class="num_font13_bold">거래처 코드</li>
            <li style="display: flex; flex-direction: row;">
                <input type="text" name="acode" id="acode" value="" style="width:120px; height: 40px;" class="form-control font12" readonly>&nbsp;&nbsp;※ 거래처 코드는 자동 생성 됩니다.
            </li>
        </ul> 
        <ul class="ul-1">
            <li class="num_font13_bold">대표자명</li>
            <li>
                <input type="text" name="aname" id="aname" style="width:150px; height: 40px;" class="form-control font12">
            </li>
            <li class="num_font13_bold">사업자 번호</li>
            <li style="display: flex; flex-direction: row;">
                <input type="text" name="anum" id="anum" style="width:150px; height: 40px;" class="form-control font12" placeholder="예) 000-00-00000">&nbsp;&nbsp;※ "-" 포함
            </li>
        </ul> 
        <ul class="ul-1" style="margin-bottom: 5px;">
            <li class="num_font13_bold">업태</li>
            <li>
                <input type="text" name="aindustry" id="aindustry" style="width:200px; height: 40px;" class="form-control font12" placeholder="예) 방송/엔터">
            </li>
            <li class="num_font13_bold">종목</li>
            <li>
                <input type="text" name="atype" id="atype" style="width:250px; height: 40px;" class="form-control font12" placeholder="예) 전자상거래">
            </li>
        </ul> 
        <ul class="ul-1">
            <li class="num_font13_bold">대표 번호</li>
            <li>
                <input type="text" name="ahp" id="ahp" style="width: 160px; height: 40px;" class="form-control font12" placeholder="예) 02-0000-0000"> ※ "-" 포함
            </li>
            <li class="num_font13_bold">팩스 번호</li>
            <li style="display: flex; flex-direction: row;">
                <input type="text" name="afax" id="afax" style="width: 160px; height: 40px;" class="form-control font12" placeholder="02-0000-0000">&nbsp;&nbsp;※ "-" 포함
            </li>
        </ul> 
        <ul class="ul-1" style="margin-top: 5px;">
            <li class="num_font13_bold">주소찾기</li>
            <li style="width: 85%; display: flex; flex-direction: row;">
                <input type="text" name="apost"  id="apost" value="" style="width: 100px; height: 40px; margin-right: 5px;" maxlength="5" class="form-control font12" readonly>
                <button type="button" onclick="sample2_execDaumPostcode()" class="btn btn-secondary font12" style="width: 100px; height: 40px;">
                    주소찾기
                </button>
            </li>
            <li></li>
            <li></li>
        </ul> 
        
        
   <!-- 주소찾기 창 띄우는 공간 -->
					<div id="layer" style="display:none; position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
						<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
					</div>
        
        <ul class="ul-1" style="margin-bottom: 5px;">
            <li class="num_font13_bold">도로명 주소</li>
            <li>
                <input type="text" name="aroad" id="aroad" value=""  style="height: 40px;" class="form-control font12" readonly>
            </li>
            <li class="num_font13_bold">상세주소</li>
            <li>
                <input type="text" name="addr" id="addr" value=""  style="height: 40px;" class="form-control font12" placeholder="상세주소를 입력하세요">
            </li>
        </ul> 
     </div>
      <div class="mb-3" style="text-align: right;">
      <button type="button"  class="btn btn-danger font12" style="width: 100px; height: 40px; margin-right: 5px;" onclick="account_check()">거래처 등록</button> 
      <button type="button" class="btn btn-dark font12" style="width: 100px; height: 40px;" onclick="location.href='./accountMain.do'">취소하기</button> 
      </div>
    </div>
    </div>
  </div>
 </form> 
</main>

<script src="../js/accountInsert.js?v=<%=sf.format(today)%>"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!-- Footer -->
<%@ include file="../footer.jsp"%>