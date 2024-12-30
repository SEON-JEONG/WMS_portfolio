<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<!-- Header -->
<%@ include file="../header.jsp"%>
<!-- Nav -->
<%@ include file="../nav.jsp"%>   



 
<main role="main" style="height: auto;">
  <div class="container">
    <div>
    <p class="sub_title font16_bold">배송기사 배정</p>
    <div class="mb-3" style="position: relative;">
        <ul class="ul-2">
            <li class="num_font13_bold">오더 일자별 검색</li>
            <li style="width: 85%; display: flex; flex-direction: row;">
                <input type="date" id="startDate" style="width: 150px; height: 40px;" class="form-control font12">&nbsp;-&nbsp; 
                <input type="date" id="endDate" style="width: 150px; height: 40px;" class="form-control font12">
                <button type="button" class="btn btn-primary font12" style="width: 70px; height: 40px; margin-left:10px; margin-right: 10px;" onclick="searchDate()">검색</button>   
            </li>
        </ul>
        <ul class="ul-2">
            <li class="num_font13_bold">기사선택</li>
            <li style="width: 85%; display: flex; flex-direction: row;">
                <select id="selectmen" style="width: 200px; height: 40px; margin-right: 5px;" class="form-control font12">
                    <c:forEach var="dlist" items="${dlist}">
                    	<option value="${dlist.dcode},${dlist.dname},${dlist.dspot}" >${dlist.dname}(${dlist.dspot})</option>
                    </c:forEach>                   
                </select>
                <button type="button" class="btn btn-success font12" style="width: 100px; height: 40px; margin-left:10px; margin-right: 10px;" onclick="useDeliverymen()">기사 선택 완료</button><font style="font-size: 12px; color: red;">&nbsp;&nbsp;※ 근무하고 있는 배송기사만 출력 됩니다.</font>
            </li>
        </ul>  
        <ul class="ul-2">
            <li class="num_font13_bold">기사배정 여부</li>
            <li style="width: 85%; display: flex; flex-direction: row;">
                <label class="font12">
                <input type="radio" name="assignment" class="toggle-radio" value="Y" style="vertical-align: -2px;">&nbsp;기사배정 완료 오더
                </label>&nbsp;&nbsp;&nbsp;&nbsp;
                <label class="font12">
                <input type="radio" name="assignment" class="toggle-radio" value="N" style="vertical-align: -2px;">&nbsp; 기사배정 미지정 오더
                </label>
                <button type="button" class="btn btn-primary font12" style="width: 70px; height: 40px; margin-left:10px; margin-right: 10px;" 
                onclick="searchDate(document.querySelector('input[name=assignment]:checked')?.value)">검색</button><font style="font-size: 12px; color: red;">&nbsp;&nbsp;※ 기사배정 완료 오더와 미지정 오더 별로 확인 할 수 있습니다.</font>
            </li>
        </ul>
     </div>
     <div class="mb-3">
        <table class="table font12">
            <thead>
              <tr align="center" style="line-height: 30px;">
                <th scope="col" style="width: 40px;"><input type="checkbox" id="toggleAll" onclick="toggleAll(this)"></th>
                <th scope="col" style="width: 150px;">주문번호</th>
                <th scope="col" style="width: 150px;">상품명</th>
                <th scope="col" style="width: 100px;">상품코드</th>
                <th scope="col" style="width: 100px;">고객명</th>
                <th scope="col" style="width: 120px;">연락처</th>
                <th scope="col" style="width: 300px;">주소</th>
                <th scope="col" style="width: 100px;">입력일자</th>
                <th scope="col" style="width: 70px;">기사배정</th>
                <th scope="col" style="width: 70px;">삭제</th>
              </tr>
            </thead>
            <tbody style="background-color: #f1f1ef;">
            <c:forEach var="list" items="${list}">
                <tr align="center" style="line-height: 30px;">
                    <td><input type="checkbox" name="checkbox" value="${list.aidx}" class="product-checkbox"></td>
                    <td>${list.aordercode}</td>
                    <td>${list.aproduct}</td>
                    <td>${list.aproductcode}</td>
                    <td>${list.acustomer}</td>
                    <td>${list.ahp}</td>
                    <td align="left">${list.addr}</td>
                   	<td>${list.date.substring(0, 10)}</td>
                    <td>${list.adeliveryck}</td>
                    <td>
                        <button type="button" class="btn btn-danger font12" style="width: 60px; height: 30px;" onclick="DeleteDeliverymen('${list.aidx}')">삭제</button> 
                    </td>
                  </tr>
           </c:forEach>
            </tbody>
          </table>
     </div>
     <div class="mb-3">
     <ul class="pageing">
        <c:set var="pages" value="${total%15 == 0? total/15 : total/15 + (1-((total/15)%1))}"/>
           <c:forEach begin="1" end="${pages}" var="i">
           <li style="cursor: pointer;" onclick="goToPage(${i},'${startDate}','${endDate}','${radio}')">
      		${i}
            </li>
          </c:forEach>
        </ul>
      </div>
    </div>
  </div>
</main>
<!-- Footer -->
<%@ include file="../footer.jsp"%>
<script>
function goToPage(i, startDate, endDate, radio) {
	
	
    let url = '/storeDelivery/storeDelivery.do?pageno=' + i;
    
    if (startDate) {
        url += '&startDate=' + encodeURIComponent(startDate);
    }
    if (endDate) {
        url += '&endDate=' + encodeURIComponent(endDate);
    }
     // radio가 undefined인 경우에도 추가됩니다.
     if (radio) {
    	 url += '&radio=' + encodeURIComponent(radio);
    }
	
       
    location.href = url; // 페이지 이동
}
function toggleAll(source) {
    const checkboxes = document.querySelectorAll('.product-checkbox');
    checkboxes.forEach((checkbox) => {
        checkbox.checked = source.checked; // 전체 선택 체크박스의 상태로 설정
    });
}
//개별 체크박스의 상태를 확인하는 함수
function updateToggleAll() {
    const checkboxes = document.querySelectorAll('.product-checkbox');
    const allChecked = [...checkboxes].every(checkbox => checkbox.checked); // 모든 체크박스가 체크되었는지 확인
    const toggleAllCheckbox = document.getElementById('toggleAll'); // 전체 체크박스의 ID로 요소 가져오기
    toggleAllCheckbox.checked = allChecked; // 전체 체크박스 상태 업데이트
}

// HTML 체크박스에 이벤트 추가
document.querySelectorAll('.product-checkbox').forEach(checkbox => {
    checkbox.addEventListener('change', updateToggleAll); // 개별 체크박스 변경 시 updateToggleAll 호출
});

window.onload = function() {
    const urlParams = new URLSearchParams(window.location.search);
    const startDate = urlParams.get('startDate');
    const endDate = urlParams.get('endDate');
    const radio = urlParams.get('radio');

    // 입력 필드에 값을 설정합니다.
    if (startDate) {
        document.getElementById('startDate').value = startDate;
    }
    if (endDate) {
        document.getElementById('endDate').value = endDate;
    }
    console.log(radio);
    if (radio === 'Y') {
        document.querySelector('input[name="assignment"][value="Y"]').checked = true; // 첫 번째 라디오 버튼 체크
    } else if (radio === 'N') {
        document.querySelector('input[name="assignment"][value="N"]').checked = true; // 두 번째 라디오 버튼 체크
    }
};


</script>


<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="../js/storeDelivery.js?v="<%= sf.format(today) %>></script>