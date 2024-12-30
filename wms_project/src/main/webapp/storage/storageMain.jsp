<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %>
<!-- Header -->
<%@ include file="../header.jsp"%>
<!-- Nav -->
<%@ include file="../nav.jsp"%>   



<main role="main" style="height: 850px;">

  <div class="container">
    <div>
   
     
    <input type="hidden" name="search" id="hiddenSearch">
    <input type="hidden" name="mspot" value="${sessionScope.mspot}" >
    <p class="sub_title font16_bold">창고 리스트 현황</p>
    <div class="mb-3" style="position: relative;">
        <ul class="ul-2">
            <li class="num_font13_bold">검색형식</li>
            <li style="width: 85%; display: flex; flex-direction: row;">
                <input type="text" id="searchKeyword" name="searchKeyword" style="width: 200px; height: 40px;" class="form-control font12" placeholder="창고명을 입력하세요">
                <button type="submit" onclick="search1()" class="btn btn-primary font12" style="width: 70px; height: 40px; margin-left:10px; margin-right: 10px;">검색</button>   
                <button type="button" onclick="searchall1()" class="btn btn-dark font12" style="width: 70px; height: 40px; margin-right: 10px;">전체</button> 
            </li>
        </ul> 
     </div>
   
     <div class="mb-3">
        <table class="table font12">
            <thead>
              <tr align="center" style="line-height: 30px;">
                <th scope="col" style="height: 30px;">NO</th>
                <th scope="col" style="width: 120px;">창고코드</th>
                <th scope="col" style="width: 150px;">창고명</th>
                <th scope="col" style="width: 330px;">주소</th>
                <th scope="col" style="width: 120px;">담당자</th>
                <th scope="col" style="width: 150px;">사용 유/무</th>
                <th scope="col" style="width: 150px;">수정 / 삭제</th>
              </tr>
            </thead>
            <tbody style="background-color: #f1f1ef;">
            <c:if test="${empty members}">
              <tr align="center" style="line-height: 30px;">
                <td colspan="7">등록된 창고가 없습니다.</td>
              </tr>
            </c:if>
            <c:forEach var="member" items="${members}" varStatus="status">
            <c:if test="${member.sdeleted}">
                <tr align="center" style="line-height: 30px;">
                    <td>${status.index + 1}</td>
                    <td>${member.scode}</td>
                    <td>${member.sname}</td>
                    <td>(${member.spost})${member.saddress1} ${member.saddress2}</td>
                    <td>${member.smname}</td>
                    <td>
					    <c:choose>
					        <c:when test="${member.suse == 1}">
					            사용가능
					        </c:when>
					        <c:otherwise>
					            사용불가
					        </c:otherwise>
					    </c:choose>
					</td>
                    <td>
                        <ul class="btn_ul">
                            <li>
                            <button type="button" class="btn btn-dark font12" style="width: 50px; height: 30px; margin-right: 10px;" onclick="location.href='/storage/storageUpdate.do?scode=${member.scode}'">수정</button>
                            </li>
                            <li>
                            <button type="button" class="btn btn-dark font12" style="width: 50px; height: 30px; margin-right: 10px;" onclick="deleteStorage(${member.scode})">삭제</button> 
                            </li>
                        </ul>
                    </td>
                  </tr>
                  </c:if>
                </c:forEach>    
            </tbody>
          </table>
           
     </div>

     <div class="mb-3">
        <ul class="pageing">
          <c:set var="pages" value="${total%15 == 0? total/15 : total/15 + (1-((total/15)%1))}"/>
           <c:forEach begin="1" end="${pages}" var="i">
           <li style="cursor: pointer;" onclick="goToPage(${i}, '${search}')">
      		${i}
            </li>
          </c:forEach>
        </ul>
      </div>
      <div class="mb-3" style="text-align: right;">
      <button type="button" class="btn btn-danger font12" style="width: 100px; height: 40px;" onclick="location.href='/storage/storageInsert.do'" >창고 등록</button> 
      </div>
    </div>
  </div>
</main>
<script>
function goToPage(i, search) {
	
	
    let url = 'storageMain.do?pageno=' + i;

    if (search) {
        url += '&search=' + encodeURIComponent(search);
    }

    
    location.href = url; // 페이지 이동
}
</script>
<!-- Footer -->
<%@ include file="../footer.jsp"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="../js/storage.js?v=<%= sf.format(today) %>"></script>