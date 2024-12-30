<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="cr" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- Header -->
<cr:import url="../header.jsp"/>
<!-- Nav -->
<cr:import url="../nav.jsp"/>


<main role="main" style="height: 850px;">
    <div class="container">
        <div>
        <cr:set var="palette" value="${paletteDTO}"></cr:set>
        <form id="frm">
            <input type="hidden" name="pidx" value="${palette.pidx}">
            <p class="sub_title font16_bold">파렛트 등록</p>
            <div class="mb-3" style="position: relative;">
                <ul class="ul-2">
                    <li class="num_font13_bold">파렛트명</li>
                    <li style="display: flex; flex-direction: row;">
                        <input type="text" name="pname" value="${palette.pname}" style="width: 200px; height: 40px;" class="form-control font12" placeholder="파렛트명을 입력하세요" readonly> <font style="font-size: 12px; color: red;">&nbsp;&nbsp;※ 변경 하실 수 없습니다.</font>
                    </li>
                    <li class="num_font13_bold">파렛트 코드</li>
                    <li style="display: flex; flex-direction: row;">
                        <input type="text" name="pcode" value="${palette.pcode}" style="width: 100px; height: 40px;" class="form-control font12" maxlength="5" readonly><font style="font-size: 12px; color: red;">&nbsp;&nbsp;※ 변경 하실 수 없습니다.</font>
                    </li>
                </ul>
            </div>
            <div class="mb-3" style="position: relative;">
                <ul class="ul-2" style="margin-bottom: 5px;">
                    <li class="num_font13_bold">파렛트 사이즈</li>
                    <li>
                        <input type="text" name="psize" value="${palette.psize}" style="width:310px; height: 40px;" class="form-control font12">
                    </li>
                    <li class="num_font13_bold">파렛트 색상</li>
                    <li>
                        <input type="color" name="pcolor" value="${palette.pcolor}" style="width:100px; height: 40px;" class="form-control font12">
                    </li>
                </ul>
            </div>
            <div class="mb-3" style="position: relative;">
            <ul class="ul-1">
                <li class="num_font13_bold">사용 유/무</li>
                <li class="font14">
                    <label style="margin-right: 40px;">
                        <input type="radio" name="pusing" value="Y" style="vertical-align:-2px; width: 15px; height:15px;"
                        <cr:if test="${palette.pusing == 'Y'}">checked</cr:if>> 사용중
                    </label>
                    <label>
                        <input type="radio" name="pusing" value="N" style="vertical-align:-2px; width: 15px; height:15px;"
                        <cr:if test="${palette.pusing == 'N'}">checked</cr:if>> 미사용중
                    </label>
                </li>
                <li class="num_font13_bold"></li>
                <li></li>
            </ul>
            </div>
            <div class="mb-3" style="text-align: right;">
                <button type="button" onclick="complete_modify()" class="btn btn-danger font12" style="width: 100px; height: 40px; margin-right: 5px;">수정하기</button>
                <button type="button" onclick="cancel_modify()" class="btn btn-dark font12" style="width: 100px; height: 40px;">취소하기</button>
            </div>
        </form>
        </div>
    </div>
</main>


<!-- 스크립트 자동 업데이트 -->
<script src="../js/palette.js?=${sf.format(today)}"></script>
<!-- Footer -->
<cr:import url="../footer.jsp"/>