package wms_project.controller;

import java.io.File;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.support.MethodArgumentTypeMismatchException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;


import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import wms_project.dto.AccountDTO;
import wms_project.dto.DeliveryListDTO;
import wms_project.dto.OfficeDTO;
import wms_project.service.DeliveryListService;
import wms_project.service.OfficeService;

@Controller
public class DeliveryListController implements security {

	@Resource(name="deliverydto")
	DeliveryListDTO dto;
	@Autowired
	DeliveryListService ds;
	
	@Resource(name="OfficeDTO")
	OfficeDTO odto;
	@Autowired
    OfficeService os;
	
	@Autowired
    HttpSession session;
	
	String output = null;
	javascript js = new javascript();
	
	public static int startno = 0;	
	public static int endno = 15; 
	
	
	@GetMapping("/deliveryList/deliveryMain.do")
	public String deliveryMain(
	    @RequestParam(value="pageno", required = false) Integer pageno,
	    @RequestParam(value= "spot", required = false) String spot,
	    @RequestParam(value = "part", required = false) String part,
	    @RequestParam(value = "search", required = false) String search,
	    HttpSession session,
	    Model m) {
		
	    if (pageno == null) {
	    	pageno = 1;
	    	this.startno = 0;
	        this.endno = 15;
	    } else {
	        this.startno = (pageno - 1) * 15; 
	        this.endno = 15;
	    }

	    String mspot = (String) session.getAttribute("mspot");
	    Map<String, Object> params = new HashMap<>();
	    params.put("mspot", mspot);
	    params.put("spot", spot);
	    params.put("part", part);
	    params.put("search", search);
	    params.put("startno", this.startno);
	    params.put("endno", this.endno);
	    
	    List<DeliveryListDTO> all = ds.deliveryList(params);
	    List<OfficeDTO> office = os.office_list();
	    String result = ds.deliveryMspotCtn(mspot);
	    
	    m.addAttribute("office", office);
	    m.addAttribute("all", all);
	    m.addAttribute("total", result);
	    m.addAttribute("userpage", pageno);
	    m.addAttribute("spot", spot);
	    m.addAttribute("part", part);
	    m.addAttribute("search", search);
	    
	    return null;
	}


	
	
	@PostMapping("/deliveryList/deliveryInsertok.do")
	public String deliveryInsertok( @ModelAttribute("delivery") DeliveryListDTO dto,
									@RequestParam("dimgnmf") MultipartFile files, 
									HttpServletResponse res, 
									HttpServletRequest req,
									Model m)throws Exception {
		
		Date date = new Date();
		SimpleDateFormat si = new SimpleDateFormat("yyyyMMddhhmmss");
		Random random = new Random();
		
		if("".equals(dto.getDimgnm())) {
			dto.setDimgnm("N");
		} 
		if ("N".equals(dto.getDimgnm())) {
		    dto.setDimgrenm("N");
		    dto.setDimgurl("N");
		    dto.setDimgck("N");
		} else {
		    dto.setDimgrenm("Y");
		    dto.setDimgurl("Y");
		    dto.setDimgck("Y");
		}
		
		String userpw = dto.getDpass();
		StringBuilder repass = secode(userpw);
		dto.setDpass(repass.toString());
		
		String filenm = files.getOriginalFilename();
		long filesize = files.getSize();
	
		if(filesize != 0) {
			if (filesize > 2097152) {
				this.output=this.js.no("첨부파일 용량은 최대 2MB까지만 등록 가능합니다.");
			}else {	
				String url = req.getServletContext().getRealPath("/deliveryList/imgUpload/");
				String type = filenm.substring(filenm.lastIndexOf("."));
				int no = random.nextInt(40)+1;	
				String new_nm = si.format(date);
				FileCopyUtils.copy(files.getBytes(), new File(url+new_nm+no+type));
				dto.setDimgnm(filenm);
				dto.setDimgrenm(new_nm+no+type);
				dto.setDimgurl("./deliveryList/imgUpload/");
			}
		}else {
			dto.setDimgnm("N");
			dto.setDimgrenm("N");
		    dto.setDimgurl("N");
		    dto.setDimgck("N");
		}
	
		try {
			int result = ds.deliveryInsert(dto);
			if(result > 0) {
				this.output=this.js.ok("배송기사 등록이 완료 되었습니다.", "/deliveryList/deliveryMain.do");
			}else {
				this.output=this.js.no("배송기사 등록에 실패하였습니다. 다시 시도해 주세요.");
			}
		} catch (Exception e) {
			e.printStackTrace();
			this.output=this.js.no("데이터 오류로 인하여 등록 되지 않습니다. 다시 시도해 주세요");
		}
		m.addAttribute("output", output);
		         
 		return "output";
	}

	
	
