<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %>
<!-- Header -->
<%@ include file="../header.jsp"%>
<!-- Nav -->
<%@ include file="../nav.jsp"%>   

<script src="../js/config.js?v="<%= sf.format(today) %>></script>

<main role="main" style="height: auto;">

  <div class="container">
    <div>
    <p class="sub_title font16_bold">관리자 현황</p>
    
  
    <div class="mb-3" style="position: relative;">
        <ul class="ul-2">
            <li class="num_font13_bold">소 속</li>
            <li>
                <select name="part1" id="part1" style="width: 100px; height: 40px; margin-right: 5px;" class="form-control font12">
                    <option value="본사"<c:if test="${part1 == '본사'}">selected</c:if>>본사</option>
                    <option value="지점"<c:if test="${part1 == '지점'}">selected</c:if>>지점</option>
                </select>
            </li>
            <li></li>
            <li></li>
        </ul> 
       <ul class="ul-2">
		    <li class="num_font13_bold">검색형식</li>
		    <li style="width: 85%; display: flex; flex-direction: row;">
		        <select name="part2" id="part2" style="width: 100px; height: 40px; margin-right: 5px;" class="form-control font12">
		            <option value="이름"<c:if test="${part2 == '이름'}">selected</c:if>>이름</option>
		            <option value="아이디"<c:if test="${part2 == '아이디'}">selected</c:if>>아이디</option>
		            <option value="연락처"<c:if test="${part2 == '연락처'}">selected</c:if>>연락처</option>
		        </select>
		        <input type="text" id="searchKeyword" name="search" style="width: 200px; height: 40px;" class="form-control font12" placeholder="검색어를 입력하세요">
		        <button type="button" onclick="getFormInfo()" class="btn btn-primary font12" style="width: 70px; height: 40px; margin-left: 10px; margin-right: 10px;">검색</button>
		        <button type="button" onclick="searchall()" class="btn btn-dark font12" style="width: 70px; height: 40px; margin-left: 10px; margin-right: 10px;">전체</button>
		    </li>
		</ul>
     </div>
     <div class="mb-3">
        <table class="table table-striped font12">
            <thead>
              <tr align="center" style="height: 30px; line-height: 30px;">
                <th scope="col" style="width: 50px;">NO</th>
                <th scope="col" style="width: 150px;">구분</th>
                <th scope="col" style="width: 150px;">아이디</th>
                <th scope="col" style="width: 100px;">이름</th>
                <th scope="col" style="width: 100px;">직책</th>
                <th scope="col" style="width: 250px;">이메일</th>
                <th scope="col" style="width: 150px;">연락처</th>
                <th scope="col">현황</th>
                <th scope="col" style="width: 100px;">적용</th>
              </tr>
            </thead>
            <tbody>
            <c:set var="ino" value="${total}"/>
            <c:forEach var="member" items="${members}" varStatus="status">
              <tr align="center">
                <td>${total - ((pageno - 1)*15 + status.index)}</td>
                <td>${member.mpart}</td>
                <td>${member.mid}</td>
                <td>${member.mname}</td>
                <td>${member.mjob}</td>
                <td>${member.memail}</td>
                <td>${member.mhp}</td>
                <td>
                    <select name="part3" id="part3_${member.midx}" style="width: 80px; height: 30px;" class="form-control font12">
            
                        <option value="대기" <c:if test="${member.approve == '대기'}">selected </c:if>>대기</option>
                        <option value="근무" <c:if test="${member.approve == '근무'}">selected </c:if>>근무</option>
                        <option value="휴직" <c:if test="${member.approve == '휴직'}">selected </c:if>>휴직</option>
                        <option value="퇴사" <c:if test="${member.approve == '퇴사'}">selected </c:if>>퇴사</option>
                    </select>
                </td>
                <td style="text-align: center;">
                    <button type="button" class="btn btn-dark font12" style="width: 50px; height: 30px; margin-right: 10px;" onclick="change4(${member.midx})"<c:if test="${member.midx == 1}">disabled</c:if> >적용</button> 
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
           <li style="cursor: pointer;" onclick="goToPage(${i}, '${part1}', '${part2}', '${search}')">
      		${i}
            </li>
          </c:forEach>
        </ul>
      </div>
    </div>
  </div>
</main>
<script>

function goToPage(i, part1, part2, search) {
	
	
    let url = 'configMain.do?pageno=' + i;

    if (part1) {
        url += '&part1=' + encodeURIComponent(part1);
    }
    if (part2) {
        url += '&part2=' + encodeURIComponent(part2);
    }
    if (search) {
        url += '&search=' + encodeURIComponent(search);
    }

    
    location.href = url; // 페이지 이동
}


</script>


<!-- Footer -->
<%@ include file="../footer.jsp"%>