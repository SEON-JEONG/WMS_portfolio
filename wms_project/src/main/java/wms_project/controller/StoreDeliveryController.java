package wms_project.controller;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import wms_project.dto.DeliveryListDTO;
import wms_project.dto.ProductDTO;
import wms_project.dto.ShippingDTO;
import wms_project.service.StoreDeliveryService;


@Controller
public class StoreDeliveryController {
	
	@Autowired
	StoreDeliveryService sds;

	PrintWriter pw = null;
	
	@PostMapping("/deleteDeliverymen.do")
	public String deleteDeliverymen(@RequestBody String data, HttpServletResponse res) {
		
		try {
			this.pw = res.getWriter();
			JSONArray ja = new JSONArray(data);
			JSONObject jo = (JSONObject) ja.getJSONObject(0);
			System.out.println(jo);
			int aidx = jo.getInt("aidx");
			
			int result = sds.DeleteDeliverymen(aidx);
			
			if(result > 0) {			
				this.pw.print("ok");
			}else {
				this.pw.print("no");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			this.pw.print("error");
		}
		
		
		return null;
	}
	
	@PostMapping("/checkDeliverymen.do")
	public String checkDeliverymen(@RequestBody String data, HttpServletResponse res) {
		
		try {
			this.pw = res.getWriter();
			JSONArray ja = new JSONArray(data);
			// System.out.println(ja);
			// System.out.println(ja.length());

			int w = 0;

			while (w < ja.length()) {
				Map<String, Object> params = new HashMap<>();

				JSONObject jo = (JSONObject) ja.getJSONObject(w);
				String aidx = jo.get("aidx").toString();
				String dcode = jo.get("dcode").toString();
				String dname = jo.get("dname").toString();
				String dspot = jo.get("dspot").toString();
				
				System.out.println(dcode + ":" + aidx+ ":" + dname+ ":" + dspot );

				params.put("dcode", dcode);
				params.put("aidx", aidx);
				params.put("dspot", dspot);
				params.put("dname", dname);

				sds.useDeliverymen(params);
				
				w++;
			}
						
			this.pw.print("ok");

		} catch (Exception e) {
			e.printStackTrace();

		}
		
		
		
		return null;
	}
	
	
	
	
	@GetMapping("/storeDelivery/storeDelivery.do")
	public String storeMain(@RequestParam(value = "startDate", required = false) String startDate,
						 @RequestParam(value = "endDate", required = false) String endDate,	
						 @RequestParam(value = "radio", required = false) String radio, 
						 @RequestParam(value = "pageno",required = false) Integer pageno, HttpServletRequest req, Model m) {
		HttpSession sess = req.getSession();
		String mspot = (String) sess.getAttribute("mspot");
		Map<String, Object> params = new HashMap<>();
		
			int total =0;
			int startno = 0;
			int endno = 20;
			
			if(pageno == null) {
		    	   startno = 0;
		    	   pageno = 1;
		       }else {
				startno = (pageno-1) * 15;
		       }
		    params.put("startno", startno);
			params.put("endno", endno);
			params.put("mspot", mspot);
		params.put("startDate", startDate);
		params.put("endDate", endDate);
		params.put("radio", radio);
		
		
		List<ShippingDTO>list = sds.order_list(params);
		List<DeliveryListDTO>deliverymenlist = sds.deliverymenlist(mspot);
		total = sds.order_count(params);
		
		m.addAttribute("startDate", startDate); // 전체 멤버 수
        m.addAttribute("endDate", endDate); // 현재 페이지 번호
        m.addAttribute("radio", radio);
		m.addAttribute("startno", startno);
        m.addAttribute("endno", endno);
		m.addAttribute("pageno",pageno);
		m.addAttribute("total",total);
		m.addAttribute("dlist",deliverymenlist);
		m.addAttribute("list",list);
		
		
	 return	null;
	}
	
	

	
}//class end
