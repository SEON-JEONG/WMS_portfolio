package wms_project.controller;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.poi.ss.usermodel.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import wms_project.dto.ShippingDTO;
import wms_project.service.OrderService;

import java.io.InputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

@Controller
public class OrderController {
    @Resource(name="ShippingDTO")
    ShippingDTO sdto;

    @Autowired
    OrderService os;

    PrintWriter pw = null;


    //Order 메인 페이지
    @GetMapping("/order/orderMain.do")
    public String order_list(Model m, @RequestParam(value = "start_date", required = false) String start_date,
                             @RequestParam(value = "end_date", required = false) String end_date,
                             @RequestParam(value = "pageno", required = false) Integer pageno,
                             @RequestParam(value = "account", required = false) String account){
        Map<String, Object> paramValue = new HashMap<>();
        paramValue.put("start_date", start_date);
        paramValue.put("end_date", end_date);
        paramValue.put("account", account);

        int total = os.order_count(paramValue);
        int items = 15;
        int startno = 0;
        if(pageno == null){
            pageno = 1;
        } else {
            startno = (pageno-1) * 15;
        }
        paramValue.put("items", items);
        paramValue.put("startno", startno);

        List<ShippingDTO> all = os.order_list(paramValue);
        List<String> account_all = os.account_list();

        m.addAttribute("all", all);
        m.addAttribute("account_all", account_all);
        m.addAttribute("total", total);
        m.addAttribute("pageno", pageno);
        m.addAttribute("start_date", start_date);
        m.addAttribute("end_date", end_date);
        m.addAttribute("account", account);

        return null;
    }

    //excel 첨부 파일 내용 insert
    @PostMapping("/order/file_upload.do")
    public String file_upload(@RequestParam(value = "order_file", required = false)MultipartFile order_file,
                              HttpServletResponse res, HttpServletRequest req){
        //excel file insert
        res.setContentType("text/html;charset=utf-8");
        try {
            this.pw = res.getWriter();
            //첨부파일 이름 변경하여 /excelUpload/ 디렉토리에 저장
            String new_name = os.file_save(order_file, req);

            //첨부 파일 내용 insert
            int count = 0;

            InputStream inputStream = order_file.getInputStream();
            Workbook workbook = WorkbookFactory.create(inputStream);
            Sheet sheet = workbook.getSheetAt(0);
            Iterator<Row> rows = sheet.iterator();

            while(rows.hasNext()){  //값이 있는 행 확인, 다음 읽을 행이 더이상 없을 때까지
                Row row = rows.next();  //값이 있는 행 읽기
                Iterator<Cell> cellIterator = row.cellIterator();   //열을 배열 형태로 읽어들임
                if(row.getRowNum() > 0){
                    while(cellIterator.hasNext()){  //값이 있는 셀 확인, 다음 읽을 셀이 더이상 없을 때까지
                        Cell cell = cellIterator.next();    //값이 있는 셀 읽기
                        int cellno = cell.getColumnIndex(); //셀 순서대로 셀 번호 부여
                        switch (cellno){
                            case 0:
                                sdto.setAordercode(cell.toString());
                                break;
                            case 1:
                                sdto.setAproductcode(cell.toString());
                                break;
                            case 2:
                                sdto.setAproduct(cell.toString());
                                break;
                            case 3:
                                sdto.setAcustomer(cell.toString());
                                break;
                            case 4:
                                sdto.setAhp(cell.toString());
                                break;
                            case 5:
                                sdto.setAddr(cell.toString());
                                break;
                            case 6:
                                sdto.setAccount(cell.toString());
                                break;
                        }
                    }
                    try {
                        setDefaultDto(sdto);    //기본값 N 설정
                        int result = os.insert_order(sdto);
                        if(result > 0){
                            count += 1;
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
            this.pw.print("<script>" +
                    "alert('등록하신 파일의 주문 " + count + "개가 등록되었습니다.');" +
                    "history.go(-1);" +
                    "</script>");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.pw.close();
        }
        return null;
    }

    //등록된 주문 삭제
    @PostMapping("/order/delete_order.do")
    public String delete_order(@RequestParam(value = "aidx", required = false) String aidx, HttpServletResponse res){
        res.setContentType("text/html;charset=utf-8");
        try {
            this.pw = res.getWriter();
            int result = os.delete_order(aidx);
            if(result > 0){
                this.pw.print("<script>" +
                        "alert('해당 오더를 삭제하였습니다.');" +
                        "location.href='/order/orderMain.do';" +
                        "</script>");
            }
            else{
                this.pw.print("<script>" +
                        "alert('배송 중인 오더는 삭제할 수 없습니다.');" +
                        "history.go(-1);" +
                        "</script>");
            }
        } catch (Exception e) {
            this.pw.print("<script>" +
                    "alert('시스템 오류로 인해 오더 삭제를 실패했습니다.\n잠시 후 다시 시도해주세요.');" +
                    "history.go(-1);" +
                    "</script>");
        } finally {
            this.pw.close();
        }

        return null;
    }

    private void setDefaultDto(ShippingDTO sdto){
        sdto.setAcode("N");
        sdto.setAdeliveryck("N");
        if(sdto.getBstorage() == null){
            sdto.setBstorage("N");
            sdto.setBstoragecode("N");
            sdto.setBpalett("N");
            sdto.setBpalettcode("N");
            sdto.setBapprove("N");
        }
        if(sdto.getDcode() == null){
            sdto.setDcode("N");
            sdto.setDeliveryname("N");
            sdto.setDspot("N");
            sdto.setDapprove("N");
        }
        if(sdto.getStracking() == null){
            sdto.setStracking("N");
            sdto.setSqrimg("N");
            sdto.setSqrurl("N");
            sdto.setShipstate("대기");
        }
    }



}
