package wms_project.controller;


import java.io.ByteArrayOutputStream;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.support.MethodArgumentTypeMismatchException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.client.j2se.MatrixToImageConfig;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import wms_project.dto.DeliveryShipDTO;
import wms_project.dto.MobileDTO;
import wms_project.service.DeliveryShipService;
import wms_project.service.MobileService;

@Controller
public class DeliveryShipController {

	@Resource(name="dsdto")
	DeliveryShipDTO dto;
	@Autowired
	private DeliveryShipService dss;
	
	
	
	
	String output = null;
	javascript js = new javascript();
	
	@GetMapping("/deliveryShip/deliveryShip.do")
	public String deliveryShip(
			@RequestParam(value = "start", required = false) String start,
			@RequestParam(value = "end", required = false) String end,
			@RequestParam(value = "dcode", required = false) String dcode,
			@RequestParam(value = "pageno", required = false) Integer pageno,
			Model m) {
		
		int startno = 0;   
        int endno = 15;     
        if(pageno == null){
            pageno = 1;
        } else {
            startno = (pageno-1) * 15;
        }
		
		List<DeliveryShipDTO> dsnm = dss.ShipName();
		m.addAttribute("dsnm", dsnm);
		
		Map<String, Object> ctn = new HashMap<>();
		ctn.put("dcode", dcode);
		ctn.put("start", start);
		ctn.put("end", end);
		ctn.put("startno", startno);
		ctn.put("endno", endno);
		
		int total = dss.ShipCtn(ctn);
		m.addAttribute("total", total);
		
		Map<String, Object> list = new HashMap<>();
		list.put("dcode", dcode);
		list.put("start", start);
		list.put("end", end);
		list.put("startno", startno);
		list.put("endno", endno);
		
		List<DeliveryShipDTO> all = dss.ShipList(list);
		m.addAttribute("all",all);
		
		return null;
	}
	

	@PostMapping("/deliveryShip/deliveryTracking.do")
	public String deliveryTracking(@RequestParam(value = "aidx", required = false) String aidx, Model m) {
	   
		if (aidx == null || aidx.isEmpty()) {
	        m.addAttribute("output", "선택된 항목이 없습니다.");
	        return "output";
	    }

	    String[] idxArray = aidx.split(",");
	    List<String> trdu = new ArrayList<>();
	    
	    for (String aidxStr : idxArray) {
	        int aidxInt = Integer.parseInt(aidxStr);
	        Date date = new Date();
	        SimpleDateFormat si = new SimpleDateFormat("yyyyMMddss");
	        Random random = new Random();
	        String trnm = si.format(date);
	        int no = 1000 + random.nextInt(9000);
	        String trno = trnm + no;

	        String existingTracking = dss.ShipTR(aidxStr); // aidx에 대한 기존 운송장 번호 조회
	        if ("N".equals(existingTracking)) {
	            DeliveryShipDTO dto = new DeliveryShipDTO();
	            dto.setAidx(aidxInt);
	            dto.setStracking(trno);

	            try {
	                int result = dss.ShipTracking(dto); // 운송장 번호 업데이트
	                if (result > 0) {
	                    this.output = this.js.ok("운송장 번호가 생성 되었습니다.", "/deliveryShip/deliveryShip.do");
	                } else {
	                    this.output = this.js.no("운송장 번호 생성에 실패하였습니다. 다시 시도해주세요.");
	                }
	            } catch (Exception e) {
	            	this.output = this.js.no("데이터 오류로 운송장 번호를 생성하지 못하였습니다.\n관리자에게 문의해주세요.");
	            }
	        } else {
	        	trdu.add(existingTracking);
	            String a1 = dss.ShipTR(aidxStr);
	            this.output = this.js.ok("이미 생성된 운송장 번호가 있습니다. ["+aidxStr+"]","/deliveryShip/deliveryShip.do");
	        }
	    }
	    if (!trdu.isEmpty()) {
	        String trduList = String.join(", ", trdu);
	        
	        this.output = this.js.no("이미 생성된 운송장은 제외후 생성됩니다.\\n기존 운송장번호 : [" + trduList + "]");
	    }
	    m.addAttribute("output", output);
	    return "output";
	}

	
	@ExceptionHandler(MethodArgumentTypeMismatchException.class)
	@PostMapping("/deliveryShip/deliveryQr.do")
	public String deliveryQr(
			@RequestParam(value = "aidx", required = false) String aidx,
			HttpServletRequest req,
			HttpServletResponse res,
			Model m) throws Exception {
	
    String[] idxArray = aidx.split(",");
    List<String> trdu = new ArrayList<>();
    
    for(String aidxStr : idxArray) {
    	
    	int aidxInt = Integer.parseInt(aidxStr);
    	String trck = dss.ShipTR(aidxStr);
    	String qrimg = dss.ShipQR(aidxStr);
    	
    	if("N".equals(trck)) {
    		 this.output = this.js.no("송장번호가 없는 오더 제외하고, QR코드가 생성되었습니다.\\nQR코드가 생성되지않은 오더는 운송장 먼처 생성해주세요.");
    	}
    	else if(!"N".equals(qrimg)) {
    		this.output = this.js.no("이미 QR코드가 생성된 오더 입니다.");
    	}
    	else {
    		String url = "http://192.168.10.142:8080/deliveryShip/QrCheck.do?tracking="+trck;
    		int size = 300;
    		BitMatrix bm = new MultiFormatWriter().encode(url, BarcodeFormat.QR_CODE, size, size);

    		int qrcode = 0xFFFF8629;	
			int qrbscolor = 0xFFFFFFFF;	
			MatrixToImageConfig mc = new MatrixToImageConfig(qrcode,qrbscolor);	
			ByteArrayOutputStream bs = null;
			bs = new ByteArrayOutputStream();
			MatrixToImageWriter.writeToStream(bm, "PNG", bs, mc);
			
			String fileurl = req.getServletContext().getRealPath("/deliveryShip/qrImg/"); 
			FileCopyUtils.copy(bs.toByteArray(), new File(fileurl + trck + ".png"));
			bs.flush();
			try {
				DeliveryShipDTO dto = new DeliveryShipDTO();
				dto.setAidx(aidxInt);
				dto.setSqrimg(trck+".png");
				dto.setSqrurl("./deliveryShip/qrImg/");
				int result = dss.QRmake(dto);
				 if (result > 0) {
	                    this.output = this.js.ok("QR코드가 생성되었습니다.", "/deliveryShip/deliveryShip.do");
	                } else {
	                    this.output = this.js.no("QR코드 생성에 실패하였습니다. 다시 시도해주세요.");
	                }
			} catch (Exception e) {
				this.output = this.js.no("데이터 오류로 QR코드를 생성하지 못하였습니다.\n관리자에게 문의해주세요.");
			}
    	}
    }
	    m.addAttribute("output", output);
	    return "output";
	}

	
	
}
