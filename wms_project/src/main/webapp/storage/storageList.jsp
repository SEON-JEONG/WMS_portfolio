<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %>


<!-- Header -->
<%@ include file="../header.jsp"%>
<!-- Nav -->
<%@ include file="../nav.jsp"%>   



 
<main role="main" style="height: auto;">
  <div class="container">
    <div>
    <p class="sub_title font16_bold">창고별 재고 현황</p>
    <div class="mb-3" style="position: relative;">
       <form action="/storage/storageList.do" method="get">
        <ul class="ul-2">
            <li class="num_font13_bold">재고창고</li>
            <li style="display: flex;">
                <select id="selectstorage" name="selectstorage" onchange="this.form.submit()" style="width: 200px; height: 40px;" class="form-control font12">
                    <option value="">창고명 출력</option>
                    <c:forEach var="storagefrom" items="${members}">
                    <option value="${storagefrom.scode}"
                    <c:if test="${storagefrom.scode == param.selectstorage}">selected</c:if>>${storagefrom.sname}</option>
                    </c:forEach>
                </select>
            </li>
            <li class="num_font13_bold">이동창고</li>
            <li>
                <select name="storageto" id="storageto" onchange="updateHiddenField(this)" style="width: 200px; height: 40px;" class="form-control font12">
                    <option value="">창고명 출력</option>
                    <c:forEach var="storageto" items="${membersall}">
                    <option value="${storageto.scode}" data-storagename="${storageto.sname}">${storageto.sname}</option>
                    </c:forEach>
                </select>
            </li>
        </ul>
        
        </form> 
     </div>
     <div class="mb-3">
        <table class="table font12">
            <thead>
              <tr align="center" style="line-height: 30px;">
                <th scope="col" style="width:30px; height: 30px;">
                    <input type="checkbox" id="toggleAll" onclick="toggleAll(this)">
                </th>
                <th scope="col" style="width: 150px;">거래처명</th>
                <th scope="col" style="width: 260px;">상품명</th>
                <th scope="col" style="width: 110px;">상품코드</th>
                <th scope="col" style="width: 100px;">수량</th>
                <th scope="col" style="width: 180px;">창고명</th>
                <th scope="col" style="width: 120px;">파렛트명</th>
                <th scope="col" style="width: 100px;">출고수량</th>
              </tr>
            </thead>
            <tbody style="background-color: #f1f1ef;">
            <c:forEach var="products" items="${product}">
             <c:if test="${products.pdamount > 0}">
                <tr align="center" style="line-height: 30px;">
                    <td><input type="checkbox" name="checkbox" value="${products.pdidx}" class="product-checkbox"></td>
                    <td>${products.acompany}</td>
                    <td align="left">${products.pdname}</td>
                    <td>${products.pdcode}</td>
                    <td>${products.pdamount}</td>
                    <td>${products.sname}</td>
                    <td>${products.pname}</td>
                    <td><input type="text" name="quantity" oninput="validateQuantity(this, ${products.pdamount});" style="width: 90px; height: 40px;" maxlength="5" class="form-control font12" ></td>
                  </tr>
                  </c:if>
               </c:forEach>
            </tbody>
          </table>
     </div>
     <div class="mb-3">
     <ul class="pageing">
       <c:set var="pages" value="${total%20 == 0? total/20 : total/20 + (1-((total/20)%1))}"/>
           <c:forEach begin="1" end="${pages}" var="i">
           <li style="cursor: pointer;" onclick="goToPage(${i},'${selectstorage}','${storageto}')">
      		${i}
            </li>
          </c:forEach>
         </ul>
      </div>
      <input type="hidden" id="hiddenStoragename" name="storagename" value="">
      <div class="mb-3" style="text-align: right;">
      <button type="button" class="btn btn-danger font12" style="width: 100px; height: 40px;" onclick="collectCheckedData()">상품 창고 이동</button> 
      </div>     
    </div>
  </div>
</main>
<!-- Footer -->
<%@ include file="../footer.jsp"%>

<script>
function goToPage(i, selectstorage, storageto) {
	
	
    let url = 'storageList.do?pageno=' + i;
    
    if (selectstorage) {
        url += '&selectstorage=' + encodeURIComponent(selectstorage);
    }
    if (storageto) {
        url += '&storageto=' + encodeURIComponent(storageto);
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

function updateHiddenField(selectElement) {
	 // 선택된 옵션 가져오기
    const selectedOption = selectElement.options[selectElement.selectedIndex];

    // data-storagename 값 가져오기
    const storagename = selectedOption.dataset.storagename;

    // 히든 필드 업데이트
    const hiddenInput = document.getElementById("hiddenStoragename");
    if (hiddenInput) {
        hiddenInput.value = storagename || ""; // 값이 없으면 빈 값 설정
    }



}
function validateQuantity(inputElement, availableAmount) {
    const value = inputElement.value;

    // 숫자가 아닌 경우
    if (value && isNaN(value)) {
        alert("숫자만 입력할 수 있습니다."); // 경고 메시지
        inputElement.value = ''; // 빈 문자열로 설정
        return;
    }

    // 입력값이 비어있지 않고 현재 재고 수량보다 큰 경우
    if (value && parseInt(value) > availableAmount) {
        alert(`이동 수량은 현재 재고보다 많을 수 없습니다.`);
        inputElement.value = availableAmount; // 재고 수량으로 설정
    }
}
</script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="../js/storage.js?v="<%= sf.format(today) %>></script>