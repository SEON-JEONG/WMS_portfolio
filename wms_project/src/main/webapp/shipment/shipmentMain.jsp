<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="cr" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- Header -->
<cr:import url="../header.jsp"/>
<!-- Nav -->
<cr:import url="../nav.jsp"/>


<main role="main" style="height: auto;">
  <div class="container">
    <div>
    <p class="sub_title font16_bold">배송선택(본사, 지점)</p>
    <div class="mb-3" style="position: relative;">
        <form id="search_frm">
        <ul class="ul-2">
            <li class="num_font13_bold">오더 일자별 검색</li>
            <li style="width: 85%; display: flex; flex-direction: row;">
                <input type="date" name="start_date" value="${start_date}" style="width: 150px; height: 40px;" class="form-control font12">&nbsp;-&nbsp;
                <input type="date" name="end_date" value="${end_date}" style="width: 150px; height: 40px;" class="form-control font12">
                <button type="button" onclick="search_shipment()" class="btn btn-primary font12" style="width: 70px; height: 40px; margin-left:10px; margin-right: 10px;">검색</button>
            </li>
        </ul>
        </form>
        <ul class="ul-2">
            <li class="num_font13_bold">상품코드 검색</li>
            <li style="width: 85%; display: flex; flex-direction: row;">
              <button type="button" onclick="open_popup()" class="btn btn-success font12" style="width: 100px; height: 40px; margin-right: 10px;">물품검색</button><font style="font-size: 12px; color: red;">&nbsp;&nbsp;※ 배송기사가 해당 상품을 상차할 창고 및 파렛트를 확인 할 수 있습니다.</font>
            </li>
        </ul>
     </div>
     <div class="mb-3">
        <table class="table font12">
            <thead>
              <tr align="center" style="line-height: 30px;">
                <th scope="col" style="width: 40px;"><input id="all_check" onchange="all_select(this.checked)" type="checkbox"></th>
                <th scope="col" style="width: 120px;">주문번호</th>
                <th scope="col" style="width: 150px;">상품명</th>
                <th scope="col" style="width: 100px;">상품코드</th>
                <th scope="col" style="width: 80px;">고객명</th>
                <th scope="col" style="width: 120px;">연락처</th>
                <th scope="col" style="width: 240px;">창고/파렛트 정보</th>
                <th scope="col" style="width: 80px;">입력일자</th>
                <th scope="col" style="width: 70px;">기사배정</th>
                <th scope="col" style="width: 120px;">저장 / 삭제</th>
              </tr>
            </thead>
            <tbody style="background-color: #f1f1ef;">
                <cr:forEach var="shipment" items="${all}">
                <tr align="center" style="line-height: 30px;" class="shipment_row">
                    <input type="hidden" name="aidx" value="${shipment.aidx}">
                    <td><input name="product" class="product" onchange="one_select()" value="${shipment.aproductcode}" type="checkbox"></td>
                    <td>${shipment.aordercode}</td>
                    <td align="left">${shipment.aproduct}</td>
                    <td>${shipment.aproductcode}</td>
                    <td>${shipment.acustomer}</td>
                    <td>${shipment.ahp}</td>
                    <td style="display: flex; flex-direction: row; justify-content: center;">
                      <input type="text" name="bstorage" style="width: 120px; height: 40px; margin-right: 5px;" value="${shipment.bstorage == 'N' ? '' : shipment.bstorage}" <cr:if test="${shipment.bstorage != 'N'}">readOnly</cr:if> class="form-control font12" placeholder="창고명">
                      <input type="text" name="bpalett" style="width: 120px; height: 40px; margin-right: 5px;" value="${shipment.bpalett == 'N' ? '' : shipment.bpalett}" <cr:if test="${shipment.bpalett != 'N'}">readOnly</cr:if> class="form-control font12" placeholder="파렛트명">
                      <input type="hidden" name="bstoragecode" value="${shipment.bstoragecode}">
                      <input type="hidden" name="bpalettcode" value="${shipment.bpalettcode}">
                    </td>
                    <td>${shipment.date.substring(0,10)}</td>
                    <td>${shipment.adeliveryck}</td>
                    <td>
                      <button type="button" onclick="save_shipment(${shipment.aidx})" class="btn btn-success font12" style="width: 50px; height: 30px;">
                        저장
                      </button>
                        <button type="button" onclick="delete_shipment(${shipment.aidx})" class="btn btn-danger font12" style="width: 50px; height: 30px;">
                          삭제
                        </button>
                    </td>
                  </tr>
                  </cr:forEach>
            </tbody>
          </table>
     </div>
     <div class="mb-3">
        <!-- 페이징 시작 -->
        <ul class="pageing">
            <cr:set var="page" value="${total%15 == 0? total/15 : total/15 + (1-((total/15)%1))}"/>
            <cr:forEach var="i" begin="1" end="${page}">
                <li style="cursor: pointer;" onclick="go_page(${i}, '${start_date}', '${end_date}'})">
                    ${i}
                </li>
            </cr:forEach>
        </ul>
        <!-- 페이징 끝 -->
      </div>
      <div class="mb-3" style="text-align: right;">
        <button type="button" onclick="save_all()" class="btn btn-primary font12" style="width: 100px; height: 40px;">
          일괄저장
        </button>
      </div>
    </div>
  </div>
</main>


<!-- 스크립트 자동 업데이트 -->
<script src="../js/shipment.js?=${sf.format(today)}"></script>
<!-- Footer -->
<cr:import url="../footer.jsp"/>