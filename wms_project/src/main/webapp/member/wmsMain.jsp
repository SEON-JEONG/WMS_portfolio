<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="f" %>
<!-- Header -->
<%@ include file="../header.jsp"%>
<!-- Nav -->
<%@ include file="../nav.jsp"%>  
 
<style>
select {
  /* Reset Select */
  appearance: none;
  outline: 10px red;
  box-shadow: none;
  /* Personalize */
  flex: 1;
  padding: 0 1em;
  color: #000;
  background-color: var(--darkgray);
  background-image: none;
  cursor: pointer;
   border: 2.5px solid #c0392b;
  border-radius: .50em;
}
/* Remove IE arrow */
select::-ms-expand {
  display: none;
}
/* Custom Select wrapper */
.select {
  position: relative;
  display: flex;
  width: 15em;
  height: 2em;
  overflow: hidden;
}

/* Arrow */
.select::after {
  content: '\25BC';
  position: absolute;
  top: 3px;
  right: 0;
  padding-left: 1em;
  padding-right: 1em;
  transition: .25s all ease;
  pointer-events: none;
}
/* Transition */
.select:hover::after {
  color: #f39c12;
}
</style>
<main role="main" style="height: 850px;">
  <div class="container">
    <div class="row">
  <!--입고현황-->
      <div class="ad_main">
        <div class="ad_main1">
           <ul>
              <li class="ad_maintitle font14">입고현황</li>
              <li class="ad_mainbox">
                <c:forEach var="p" items="${product}">
                 <ol>
                    <li class="bgcolor1">
                       ${p.lastmove} &gt; ${p.pdname}(${p.pdcode}) &gt; 
                       ${p.pdamount}EA &gt;${p.sname} &gt; ${p.pname} 
                    </li>
                 </ol>
                 </c:forEach>
              </li>
           </ul>
        </div>
     </div>
<!--입고현황 끝-->

  <!--배송현황-->
  <div class="ad_main">
    <div class="ad_main1">
       <ul>
          <li class="ad_maintitle font14">배송현황</li>
          <li class="ad_mainbox", style="display: flex; align-items: center;">   
          <div class="select">                
             <select id="deliveryList" onchange="Change(this.value);" style="border: 1px solid gray;" >
             <option value="">배송기사 선택해주세요</option>
             <c:forEach var="d" items="${deliverymanList}">
             <option value="${d.dcode}"
             <c:if test="${d.dcode == param.z}">selected</c:if>>${d.dname} 기사님(${d.dspot})</option>
             </c:forEach>
             </select> 
             </div>         			
             <div style="margin-left: 40px;">
             	<!-- <p style="font-size: 10px;">*최근 순으로 5건까지 표출됩니다.</p> -->
             <c:choose>
		    <c:when test="${empty deliveryList}">
		        현재 배송중인 배송건이 없습니다.
		    </c:when>
		    <c:otherwise>
		        <c:forEach var="l" items="${deliveryList}"> 
		            <ul>
		                <li class="bgcolor1">
		                 주문번호 : ${l.aordercode} | 상품명 : ${l.aproduct} | 배송지 : ${l.addr} | 배송현황 : ${l.shipstate} |
		                </li>
		            </ul>
		        </c:forEach>
		    </c:otherwise>
		</c:choose>		
	</div>
          </li>
       </ul>
    </div>
 </div>
<!--배송현황 끝-->

<!--배송현황-->
<div class="ad_main">
  <div class="ad_main1">
     <ul>
        <li class="ad_maintitle font14">신규등록 배송기사</li>
        <li class="ad_mainbox">
          <c:forEach var="m" items="${deliveryman}">
                 <ol>
                    <li class="bgcolor1">
                     ${m.dname} (${m.dspot}) [ ${m.dcode} ] | 
                            ${m.dhp} | ${m.dapprove}
                    </li>
                 </ol>
          </c:forEach>
        </li>
     </ul>
  </div>
</div>
<!--배송현황 끝-->
    </div>

  </div> <!-- /container -->
</main>

<!-- Footer -->
<%@ include file="../footer.jsp"%>
<script>
function Change(z) {
    if (z != "") {
        // GET 방식으로 서버에 요청
        window.location.href = '/member/wmsMain.do?z=' + z;
    }
}

</script>
