package wms_project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.annotation.Resource;
import wms_project.dto.DeliveryStateDTO;
import wms_project.service.DeliveryStateService;

@Controller
public class DeliveryStateController {

	@Resource(name="deliverystatedto")
	DeliveryStateDTO dto;
	@Autowired
	DeliveryStateService dsss;
	
	String output = null;
	javascript js = new javascript();
	
	@GetMapping("/deliveryState/deliveryState.do")
	public String deliveryState(
			@RequestParam(value = "pageno", required = false) Integer pageno,
			@RequestParam(value = "part", required = false) String part,
			@RequestParam(value = "search", required = false) String search,
			Model m) {
		
		int startno = 0; 
        int endno = 15;    
        if(pageno == null){
            pageno = 1;
        } else {
            startno = (pageno-1) * 15;
        }
	  
        Map<String, Object> ctn = new HashMap<>();
        ctn.put("part", part);
        ctn.put("search", search);
        ctn.put("startno", startno);
		ctn.put("endno", endno);
        
        int total = dsss.stateCtn(ctn);
        m.addAttribute("total", total);
        
        Map<String, Object> list = new HashMap<>();
		list.put("part", part);
		list.put("search", search);
		list.put("startno", startno);
		list.put("endno", endno);
        
		List<DeliveryStateDTO> result = dsss.shipstatus(list);
		m.addAttribute("result", result);
		
		return null;
	}
}
