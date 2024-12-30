<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- Header -->
<%@ include file="../header.jsp"%>
<!-- Nav -->
<%@ include file="../nav.jsp"%> 


<main role="main" style="height: auto;">
  <div class="container">
    <div>
    <p class="sub_title font16_bold">배송기사별 배송현황</p>
    <div class="mb-3" style="position: relative;">
        <ul class="ul-2">
            <li class="num_font13_bold">기사검색</li>
            <li style="width: 85%; display: flex; flex-direction: row;">
                <select name="part" style="width: 100px; height: 40px; margin-right: 5px;" class="form-control font12">
                    <option value="이름">이름</option>
                    <option value="사원번호">사원번호</option>
                    <option value="연락처">연락처</option>
                </select>
                <input type="text" name="search" id="search" style="width: 150px; height: 40px;" class="form-control font12">
                <button type="button" onclick="searchBtn()" class="btn btn-success font12" style="width: 100px; height: 40px; margin-left:10px; margin-right: 10px;">검색</button>
                <button type="button" onclick="allBtn()" class="btn btn-primary font12" style="width: 100px; height: 40px; margin-right: 10px;">전체</button>
                <font style="font-size: 12px; color: red;">&nbsp;&nbsp;※ 검색된 기사에 한해서 배송현황을 확인 할 수 있습니다.</font>
            </li>
        </ul>  
     </div>
     <div class="mb-3">
        <table class="table font12">
            <thead>
              <tr align="center" style="line-height: 30px;">
                <th scope="col" style="width: 50px;">번호</th>
                <th scope="col" style="width: 150px;">사원번호</th>
                <th scope="col" style="width: 120px;">배송 기사명</th>
                <th scope="col" style="width: 200px;">근무지역</th>
                <th scope="col" style="width: 100px;">배송완료</th>
                <th scope="col" style="width: 100px;">배송분실</th>
                <th scope="col" style="width: 130px;">근무현황</th>
              </tr>
            </thead>
            <tbody style="background-color: #f1f1ef;">
            
           <c:if test="${empty result}">
		        <tr>
		            <td colspan="7" height="80px" align="center" style="color: #777; font-size: 14px; ">배송기사별 배송현황 리스트가 없습니다.</td>
		        </tr>
    		</c:if>
            
            
            
            <c:set var="page" value="${param.page != null ? param.page : 1}" />
			<c:set var="pageSize" value="15" />
             <c:forEach var="list" items="${result}" varStatus="idx">
                <tr align="center" style="line-height: 30px;">
                    <td>${(f:length(result) - idx.index)}</td>
                    <td>${list.dcode}</td>
                    <td>${list.dname}</td>
                    <td>${list.dspot}</td>
                    <td>${list.deliveredctn}</td>
                    <td>${list.lostctn}</td>
                    <td>${list.dapprove}</td>
                  </tr>
              </c:forEach>
            </tbody>
          </table>
     </div>
     
     
    <div class="mb-3">
        <ul class="pageing">
        <c:set var="pages" value="${total%15 == 0? total/15 : total/15 + (1-((total/15)%1))}"/>
        <c:forEach var="no" begin="1" end="${pages}" step="1">
          <li onclick="page_go(${no}, '${search}')" style="cursor: pointer;">${no}</li>
         </c:forEach>
        </ul>
      </div>
      
      
      
      
    </div>
  </div>
</main>



<script src="../js/deliveryState.js?v=<%=sf.format(today)%>"></script>
<!-- Footer -->
<%@ include file="../footer.jsp"%>