	@CrossOrigin("*")
	@GetMapping("/deliveryList/deliveryCode.do")
	public String deliveryCode(HttpServletResponse res) throws Exception {	
		
		PrintWriter pw = res.getWriter();
		String ctn = "";
		ctn = ds.deliveryCtn();
		System.out.println(ctn);
		pw.print(ctn);
		pw.close();
		return null;
	}
	
	
	@GetMapping("/deliveryList/deliveryApprove.do")
	public String deliveryApprove(@RequestParam("dapprove") String approve,
	                               @RequestParam("didx") String idx, 
	                               Model m) {
	   
	    dto.setDapprove(approve);  
	    dto.setDidx(Integer.parseInt(idx)); 

	    try {
	        int result = ds.deliveryApprove(dto);
		        if (result > 0) {
		        	this.output=this.js.ok("배송기사의 현황이 [ "+ approve +" ] 변경 되었습니다.", "/deliveryList/deliveryMain.do");
		        } else {
		        	this.output=this.js.no("배송기사의 현황 수정을 실패하였습니다. 다시 시도해 주세요.");
		        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        this.output=this.js.no("데이터 오류로 인하여 수정 되지 않습니다. 다시 시도해 주세요"+ e.getMessage());
	    }
	    m.addAttribute("output", output);
	    return "output"; 
	}
	
	@GetMapping("/deliveryList/deliveryModify.do")
	public String deliveryModify(@RequestParam("didx") String didx,
								Model m) {
		DeliveryListDTO ddto = ds.deliveryModifyIdx(didx);
		m.addAttribute("ddto", ddto);
		
		return "deliveryList/deliveryModify";
	}
	
	

	@PostMapping("/deliveryList/deliveryModifyok.do")
	public String deliveryModifyok(@ModelAttribute("modify") DeliveryListDTO dto,
	                               @RequestParam("dimgnmf") MultipartFile files, 
	                               HttpServletResponse res, 
	                               HttpServletRequest req,
	                               Model m) throws Exception {

	    Date date = new Date();
	    SimpleDateFormat si = new SimpleDateFormat("yyyyMMddhhmmss");
	    Random random = new Random();
	    
	    if (dto.getDimgnm() == null) {
	        dto.setDimgnm("N");
	    }
	    if ("N".equals(dto.getDimgnm())) {
	        dto.setDimgrenm("N");
	        dto.setDimgurl("N");
	        dto.setDimgck("N");
	    } else {
	    	dto.setDimgrenm("Y");
		    dto.setDimgurl("Y");
		    dto.setDimgck("Y");
	    }

	    String userpw = dto.getDpass();
	    StringBuilder repass = secode(userpw);
	    dto.setDpass(repass.toString());

	    String filenm = files.getOriginalFilename();
	    long filesize = files.getSize();

	    if (filesize > 2097152) {
	        this.output = this.js.no("첨부파일 용량은 최대 2MB까지만 등록 가능합니다.");
	    } else {
	        if (files.isEmpty()) {
	            this.output = this.js.no("파일을 선택해주세요.");
	        } else {
	            String url = req.getServletContext().getRealPath("/deliveryList/imgUpload/");
	            System.out.println(url);
	            String type = filenm.substring(filenm.lastIndexOf("."));
	            int no = random.nextInt(40) + 1;    
	            String new_nm = si.format(date);
	            FileCopyUtils.copy(files.getBytes(), new File(url + new_nm + no + type));
	            dto.setDimgnm(filenm);
	            dto.setDimgrenm(new_nm + no + type);
	            dto.setDimgurl("./deliveryList/imgUpload/");
	            dto.setDimgck("Y");
	        }
	    }
	    try {
	        int result = ds.deliveryModify(dto);
	        if (result > 0) {
	            this.output = this.js.ok("배송기사 수정이 완료 되었습니다.", "/deliveryList/deliveryMain.do");
	        } else {
	            this.output = this.js.no("배송기사 수정을 실패하였습니다. 다시 시도해 주세요.");
	        }
	    } catch (Exception e) {
	        this.output = this.js.no("데이터 오류로 인하여 등록 되지 않습니다. 다시 시도해 주세요");
	    }

	    m.addAttribute("output", output);
	    return "output";
	}
}
