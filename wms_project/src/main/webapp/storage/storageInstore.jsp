<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %>


<!-- Header -->
<%@ include file="../header.jsp"%>
<!-- Nav -->
<%@ include file="../nav.jsp"%>   
<script src="https://unpkg.com/xlsx/dist/xlsx.full.min.js"></script>

<main role="main" style="height: auto;">
  <div class="container">
    <div>
    <p class="sub_title font16_bold">상품 창고 입고</p>
   <!--   <form id="form" method="post" action="productInsert.do" onsubmit="return insertstore()"> -->   
    <div class="mb-3" style="position: relative;">
        <ul class="ul-2">
            <li class="num_font13_bold">입고 창고명</li>
            <li style="display: flex; flex-direction: row;">
                <select id="storage" style="width: 150px; height: 40px;" class="form-control font12">
                    <option value="">창고명을 선택하세요</option>
                    <c:forEach var="storage" items="${members}">
                    <option value="${storage.sname}" data-scode="${storage.scode}">${storage.sname}</option>
                    </c:forEach>
                </select> <font class="font12">&nbsp;※ 입고창고를 필수로 선택하셔야 합니다.</font>
            </li>
            <li class="num_font13_bold">파렛트 설정</li>
            <li style="display: flex; flex-direction: row;">
                <select id="palette" style="width: 150px; height: 40px;" class="form-control font12">
                    <option value="">파렛트를 선택하세요</option>
                    <c:forEach var="palette" items="${palette}">
                    <option value="${palette.pname}">${palette.pname}</option>
                    </c:forEach>
                </select> <font class="font12">&nbsp;※ 파렛트를 필수로 선택하셔야 합니다.</font>
            </li>
        </ul> 
     </div>
     <div class="mb-3">
     <input type="hidden" id="mspot" value="${sessionScope.mspot}">
        <table class="table font12">
            <thead>
              <tr align="center" style="line-height: 30px;">
                <th scope="col" style="width:110px; height: 30px;">거래처명</th>
                <th scope="col" style="width: 110px;">거래처코드</th>
                <th scope="col" style="width: 210px;">상품명</th>
                <th scope="col" style="width: 110px;">상품코드</th>
                <th scope="col" style="width: 80px;">수량</th>
                <th scope="col" style="width: 110px;">창고명</th>
                <th scope="col" style="width: 90px;">창고코드</th>
                <th scope="col" style="width: 110px;">파렛트 선택</th>
                <th scope="col" style="width: 110px;">입고일자</th>
              </tr>
            </thead>
            <tbody style="background-color: #f1f1ef;">
             <c:forEach var="index" begin="0" end="14">
                <tr align="center" style="line-height: 30px;" class="row1">  
                    <td><input type="text" id="acompany" name="acompany"  style="width: 100px; height: 40px;" class="form-control font12"></td>
                    <td><input type="text" id="acode" name="acode" style="width: 100px; height: 40px;" class="form-control font12" readonly></td>
                    <td><input type="text" id="pdname" name="pdname" style="width: 200px; height: 40px;" class="form-control font12"></td>
                    <td><input type="text" id="pdcode" name="pdcode" style="width: 100px; height: 40px;" class="form-control font12"></td>                  
                    <td><input type="text" id="pdamount" name="pdamount" style="width: 70px; height: 40px;" class="form-control font12" maxlength="5"></td>
                    <td><input type="text" id="sname" name="sname" style="width: 100px; height: 40px;" class="form-control font12" readonly></td>
                    <td><input type="text" id="scode" name="scode" style="width: 80px; height: 40px;" class="form-control font12" readonly></td>
                    <td><input type="text" id="pname" name="pname" style="width: 100px; height: 40px;" class="form-control font12" readonly></td>
                    <td><input type="text" id="pddate" name="pddate" style="width: 100px; height: 40px;" class="form-control font12" readonly></td>
                  </tr>
                  </c:forEach>
            </tbody>
          </table>
     </div>
      <div class="mb-3" style="text-align: right;">
      <button type="button" class="btn btn-success font12" style="width: 100px; height: 40px;" onclick="excel_view('1')">EXCEL 등록</button> 
      <button type="button" class="btn btn-danger font12" style="width: 100px; height: 40px;" onclick="insertstore()">입고 등록</button> 
      </div>
    </div>
  </div>
  
<!--EXCEL 재고 등록 부분 -->
  <div class="excelbk" id="excelbk">
        <div class="excel_whitebox">
            <span class="excel_close" onclick="excel_view('2');">X</span>
            <p class="part_text">상품입고 EXCEL 등록</p>
            <span class="excel_fileview">
                <ol>
                    <li>EXCEL 업로드</li>
                    <li><input type="file" id="excelFile" name="excelfile" onchange="handleFile(event)" accept=".xls"></li>
                </ol>
                <ol>
                    <li>EXCEL 예시파일</li>
                    <li><a href="./product.xls" download="product.xls"><em class="downfile">[다운로드]</em></a> ※예시파일에 맞게 입력하셔야만 정상적으로 등록이 됩니다.</li>
                </ol>
                <div class="btn_excel">
                    <input type="button" id="Button" value="상품입고" class="btn_css">
                </div>                
            </span>
        </div>
    </div>
   <!--EXCEL 재고 등록 부분 끝-->
   <script>
    function excel_view(n){
        var excel_pop = document.getElementById("excelbk");
        if(n=="1"){
            excel_pop.style.display = "block";
            window.scrollTo(0, 0);
        }
        else{
            excel_pop.style.display = "none";
        }
    }

   </script>




</main>
<!-- Footer -->
<%@ include file="../footer.jsp"%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="../js/storage.js?v="<%= sf.format(today) %>></script>