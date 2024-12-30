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
    background: white;
    box-shadow: 5px 5px 3px #ccc;
    border:1px solid #ccc;
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

<form id="f1">
	<input type="hidden" id="aidx" name="aidx">
</form>





  <div class="container">
    <div>
    <p class="sub_title font16_bold">배송현황 및 운송장 출력</p>
    <div class="mb-3" style="position: relative;">
        <ul class="ul-2">
            <li class="num_font13_bold">오더 일자별 검색</li>
            <li style="width: 85%; display: flex; flex-direction: row;">
                <input type="date" name="start" id="start" style="width: 150px; height: 40px;" class="form-control font12">&nbsp;-&nbsp; 
                <input type="date" id="end" id="end" style="width: 150px; height: 40px;" class="form-control font12">
                <button type="button" class="btn btn-primary font12" style="width: 70px; height: 40px; margin-left:10px; margin-right: 10px;" onclick="btn(1)">검색</button>   
            </li>
        </ul>
        
        
        
        <ul class="ul-2">
            <li class="num_font13_bold">배송기사별 현황</li>
            <li style="width: 85%; display: flex; flex-direction: row;">
                <select  id="dcode" name="dcode" style="width: 150px; height: 40px; margin-right: 5px;" class="form-control font12">
                    <option value="전체">전체</option>
                    <cr:forEach var="dsnm" items="${dsnm}">
                    	<option value="${dsnm.dcode}">${dsnm.deliveryname} (${dsnm.dspot})</option>
                    </cr:forEach>
                </select>
                <button type="button" class="btn btn-success font12" style="width: 100px; height: 40px; margin-left:10px; margin-right: 10px;" onclick="btn(2)">
               		검색
                </button>
                <font style="font-size: 12px; color: red;">&nbsp;&nbsp;※ 배송기사별로 할당된 오더를 확인 할 수 있습니다.</font>
            </li>
        </ul>  
   
        
        
        
        
        
        
        
        
        
        <ul class="ul-2">
            <li class="num_font13_bold">운송장</li>
            <li style="width: 85%; display: flex; flex-direction: row;">
                <button type="button" onclick="tracking()" class="btn btn-primary font12" style="width: 120px; height: 40px; margin-right: 10px;">운송장 생성</button><font style="font-size: 12px; color: red;">&nbsp;&nbsp;※ 체크된 오더에 한하여 운송장이 생성 됩니다.</font>
            </li>
        </ul>
        <ul class="ul-2">
            <li class="num_font13_bold">운송장 출력</li>
            <li style="width: 85%; display: flex; flex-direction: row;">
                <button type="button" onclick="qrmake()" class="btn btn-warning font12" style="width: 120px; height: 40px; margin-right: 10px;">운송장 출력</button><font style="font-size: 12px; color: red;">&nbsp;&nbsp;※ 운송장이 적용된 오더에 한하여 운송장이 출력 됩니다. (QR 생성)</font>
            </li>
        </ul>
     </div>
     <div class="mb-3">
        <table class="table font12">
            <thead>
              <tr align="center" style="line-height: 30px;">
                <th scope="col" style="width: 40px;">
                	<input type="checkbox" id="selectAll" onclick="toggleSelectAll()">
                </th>
                <th scope="col" style="width: 150px;">운송장번호</th>
                <th scope="col" style="width: 120px;">주문번호</th>
                <th scope="col" style="width: 200px;">상품명</th>
                <th scope="col" style="width: 100px;">상품코드</th>
                <th scope="col" style="width: 120px;">고객명</th>
                <th scope="col" style="width: 100px;">연락처</th>
                <th scope="col" style="width: 100px;">입력일자</th>
                <th scope="col" style="width: 100px;">기사명</th>
                <th scope="col" style="width: 100px;">QR출력</th>
                <th scope="col" style="width: 100px;">배송현황</th>
              </tr>
            </thead>
            <tbody style="background-color: #f1f1ef;">
            
            
            <!-- 리스트가 없는경우 -->
             <c:if test="${empty all}">
		        <tr>
		            <td colspan="11" height="80px" align="center" style="color: #777; font-size: 14px; ">등록된 배송현황 리스트가 없습니다.</td>
		        </tr>
    		</c:if>
            
            
            
               <c:forEach var="list" items="${all}" varStatus="idx"> 
                <tr align="center" style="line-height: 30px;">
                    <td><input type="checkbox" class="checkbox" aidx="${list.aidx}"></td>
                    <td>
                    	<c:choose>
			                <c:when test="${list.stracking == 'N'}">-</c:when>
			                <c:otherwise>${list.stracking}</c:otherwise>
			            </c:choose>
                    </td>
                    <td>${list.aordercode}</td>
                    <td>${list.aproduct}</td>
                    <td>${list.aproductcode}</td>
                    <td>${list.acustomer}</td>
                    <td>${list.ahp}</td>
                    <td><c:out value="${f:substring(list.date, 0, 10)}" /></td>
                    <td>${list.deliveryname}</td>
                    
                    <!-- 
                    <td>

                    	<c:choose>
			                <c:when test="${list.sqrimg == 'N'}">-</c:when>
			                <c:otherwise>
			                    <a href="" target="_blank" id="showImageBtn" >[QR보기]</a>
			                    <div id="imageWrapper" style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); max-width: 80%; max-height: 80%; z-index: 1000;">
						            <img id="views" src=".${list.sqrurl}${list.sqrimg}" style="width: 400px; height: 400px;">
						            <button id="closeBtn" style="position: absolute;  top: 0; right: 0; background: none; border: none; color: gray; font-size: 40px; cursor: pointer;">☒</button>
						        </div>
			                </c:otherwise>
			            </c:choose> 
                    </td>
                     -->
        <td>
    <c:choose>
        <c:when test="${list.sqrimg == 'N'}">-</c:when>
        <c:otherwise>
            <!-- showImageBtn의 id를 동적으로 설정 -->
            <a href="javascript:void(0);" id="showImageBtn_${list.aidx}">[QR보기]</a>
            
            <!-- 이미지와 닫기 버튼을 감싸는 div에도 고유한 id를 설정 -->
            <div id="imageWrapper_${list.aidx}" style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); max-width: 80%; max-height: 80%; z-index: 1000;">
                <img id="views_${list.aidx}" src=".${list.sqrurl}${list.sqrimg}" style="width: 400px; height: 400px;">
                <button id="closeBtn_${list.aidx}" style="position: absolute; top: 0; right: 0; background: none; border: none; color: gray; font-size: 40px; cursor: pointer;">☒</button>
            </div>
        </c:otherwise>
    </c:choose>
</td>

	                    
                    
                    
                    
                    <td>${list.shipstate}</td>
                  </tr>
                </c:forEach>
            </tbody>
          </table>
     </div>
     
     
      <div class="mb-3">
            <ul class="pageing">
            <cr:set var="pages" value="${total%15 == 0? total/15 : total/15 + (1-((total/15)%1))}"/>
            <cr:forEach begin="1" end="${pages}" var="i">
                <li style="cursor: pointer;" onclick="go_page(${i})">${i}</li>
            </cr:forEach>
            </ul>
        </div>
      
      
      
    </div>
  </div>
</main>




<script src="../js/deliveryShip.js?v=<%=sf.format(today)%>"></script>
<!-- Footer -->
<%@ include file="../footer.jsp"%>
