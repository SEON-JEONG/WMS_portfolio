package wms_project.controller;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import wms_project.dto.ProductDTO;
import wms_project.dto.ShippingDTO;
import wms_project.service.ShipmentService;

import java.io.PrintWriter;
import java.util.*;

@Controller
public class ShipmentController {

    @Resource(name="ShippingDTO")
    ShippingDTO sdto;

    @Autowired
    ShipmentService ss;

    @Autowired
    HttpSession session;

    PrintWriter pw = null;

    //shipmentMain 배송 선택 메인 페이지 출력
    @GetMapping("/shipment/shipmentMain.do")
    public String shipment_list(@RequestParam(value = "start_date", required = false) String start_date,
                                @RequestParam(value = "end_date", required = false) String end_date,
                                @RequestParam(value = "pageno", required = false) Integer pageno,
                                Model m){
        Map<String, Object> paramValue = new HashMap<>();
        paramValue.put("start_date", start_date);
        paramValue.put("end_date", end_date);

        int total = ss.count_shipment(paramValue);
        int items = 15;
        int startno = 0;
        if(pageno == null){
            pageno = 1;
        } else {
            startno = (pageno-1) * 15;
        }
        paramValue.put("items", items);
        paramValue.put("startno", startno);

        List<ShippingDTO> result = ss.shipment_list(paramValue);

        m.addAttribute("all", result);
        m.addAttribute("start_date", start_date);
        m.addAttribute("end_date", end_date);
        m.addAttribute("total", total);
        m.addAttribute("pageno", pageno);

        return null;
    }

    //물품 검색 팝업 페이지 출력
    @GetMapping("/shipment/shipmentPopList.do")
    public String pop_list(@RequestParam(value = "pdcodes", required = false) String pdcodes,
                           @RequestParam(value = "part", required = false) String part,
                           @RequestParam(value = "search", required = false) String search,
                           @RequestParam(value = "pageno", required = false) Integer pageno,
                           Model m){
        String mspot = (String)session.getAttribute("mspot");
        String[] aproductcodes = pdcodes.split(",");

        Map<String, Object> paramValue = new HashMap<>();
        paramValue.put("part", part);
        paramValue.put("search", search);
        paramValue.put("mspot", mspot);

        int total = 0;
        int startno = 0;
        int items = 15;
        if(pageno == null){
            pageno = 1;
        } else {
            startno = (pageno-1)*15;
        }

        paramValue.put("items", items);
        paramValue.put("startno", startno);

        Set<ProductDTO> all = new HashSet<>();
        for (String aproductcode : aproductcodes) {
            paramValue.put("aproductcode", aproductcode);
            List<ProductDTO> product = ss.product_list(paramValue);
            all.addAll(product);
            total += ss.count_shipment(paramValue);
        }
        m.addAttribute("all", new ArrayList<>(all));
        m.addAttribute("total", total);
        m.addAttribute("pageno", pageno);
        m.addAttribute("part", part);
        m.addAttribute("search", search);
        m.addAttribute("pdcodes", pdcodes);
        return null;
    }

    //물품 검색 팝업 물품 적용 버튼 클릭
    @PostMapping("/shipment/apply_product.do")
    @ResponseBody
    public Map<String, Object> apply_product(@RequestParam("pdidx") String pdidx, @RequestParam("pdcode") String pdcode){
        Map<String, Object> response = new HashMap<>();
        //System.out.println(pdidx);
        //System.out.println(pdcode);
        try {
            if(pdidx == null){
                response.put("error", "존재하지 않는 상품입니다.\n잠시 후 다시 이용해주세요.");
            }
            else{
                ProductDTO product = ss.apply_product(pdidx);
                //System.out.println(product);
                sdto.setBstorage(product.getSname());
                sdto.setBpalett(product.getPname());
                sdto.setBstoragecode(product.getScode());
                sdto.setBpalettcode(product.getPcode());
                //System.out.println(sdto);

                response.put("pdcode", pdcode);
                response.put("pname", product.getPname());
                response.put("sname", product.getSname());
                response.put("pcode", product.getPcode());
                response.put("scode", product.getScode());
                response.put("pdname", product.getPdname());
            }
        } catch (Exception e) {
            response.put("error", "시스템 오류로 인해 적용되지 않았습니다.\n잠시 후 다시 이용해주세요.");
        }
        //System.out.println(response);
        return response;
    }

    //물품 창고명, 파렛트명 저장
    @PostMapping("/shipment/save_shipping.do")
    public String save_shipping(@RequestBody String product, HttpServletResponse res){
        //System.out.println(product);
        try {
            this.pw = res.getWriter();
            JSONArray jsonArray = new JSONArray(product);
            int i = 0;

            while(i < jsonArray.length()){
                Map<String, Object> paramValue = new HashMap<>();
                JSONObject jsonObject = (JSONObject)jsonArray.getJSONObject(i);
                System.out.println(jsonObject);
                String aidx = jsonObject.get("aidx").toString();
                String bstorage = jsonObject.get("bstorage").toString();
                String bpalett = jsonObject.get("bpalett").toString();
                String bstoragecode = jsonObject.get("bstoragecode").toString();
                String bpalettcode = jsonObject.get("bpalettcode").toString();

                paramValue.put("aidx", aidx);
                paramValue.put("bstorage", bstorage);
                paramValue.put("bpalett", bpalett);
                paramValue.put("bstoragecode", bstoragecode);
                paramValue.put("bpalettcode", bpalettcode);

                ss.save_shipment(paramValue);
                i++;
            }
            this.pw.print("ok");
        } catch (Exception e) {
            this.pw.print("error");
        } finally {
            this.pw.close();
        }
        return null;
    }

    //물품 삭제
    @PostMapping("/shipment/delete_shipment.do")
    public String delete_shipment(@RequestParam("aidx") String aidx, HttpServletResponse res){
        res.setContentType("text/html;charset=utf-8");
        try {
            this.pw = res.getWriter();

            int result = ss.delete_shipment(aidx);
            if(result > 0){
                this.pw.print("<script>" +
                        "alert('물품 삭제가 완료되었습니다.');" +
                        "location.href='/shipment/shipmentMain.do';" +
                        "</script>");
            }
            else{
                this.pw.print("<script>" +
                        "alert('배송중인 물품은 삭제할 수 없습니다.');" +
                        "history.go(-1);" +
                        "</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.pw.close();
        }
        return null;
    }



}