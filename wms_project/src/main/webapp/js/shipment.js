//오더 일자별 검색 버튼
//let search_ck = false;
function search_shipment(){
    var start_date = search_frm.start_date.value;
    var end_date = search_frm.end_date.value;
    console.log(start_date);
    console.log(end_date);

    if(!start_date){
        alert("시작 날짜를 입력해주셔야 합니다.");
    }else if(!end_date){
        alert("종료 날짜를 입력해주셔야 합니다.");
    }else{
        const start = new Date(start_date);
        const end = new Date(end_date);
        if(start > end){
            alert("시작 날짜가 종료 날짜보다 늦을 수 없습니다.");
        }else{
            search_frm.method="get";
            search_frm.action="../shipment/shipmentMain.do";
            search_frm.submit();
        }
    }
}

//전체 체크박스 checked=true
function all_select(ck){
    var ea = document.getElementsByName("product");
    for(var i=0; i<ea.length; i++){
        ea[i].checked = ck;
    }
}

//개별 체크박스 checked
function one_select(){
    var ea = document.getElementsByName("product");
    var count = 0;
    for(var i=0; i<ea.length; i++){
        if(ea[i].checked == true){
            count++;
        }
    }
    if(count == ea.length){
        document.getElementById("all_check").checked = true;
    }
    else{
        document.getElementById("all_check").checked = false;
    }
}



//물품 검색 - 팝업 오픈
function open_popup(){
    var pd_check = document.getElementsByName("product");
    var pdcodes = new Array();   //체크된 체크박스의 value 값을 담을 배열
    var index = 0;
    //console.log(pd_check[0].getAttribute("value"));
    for(var i=0; i<pd_check.length; i++){
        if(pd_check[i].checked == true){
            //상품 번호 배열에 저장
            pdcodes[index] = pd_check[i].getAttribute("value");
            index++;
        }
    }
    if(index == 0){
        alert("검색할 물품을 선택해주세요.");
    }
    else{
        const allSame = pdcodes.every(value => value === pdcodes[0]);
        if (!allSame) {
            alert("상품 코드가 동일한 물품만 선택해주세요.");
        } else {
            // 배열 값이 모두 동일한 경우 팝업 열기
           console.log(pdcodes);
           let url = "shipmentPopList.do?pdcodes=" + encodeURIComponent(pdcodes.join(","));
           console.log(pdcodes.join(","));
           window.open(url, "popupWindow", "width=750px, height=500px");
        }
    }
}

//물품 검색 팝업 - 검색 버튼 클릭
function search_product(){
    var part = frm.part;
    var search = frm.search;
    var pdcodes = frm.pdcodes;
    if(search = ""){
        alert("검색할 상품을 입력해주세요.");
    }
    else{
        frm.method="get";
        frm.action="../shipment/shipmentPopList.do";
        frm.submit();
    }
}

//물품 검색 팝업 물품 적용 버튼 클릭
function apply_product(pdidx, pdcode){
    console.log(pdidx);
    console.log(pdcode);
    var http, result;
    http = new XMLHttpRequest();
    http.onreadystatechange = function () {
        if (http.readyState === 4) { // 요청 완료
            if (http.status === 200) { // HTTP 상태 코드 확인
                try {
                    result = JSON.parse(http.responseText);
                    if(result.error){
                        alert(result.error);
                    }
                    else{
                        if(confirm(result.sname + " " + result.pdname + " 제품을 적용하시겠습니까?")){
                            var rows = window.opener.document.getElementsByClassName("shipment_row");
                            for (var i = 0; i < rows.length; i++) {
                                var checkbox = rows[i].querySelector("input[type='checkbox']");
                                console.log(checkbox);
                                if (checkbox.checked && pdcode == result.pdcode) {
                                    console.log("조건 통과:", result.sname, result.pname, result.scode, result.pcode);
                                    rows[i].querySelector("input[name='bstorage']").value = result.sname;
                                    rows[i].querySelector("input[name='bpalett']").value = result.pname;
                                    rows[i].querySelector("input[name='bstoragecode']").value = result.scode;
                                    rows[i].querySelector("input[name='bpalettcode']").value = result.pcode;

                                    rows[i].querySelector("input[name='bstorage']").readOnly = true;
                                    rows[i].querySelector("input[name='bpalett']").readOnly = true;

                                    console.log(rows[i].querySelector("input[name='bstorage']").value);

                                    window.close();
                                }
                            }
                        }
                    }
                } catch (e) {
                    console.error("JSON 파싱 에러:", e.message, http.responseText);
                }
            } else {
                console.error("HTTP 요청 실패:", http.status, http.statusText);
            }
        }
    };
    http.open("post", "../shipment/apply_product.do", true);
    http.setRequestHeader("content-type", "application/x-www-form-urlencoded");
    http.send("pdidx=" + pdidx + "&pdcode=" + pdcode);
}

