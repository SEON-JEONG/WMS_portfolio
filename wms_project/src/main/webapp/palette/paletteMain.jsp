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
        <p class="sub_title font16_bold">파렛트 리스트 현황</p>
        <div class="mb-3" style="position: relative;">
            <form id="frm">
            <ul class="ul-2">
                <li class="num_font13_bold">검색형식</li>
                <li style="width: 85%; display: flex; flex-direction: row;">
                    <input type="text" name="search" style="width: 200px; height: 40px;" class="form-control font12" placeholder="파렛트명을 입력하세요">
                    <button type="button" onclick="searchPalette()" class="btn btn-primary font12" style="width: 70px; height: 40px; margin-left:10px; margin-right: 10px;">검색</button>
                    <button type="button" onclick="searchAllPalette()" class="btn btn-dark font12" style="width: 70px; height: 40px; margin-right: 10px;">전체</button>
                </li>
            </ul>
            </form>
        </div>
        <div class="mb-3">
            <table class="table font12">
                <thead>
                <tr align="center" style="line-height: 30px;">
                    <th scope="col" style="height: 30px;">NO</th>
                    <th scope="col" style="width: 200px;">파렛트명</th>
                    <th scope="col" style="width: 150px;">파렛트 코드</th>
                    <th scope="col" style="width: 240px;">사이즈</th>
                    <th scope="col" style="width: 150px;">색상</th>
                    <th scope="col" style="width: 150px;">사용 유/무</th>
                    <th scope="col" style="width: 150px;">수정 / 삭제</th>
                </tr>
                </thead>
                <tbody style="background-color: #f1f1ef;">
                <!-- palette 리스트 출력 시작 -->
                <cr:forEach var="palette" items="${all}" varStatus="idx">
                    <tr align="center" style="line-height: 30px;">
                        <td>${total - ((pageno-1)*15 + idx.index)}</td>
                        <td>${palette.pname}</td>
                        <td>${palette.pcode}</th>
                        <td>${palette.psize}</td>
                        <td><div class="palette_box" style="background-color: ${palette.pcolor};"></div></td>
                        <td>${palette.pusing}</td>
                        <td>
                            <ul class="btn_ul">
                                <li>
                                <button type="button" onclick="modify_palette(${palette.pidx})" class="btn btn-dark font12" style="width: 50px; height: 30px; margin-right: 10px;">수정</button>
                                </li>
                                <li>
                                <button type="button" onclick="delete_palette(${palette.pidx})" class="btn btn-dark font12" style="width: 50px; height: 30px; margin-right: 10px;">삭제</button>
                                </li>
                            </ul>
                        </td>
                    </tr>
                </cr:forEach>
                <!-- palette 리스트 출력 끝 -->
                </tbody>
            </table>
        </div>
        <div class="mb-3">
            <!-- 페이징 시작 -->
            <ul class="pageing">
                <cr:set var="page" value="${total%15 == 0? total/15 : total/15 + (1-((total/15)%1))}"/>
                <cr:forEach var="i" begin="1" end="${page}">
                    <li style="cursor: pointer;" onclick="go_page(${i}, '${search}')">${i}</li>
                </cr:forEach>
            </ul>
            <!-- 페이징 끝 -->
        </div>
        <div class="mb-3" style="text-align: right;">
            <button type="button" onclick="location.href='../palette/paletteInsert.jsp'" class="btn btn-danger font12" onclick="" style="width: 100px; height: 40px;">파렛트 등록</button>
        </div>
    </div>
</div>
</main>


<!-- 스크립트 자동 업데이트 -->
<script src="../js/palette.js?=${sf.format(today)}"></script>
<!-- Footer -->
<cr:import url="../footer.jsp"/>