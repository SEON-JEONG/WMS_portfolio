<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- Header -->
<%@ include file="../header.jsp"%>
<!-- Nav -->
<%@ include file="../nav.jsp"%> 

<style>
/* 이미지와 X 버튼을 감싸는 div */

#imageWrapper {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    z-index: 1000;
     box-shadow: 5px 5px 3px #ccc;
}


#closeBtn {
    position: absolute;
    top: 10px;
    right: 10px;
    background: none;
    border: none;
    color: gray;
    font-size: 30px;
    cursor: pointer;
    
}
</style>



<main role="main" style="height: auto;">
<form id="f1" enctype="multipart/form-data">
  <div class="container">
    <div>
    <p class="sub_title font16_bold">배송기사 수정</p>
    <div class="mb-3" style="position: relative;">
    <c:set var="delivery" value="${ddto}" />
        <ul class="ul-2">
            <li class="num_font13_bold">사원번호</li>
            <li style=" width:85%; display: flex; flex-direction: row;">
                <input type="text" value="${delivery.dcode}" style="width: 200px; height: 40px;" class="form-control font12" readonly><font style="font-size: 12px; color: red;">&nbsp;&nbsp;※ 수정불가 합니다.</font>
            </li>
        </ul> 
     </div>
     <div>
        <div class="mb-3" style="position: relative;">
        <ul class="ul-2" style="margin-bottom: 5px;">
            <li class="num_font13_bold">이름</li>
            <li>
                <input type="text" id="dname" name="dname" value="${delivery.dname}" style="width:150px; height: 40px;" class="form-control font12" placeholder="이름을 입력해 주세요">
            </li>
            <li class="num_font13_bold">지역거점 구분</li>
            <li style="display: flex; flex-direction: row;">
                <input type="text" value="${delivery.dspot}" style="width: 200px; height: 40px;" class="form-control font12" readonly>
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
                <input type="password" id="dpassCk" name="dpassCk" style="width: 200px; height: 40px;" class="form-control font12" placeholder="동일한 패스워드를 입력해 주세요">
            </li>
        </ul> 
        </div>
        <div class="mb-3" style="position: relative;">
            <ul class="ul-1">
                <li class="num_font13_bold">이메일</li>
                <li class="font14">
                    <input type="text" id="demail" name="demail" value="${delivery.demail}" style="width: 300px; height: 40px;" class="form-control font12" placeholder="이메일을 입력하세요">
                </li>
                <li class="num_font13_bold">주민번호</li>
                <li style="display: flex; flex-direction: row;">
               
                <input type="text" value="${delivery.didnum != null ? delivery.didnum.substring(0, 6) : ''}" style="width: 100px; height: 40px;" class="form-control font12" maxlength="6" readonly>&nbsp;-&nbsp; 
                <input type="text" value="${delivery.didnum != null && delivery.didnum.length() > 0 ? delivery.didnum.substring(delivery.didnum.length() - 1) : ''}"  style="width: 40px; height: 40px;" class="form-control font12" maxlength="1" readonly>********
                </li>
            </ul> 
            </div>
            <div class="mb-3" style="position: relative;">
                <ul class="ul-1">
                    <li class="num_font13_bold">연락처</li>
                    <li class="font14">
                        <input type="text" id="dhp" name="dhp" value="${delivery.dhp}" style="width: 200px; height: 40px;" class="form-control font12" placeholder="- 없이 숫자만 입력" maxlength="11">
                    </li>
                    
                
                    <li class="num_font13_bold">증명사진</li>
					<li style="display: flex; flex-direction: row;">



				    <span style="display: block;">				    
					<!-- 
					<button class="btn btn-primary font20" id="showImageBtn" style="font-size: 16px;" type="button">
					    <c:choose>
					        <c:when test="${delivery.dimgnm == 'N'}">사진없음</c:when>
					        <c:otherwise>증명사진 확인</c:otherwise>
					    </c:choose>
					</button>
			 		-->
			 
					 <button class="btn btn-primary font20" 
					        id="showImageBtn" 
					        style="font-size: 16px;" 
					        type="button"
					        <c:choose>
					            <c:when test="${delivery.dimgnm == 'N'}">disabled</c:when>
					        </c:choose>>
					    <c:choose>
					        <c:when test="${delivery.dimgnm == 'N'}">사진없음</c:when>
					        <c:otherwise>증명사진 확인</c:otherwise>
					    </c:choose>
					</button>
			 
			 
			 
			 
			 

			        <div id="imageWrapper" style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); max-width: 80%; max-height: 80%; z-index: 1000;">
			            <img id="views" src=".${delivery.dimgurl}${delivery.dimgrenm}" style="width: 400px; height: 500px;">
			            <button id="closeBtn" style="position: absolute;  top: 0; right: 0; background: none; border: none; color: gray; font-size: 40px; cursor: pointer;">☒</button>
			        </div>
			        
			        <button type="button" class="btn btn-secondary font12" style="width: 70px; font-size:15px; height: 40px; margin-left:10px;" id="deleteBtn">
					    <c:choose>
					        <c:when test="${delivery.dimgnm == 'N'}">첨부</c:when>
					        <c:otherwise>삭제</c:otherwise>
					    </c:choose>
					</button>

				    </span>
				    
				    <input type="file" value="${delivery.dimgnm}" id="dimgnm" name="dimgnmf" style="width:300px; height: 40px; display: none;" class="form-control font12" >

	
				</li>
                </ul> 
                </div>
      <div class="mb-3" style="text-align: right;">
      <button type="button" class="btn btn-danger font12" style="width: 100px; height: 40px; margin-right: 5px;" onclick="deliverySubmit(${delivery.didx})">수정하기</button> 
      <button type="button" class="btn btn-dark font12" style="width: 100px; height: 40px;" onclick="deliveryMain()">취소하기</button> 
      </div>
    </div>
  </div>
  </form>
</main>


<script src="../js/deliveryModify.js?v=<%=sf.format(today)%>"></script>
<!-- Footer -->
<%@ include file="../footer.jsp"%>