<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="cr" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!-- Header -->
<%@ include file="../header.jsp"%>
<!-- Nav -->
<%@ include file="../nav.jsp"%>   



<main role="main" style="height: auto;">
  <div class="container">
    <div>
    <p class="sub_title font16_bold">오더등록 및 현황</p>
    <div class="mb-3" style="position: relative;">
        <form id="search_frm">
        <ul class="ul-2">
            <li class="num_font13_bold">오더등록 일자별</li>
            <li style="width: 85%; display: flex; flex-direction: row;">
                <input type="date" name="start_date" id="start_date" value="${start_date}" style="width: 150px; height: 40px;" class="form-control font12">&nbsp;-&nbsp;
                <input type="date" name="end_date" id="end_date" value="${end_date}" style="width: 150px; height: 40px;" class="form-control font12">
                <button type="button" onclick="search_order()" class="btn btn-primary font12" style="width: 70px; height: 40px; margin-left:10px; margin-right: 10px;">검색</button>
            </li>
        </ul>
        </form>
        <form id="file_frm" enctype="multipart/form-data">
        <ul class="ul-2">
            <li class="num_font13_bold">EXCEL 오더등록</li>
            <li style="width: 85%; display: flex; flex-direction: row;">
                <input type="file" name="order_file" id="order_file" accept=".xlsx, .xls" style="width: 400px; height: 40px; margin-right: 3px;" class="form-control font12">
                <button type="button" onclick="insert_order()" class="btn btn-success font12" style="width: 100px; height: 40px; margin-left:10px; margin-right: 10px;">EXCEL 등록</button>&nbsp;&nbsp;
                <a href="./shipping.xls" style="color:#333;" download="shipping.xls">※ EXCEL 샘플 [다운로드]</a>
            </li>
        </ul>
        </form>
        <ul class="ul-2">
            <li class="num_font13_bold">오더등록 건수</li>
            <li style="display: flex; flex-direction: row;">
                <span class="font14_bold">총 <font style="color:red;">${total}</font> 건</span>
            </li>
            <li class="num_font13_bold">거래처별 등록현황</li>
            <li>
                <select name="accountnm" id="accountnm" onchange="search_account('${start_date}', '${end_date}')" style="width: 200px; height: 40px; margin-right: 5px;" class="form-control font12">
                    <option value="">거래처를 선택해주세요</option>
                <cr:forEach var="accountList" items="${account_all}">
                    <option value="${accountList}" ${accountList eq account ? 'selected' : ''}>${accountList}</option>
                </cr:forEach>
                </select>
            </li>
        </ul> 
     </div>
     <div class="mb-3">
        <table class="table font12">
            <thead>
              <tr align="center" style="line-height: 30px;">
                <th scope="col" style="width: 40px;">번호</th>
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
            <!-- order 리스트 출력 시작 -->
            <cr:forEach var="order" items="${all}" varStatus="idx">
                <tr align="center" style="line-height: 30px;">
                    <td>${total - ((pageno-1)*15 + idx.index)}</td>
                    <td>${order.aordercode}</td>
                    <td>${order.aproduct}</td>
                    <td>${order.aproductcode}</td>
                    <td>${order.acustomer}</td>
                    <td>${order.ahp}</td>
                    <td align="left">${order.addr}</td>
                    <td>${order.date.substring(0,10)}</td>
                    <td>${order.adeliveryck}</td>
                    <td>
                        <button type="button" onclick="delete_order('${order.aidx}')" class="btn btn-danger font12" style="width: 60px; height: 30px;">삭제</button>
                    </td>
                  </tr>
              </cr:forEach>
            <!-- order 리스트 출력 끝 -->
            </tbody>
          </table>
     </div>
     <div class="mb-3">
        <!-- 페이징 시작 -->
        <ul class="pageing">
            <cr:set var="page" value="${total%15 == 0? total/15 : total/15 + (1-((total/15)%1))}"/>
            <cr:forEach var="i" begin="1" end="${page}">
                <li style="cursor: pointer;" onclick="go_page(${i}, '${start_date}', '${end_date}', '${account}')">${i}</li>
            </cr:forEach>
        </ul>
        <!-- 페이징 끝 -->
      </div>
    </div>
  </div>
</main>

<!-- Footer -->
<%@ include file="../footer.jsp"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="../js/order.js?v=<%= sf.format(today) %>"></script>