//팝업 창닫기
function close_popup(){
    window.close();
}

//체크한 주문 저장 - 개별 저장
function save_shipment(aidx){
    console.log(aidx);
    const pd_check = document.getElementsByName("product");
    const bstorage = document.getElementsByName("bstorage");
    const bpalett = document.getElementsByName("bpalett");
    const bstoragecode = document.getElementsByName("bstoragecode");
    const bpalettcode = document.getElementsByName("bpalettcode");

    var http;
    const product = [];

    var count = 0;
    var checkedIndex = -1;
    for(let i = 0; i < pd_check.length; i++){
        if (pd_check[i].checked){
            count++;
            checkedIndex = i;
        }
    }
    if(count == 0){
        alert("저장할 품목을 선택해주세요.");
    }
    else if(count > 1){
        alert("저장할 품목을 한 개만 체크해주세요.");
    }
    else{
        console.log(count);
        var bstorageValue = bstorage[checkedIndex].value;
        var bpalettValue = bpalett[checkedIndex].value;
        var bstoragecodeValue = bstoragecode[checkedIndex].value;
        var bpalettcodeValue = bpalettcode[checkedIndex].value;
        if(bstorageValue == "N" || bpalettcodeValue == "N"){
            alert("창고와 파렛트를 적용시키셔야합니다.");
        }else{
            product.push({"aidx":aidx, "bstorage":bstorageValue, "bpalett":bpalettValue, "bstoragecode":bstoragecodeValue, "bpalettcode":bpalettcodeValue});
            http = new XMLHttpRequest();
            http.onreadystatechange = function (){
                if(http.readyState == 4 && http.status == 200){
                    if(this.response == "ok"){
                        alert("창고와 파렛트 정보가 저장되었습니다.");
                        location.href="../shipment/shipmentMain.do";
                    }

                }
            }
            http.open("post", "../shipment/save_shipping.do", true);
            http.send(JSON.stringify(product));
        }
    }
}

//체크한 주문 삭제
function delete_shipment(aidx){
    console.log(aidx);
    const pd_check = document.getElementsByName("product");

    var count = 0;
    for(let i = 0; i < pd_check.length; i++){
        if (pd_check[i].checked){
            count++;
        }
    }
    if(count == 0){
        alert("삭제할 품목을 선택해주세요.");
    }
    else if(count > 1){
        alert("삭제할 품목을 한 개만 체크해주세요.");
    }
    else{
        if(confirm("해당 오더를 삭제 시 데이터는 복원되지 않습니다.")){
            var input = document.createElement("input");
            input.type = "hidden";
            input.name = "aidx";
            input.value = aidx;

            var form = document.createElement("form");
            form.appendChild(input);
            document.body.appendChild(form);

            form.method = "post";
            form.action = "../shipment/delete_shipment.do";
            form.submit();
        }
    }
}

//물품 일괄 저장
function save_all(){
    const aidx = document.getElementsByName("aidx");
    const pd_check = document.getElementsByName("product");
    const bstorage = document.getElementsByName("bstorage");
    const bpalett = document.getElementsByName("bpalett");
    const bstoragecode = document.getElementsByName("bstoragecode");
    const bpalettcode = document.getElementsByName("bpalettcode");

    var http;
    const product = [];

    for(let i = 0; i < pd_check.length; i++){
        if (pd_check[i].checked){
            var aidxValue = aidx[i].value;
            var bstorageValue = bstorage[i].value;
            var bpalettValue = bpalett[i].value;
            var bstoragecodeValue = bstoragecode[i].value;
            var bpalettcodeValue = bpalettcode[i].value;

            if(bstorageValue == "N" || bpalettcodeValue == "N"){
                    alert("창고와 파렛트를 적용시키셔야합니다.");
            }else{
                product.push({"aidx":aidxValue, "bstorage":bstorageValue, "bpalett":bpalettValue, "bstoragecode":bstoragecodeValue, "bpalettcode":bpalettcodeValue});
            }
        }
    }
    console.log(product);
    if(product.length == 0){
        alert("저장할 품목을 선택해주세요.");
        return false;
    }
    else{
        http = new XMLHttpRequest();
        http.onreadystatechange = function (){
            if(http.readyState == 4 && http.status == 200){
                if(this.response == "ok"){
                    alert("창고와 파렛트 정보가 저장되었습니다.");
                    location.href="../shipment/shipmentMain.do";
                }
            }
        }
        http.open("post", "../shipment/save_shipping.do", true);
        http.send(JSON.stringify(product));

    }
}

//페이징
function go_page(i, start_date, end_date){
    let url = "shipmentMain.do?pageno=" + i;
    if(start_date && end_date){
        url += "&start_date=" + encodeURIComponent(start_date);
        url += "&end_date=" + encodeURIComponent(end_date);
    }
    location.href = url;
}