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
        <p class="sub_title font16_bold">지점 현황</p>
        <div class="mb-3" style="position: relative;">
        <form id="frm">
            <ul class="ul-2">
                <li class="num_font13_bold">검색형식</li>
                <li style="width: 85%; display: flex; flex-direction: row;">
                    <input type="text" name="search" style="width: 200px; height: 40px;" class="form-control font12" placeholder="지점명을 입력하세요">
                    <button type="button" class="btn btn-primary font12" onclick="search_office()" style="width: 70px; height: 40px; margin-left:10px; margin-right: 10px;">검색</button>
                    <button type="button" class="btn btn-dark font12" onclick="searchAll_office()" style="width: 70px; height: 40px; margin-right: 10px;">전체</button>
                </li>
            </ul>
         </form>
         </div>
        <div class="mb-3">
            <table class="table font12">
                <thead>
                    <tr align="center">
                        <th scope="col" style="height: 40px; line-height: 50px;">NO</th>
                        <th scope="col" style="width: 200px;">
                            <table style="text-align: center;" style="height: 40px;">
                            <tr>
                            <td style="width: 150px; background-color: white; border-top: 0px;">지점명</td>
                            </tr>
                            <tr>
                            <td style="width: 150px;">담당자명</td>
                            </tr>
                            </table>
                        </th>
                        <th scope="col" style="width: 150px;">
                            <table style="text-align: center;">
                                <tr>
                                <td scope="col" style="width: 150px; background-color: white; border-top: 0px;">담당자 휴대폰</td>
                                </tr>
                                <tr>
                                <td scope="col" style="width: 150px;">대표 연락처</td>
                                </tr>
                            </table>
                        </th>
                        <th scope="col" style="height: 40px; line-height: 50px; width: 200px;">담당자 이메일</th>
                        <th scope="col" style="height: 40px; line-height: 50px; width: 400px;">지점주소</th>
                        <th scope="col" style="height: 40px; line-height: 50px; width: 120px;">수정 / 삭제</th>
                    </tr>
                </thead>
                <tbody style="background-color: #f1f1ef;">
                <!-- 지점 현황 리스트 출력 반복문 시작 -->
                <cr:forEach var="office" items="${all}" varStatus="idx">
                    <tr align="center" style="border-bottom: 1px solid #ccc;" class="trcss">
                        <th scope="col" style="height: 40px; line-height: 50px;">${total - ((pageno-1) * 15 + idx.index)}</th>
                        <th scope="col" style="width: 200px;">
                            <table style="text-align: center;" style="height: 40px;">
                                <tr>
                                <td style="width: 150px; border-top: 0px;">${office.officename}</td>
                                </tr>
                                <tr>
                                <td style="width: 150px;">${office.mname}</td>
                                </tr>
                            </table>
                        </th>
                        <th scope="col" style="width: 150px;">
                            <table style="text-align: center;">
                                <tr>
                                <td scope="col" style="width: 150px; border-top: 0px;">${office.mhp}</td>
                                </tr>
                                <tr>
                                <td scope="col" style="width: 150px;">${office.otel}</td>
                                </tr>
                            </table>
                        </th>
                        <th scope="col" style="height: 40px; line-height: 50px; width: 150px;">${office.memail}</th>
                        <th scope="col" style="height: 40px; line-height: 50px; width: 300px; text-align: left;">
                            (${office.opost}) ${office.oroad} ${office.oaddress}
                        </th>
                        <th scope="col" style="height: 40px; line-height: 50px; width: 120px;">
                            <ul class="btn_ul">
                            <li><button type="button" class="btn btn-dark font12" onclick="modify_office(${office.oidx})" style="width: 50px; height: 30px; margin-right: 10px;">수정</button>
                            </li>
                            <li>
                            <button type="button" class="btn btn-dark font12" onclick="delete_office(${office.oidx})" style="width: 50px; height: 30px; margin-right: 10px;">삭제</button>
                            </li>
                            </ul>
                        </th>
                    </tr>
                </cr:forEach>
                <!-- 지점 현황 리스트 출력 반복문 끝 -->
                </tbody>
            </table>
        </div>
        <!-- 페이징 시작 -->
        <div class="mb-3">
            <ul class="pageing">
            <cr:set var="page" value="${total%15 == 0? total/15 : total/15 + (1-((total/15)%1))}"/>
            <cr:forEach begin="1" end="${page}" var="i">
                <li style="cursor: pointer;" onclick="go_page(${i}, '${search}')">${i}</li>
            </cr:forEach>
            </ul>
        </div>
        <!-- 페이징 끝 -->
        <div class="mb-3" style="text-align: right;">
            <button type="button" class="btn btn-danger font12" onclick="location.href='../office/officeInsert.jsp'" style="width: 100px; height: 40px; margin-right: 40px;">지점등록</button>
        </div>
    </div>
  </div>
</main>

<!-- 스크립트 자동 업데이트 -->
<script src="../js/office.js?=${sf.format(today)}"></script>
<!-- Footer -->
<cr:import url="../footer.jsp"/>
