<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="cr" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- Header -->
<cr:import url="../header.jsp"/>

<main role="main" style="height: 850px;">
<div class="container">
    <div>
	    <p class="sub_title font16_bold">관리자 현황</p>
	    <div class="mb-3" style="position: relative;">
	    <form id="frm">
			<ul class="ul-2">
	            <li class="num_font13_bold">검색형식</li>
	            <li style="width: 85%; display: flex; flex-direction: row;">
	                <select name="part" style="width: 100px; height: 40px; margin-right: 5px;" class="form-control font12">
						<option value="이름">이름</option>
						<option value="아이디">아이디</option>
						<option value="연락처">연락처</option>
	                </select>
	                <input name="search" type="text" style="width: 200px; height: 40px;" class="form-control font12" placeholder="검색어를 입력하세요">
	                <button type="button" onclick="search_member()" class="btn btn-primary font12" style="width: 70px; height: 40px; margin-left:10px; margin-right: 10px;">검색</button>   
	                <button type="button" onclick="searchAll_member()" class="btn btn-dark font12" style="width: 70px; height: 40px; margin-right: 10px;">전체</button> 
	            </li>
			</ul> 
		</form>
		</div>
		<div class="mb-3">
			<table class="table table-striped font12">
	            <thead>
				<tr align="center" style="height: 30px; line-height: 30px;">
					<th scope="col">NO</th>
					<th scope="col">아이디</th>
					<th scope="col">이름</th>
					<th scope="col">직책</th>
					<th scope="col">이메일</th>
					<th scope="col">연락처</th>
					<th scope="col">현황</th>
					<th scope="col" style="width: 5%;">적용</th>
				</tr>
	            </thead>
	            <tbody>
	            <!-- 지점 관리자 리스트 출력 시작 -->
	            <cr:forEach var="member" items="${all}" varStatus="idx">
				<tr align="center">
					<td>${total - idx.index}</td>
					<td>${member.mid}</td>
					<td>${member.mname}</td>
					<td>${member.mjob}</td>
					<td>${member.memail}</td>
					<td>${member.mhp}</td>
					<td>${member.approve}</td>
					
					<td style="text-align: center;">
					<button type="button" onclick="apply_member(${member.midx})" class="btn btn-dark font12" style="width: 50px; height: 30px; margin-right: 10px;">적용</button>
					</td>
				</tr>
	            </cr:forEach> 
	            <!-- 지점 관리자 리스트 출력 끝 -->
	            </tbody>
			</table>
		</div>
		<div class="mb-3">
			<ul class="pageing">
			    <cr:set var="page" value="${total/15 + (1-((total/15)%1))}"/>
			    <cr:forEach begin="1" end="${page}" var="i">
				<li style="cursor: pointer;" onclick="popup_page(${i}, '${part}', '${search}')">${i}</li>
				</cr:forEach>
			</ul>
		</div>
    </div>
    <div class="mb-3" style="text-align: right;">
		<button type="button" onclick="close_popup()" class="btn btn-danger font12" style="width: 100px; height: 40px; margin-right: 40px;">
		  창닫기
		</button> 
    </div>
</div>
</main>

<!-- 스크립트 자동 업데이트 -->
<script src="../js/office.js?=${sf.format(today)}"></script>
<!-- Footer -->
<cr:import url="../footer.jsp" />