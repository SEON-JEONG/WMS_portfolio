//일자별 오더등록 검색 버튼 클릭 시
function search_order(){
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
            search_frm.action="../order/orderMain.do";
            search_frm.submit();
        }
    }
}

//EXCEL 등록 버튼 클릭 시
function insert_order(){
    var order_file = file_frm.order_file.value;
    if(order_file == ""){
        alert("EXCEL 파일을 첨부하셔야 합니다.");
    }else{
        console.log(order_file);
        file_frm.method="post";
        file_frm.action="../order/file_upload.do";
        file_frm.submit();
    }
}

//거래처별 등록 현황
function search_account(start_date, end_date){
    var account = document.getElementById("accountnm").value;
    console.log(account);
    console.log(start_date);
    console.log(end_date);
    location.href="/order/orderMain.do?account=" + account + "&start_date=" + start_date + "&end_date=" + end_date;
}

//등록된 주문 삭제
function delete_order(aidx){
    console.log(aidx);
    if(confirm("해당 오더를 삭제 하시겠습니까?")){
        const form = document.createElement("form");
        form.method="post";
        form.action="../order/delete_order.do";

        const input = document.createElement("input");
        input.type="hidden";
        input.name="aidx";
        input.value = aidx;

        form.appendChild(input);
        document.body.appendChild(form);
        form.submit();
    }
}

//페이징
function go_page(i, start_date, end_date, account){
    let url = "orderMain.do?pageno=" + i;
    if(start_date && end_date){
        url += "&start_date=" + encodeURIComponent(start_date);
        url += "&end_date=" + encodeURIComponent(end_date);
    }
    if(account != "N"){
        url += "&account=" + encodeURIComponent(account);
    }
    location.href = url;
}