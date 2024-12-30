<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="cr" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- Header -->
<cr:import url="../header.jsp"/>

<main role="main" style="height: 850px;">
  <div class="container">
    <div>
    <p class="sub_title font16_bold">물품검색</p>
    <div class="mb-3" style="position: relative;">
        <form id="frm">
        <ul class="ul-2">
            <li class="num_font13_bold">검색형식</li>
            <li style="width: 85%; display: flex; flex-direction: row;">
                <input type="hidden" name="pdcodes" value="${pdcodes}">
                <select name="part" style="width: 100px; height: 40px; margin-right: 5px;" class="form-control font12">
                    <option value="상품명" <cr:if test="${part == '상품명'}">selected</cr:if>>상품명</option>
                    <option value="상품코드" <cr:if test="${part == '상품코드'}">selected</cr:if>>상품코드</option>
                </select>
                <input type="text" value="${search =! ''? search : ''}" name="search" style="width: 150px; height: 40px;" class="form-control font12" placeholder="검색어를 입력하세요">
                <button type="button" onclick="search_product()" class="btn btn-primary font12" style="width: 70px; height: 40px; margin-left:10px; margin-right: 10px;">검색</button>
            </li>
        </ul>
        </form>
     </div>
     <div class="mb-3">
        <table class="table table-striped font12">
            <thead>
              <tr align="center" style="height: 30px; line-height: 30px;">
                <th scope="col">창고명</th>
                <th scope="col">파렛트명</th>
                <th scope="col">상품코드</th>
                <th scope="col">상품명</th>
                <th scope="col">재고</th>
                <th scope="col">입고일자</th>
                <th scope="col" style="width: 5%;">적용</th>
              </tr>
            </thead>
            <tbody>
            <cr:forEach var="product" items="${all}">
              <tr align="center">
                <td>${product.sname}</td>
                <td>${product.pname}</td>
                <td>${product.pdcode}</td>
                <td align="left">${product.pdname}</td>
                <td>${product.pdamount}</td>
                <td>${product.pddate.substring(0,10)}</td>
                <td style="text-align: center;">
                    <button type="button" onclick="apply_product(${product.pdidx}, '${product.pdcode}')" class="btn btn-dark font12" style="width: 50px; height: 30px; margin-right: 10px;">적용</button>
                </td>
              </tr>
              </cr:forEach>
            </tbody>
          </table>
     </div>
     <div class="mb-3">
        <ul class="pageing">
          <li>1</li>
        </ul>
      </div>
    </div>
    <div class="mb-3" style="text-align: right;">
      <button type="button" onclick="close_popup()" class="btn btn-danger font12" style="width: 100px; height: 40px; margin-right: 40px;">
        창닫기
      </button>
    </div>
    </div>
  </div>
</main>

<!-- 스크립트 자동 업데이트 -->
<script src="../js/shipment.js?=${sf.format(today)}"></script>
<!-- Footer -->
<cr:import url="../footer.jsp" />