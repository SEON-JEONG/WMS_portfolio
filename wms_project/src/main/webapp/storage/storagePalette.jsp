<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %>
<!-- Header -->
<%@ include file="../header.jsp" %>
<!-- Nav -->
<%@ include file="../nav.jsp" %>

<main role="main" style="height: auto;">
  <div class="container">
    <div>
    <p class="sub_title font16_bold">파렛트별 현황</p>
    <div class="mb-3" style="position: relative;">
        <ul class="ul-2">
            <li class="num_font13_bold">파렛트 현황</li>
            <li style="display: flex;">
                <select id="paletteTo" onchange="paletteTo1()" style="width: 200px; height: 40px;" class="form-control font12">
                    <option>파렛트 이름 리스트명</option>
                    <c:forEach var="paletteTo" items="${all}">
                    <option value="${paletteTo.sname},${paletteTo.pname}"<c:if test="${paletteTo.sname == param.sname && paletteTo.pname == param.pname}">selected</c:if>>${paletteTo.pname}(${paletteTo.sname})</option>
                    </c:forEach>
                </select>
            </li>
            <li class="num_font13_bold">변경 파렛트</li>
            <li>
                <select id="paletteFrom" style="width: 200px; height: 40px;" class="form-control font12">
                    <option>재고 이동할 파렛트명</option>
                    <c:forEach var="another" items="${palettAnother}">
                    <option value="${another.pname},${another.pcode}">${another.pname}</option>
                    </c:forEach>
                </select>
            </li>
        </ul> 
     </div>
     <div class="mb-3">
        <table class="table font12">
            <thead>
              <tr align="center" style="line-height: 30px;">
                <th scope="col" style="width:30px; height: 30px;">
                    <input type="checkbox" id="toggleAll" onclick="toggleAll(this)">
                </th>
                <th scope="col" style="width: 100px;">파렛트명</th>
                <th scope="col" style="width: 120px;">파렛트 코드</th>
                <th scope="col" style="width: 260px;">상품명</th>
                <th scope="col" style="width: 100px;">상품코드</th>
                <th scope="col" style="width: 150px;">창고명</th>
                <th scope="col" style="width: 80px;">수량</th>
                <th scope="col" style="width: 100px;">변경수량</th>
              </tr>
            </thead>
            <tbody style="background-color: #f1f1ef;">
                 <c:forEach var="palette" items="${paletteall}">            
                <tr align="center" style="line-height: 30px;">
                    <td><input type="checkbox" name="checkbox" value="${palette.pdidx}" class="product-checkbox"></td>
                    <td>${palette.pname}</td>
                    <td>${palette.pcode}</td>
                    <td align="left">${palette.pdname}</td>
                    <td>${palette.pdcode}</td>
                    <td>${palette.sname}</td>
                    <td>${palette.pdamount}EA</td>
                    <td>
                        <input type="text" name="quantity" oninput="validateQuantity(this, ${palette.pdamount});" style="width: 90px; height: 40px;" maxlength="5" class="form-control font12" value="">
                    </td>
                  </tr>                 
                  </c:forEach>
            </tbody>
          </table>
     </div>
     <div class="mb-3">
        <ul class="pageing">
          <c:set var="pages" value="${total%20 == 0? total/20 : total/20 + (1-((total/20)%1))}"/>
           <c:forEach begin="1" end="${pages}" var="i">
           <li style="cursor: pointer;" onclick="goToPage(${i},'${sname}','${pname}')">
      		${i}
            </li>
          </c:forEach>
        </ul>
      </div>
      <div class="mb-3" style="text-align: right;">
      <button type="button" class="btn btn-danger font12" style="width: 100px; height: 40px;" onclick="paletteMove()">파렛트 이동</button> 
      </div>
    </div>
  </div>
</main>

<!-- Footer -->
<%@ include file="../footer.jsp" %>
<script>
function goToPage(i, sname, pname) {
	
	
    let url = 'storagePalette.do?pageno=' + i;
    
    if (sname) {
        url += '&sname=' + encodeURIComponent(sname);
    }
    if (pname) {
        url += '&pname=' + encodeURIComponent(pname);
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
<script src="../js/storage.js?v=<%= sf.format(today) %>"></script>

