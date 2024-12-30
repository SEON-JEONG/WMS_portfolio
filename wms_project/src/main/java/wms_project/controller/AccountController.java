package wms_project.controller;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletResponse;
import wms_project.dto.AccountDTO;
import wms_project.service.AccountService;

@Controller
public class AccountController {

	@Resource(name="accountdto")
	AccountDTO dto;
	
	@Autowired
	AccountService as;

	String output = null;
	javascript js = new javascript();
	
	
	public static int startno = 0;
	public static int endno = 15; 
	
	

	@GetMapping("/account/accountMain.do")
	public String accountMain(
			@RequestParam(value = "search", required = false) String search,
			@RequestParam(value="pageno", required = false) Integer pageno,
			Model m) {
		
		System.out.println(search);
		System.out.println("어카운트의 pageno : " + pageno);
		int a = 0;
		
		Map<String, Object> paramValue = new HashMap<>();
		paramValue.put("search", search);
		
		int total = as.accountCtn(paramValue);

		if(pageno == null) {
			pageno = 1;
			this.startno = 0;
			this.endno = 15;
		}else {
			this.startno = (pageno-1) * 15;
			this.endno = 15;
		}
		
		paramValue.put("endno", this.endno);
		paramValue.put("startno", this.startno);
	     
	    List<AccountDTO> result = as.accountList(paramValue);
	    m.addAttribute("all", result);
	    m.addAttribute("total", total);
	    m.addAttribute("userpage", pageno);
	    m.addAttribute("search", search);
	    m.addAttribute("endno",this.endno);

	    return null;
	}
	
	
	@GetMapping("/account/accountInsert.do")
	public String accountInsert() {
		
		return null;
	}
	
	@PostMapping("/account/accountInsertok.do")
	public String accountInsertok(
			@ModelAttribute("account") AccountDTO dto,
			Model m) throws Exception {
		
		try {
			int result = as.account_insert(dto);
			System.out.println(result);
			if(result > 0) {
				System.out.println(result);
				this.output=this.js.ok("정상적으로 거래처등록이 완료 되었습니다.", "/account/accountMain.do");
			}else {
				this.output=this.js.no("거래처 등록에 실패하였습니다. 다시 시도해 주세요.");
			}
		} catch (Exception e) {
			this.output=this.js.no("데이터 오류로 인하여 등록 되지 않습니다. 다시 시도해 주세요");
		}
			m.addAttribute("output", output);
			return "output";
		}
		
	
 	@CrossOrigin("*")
 	@PostMapping("/account/companyck.do")
 	public String companycheck(
 			@RequestParam("acompany") String acompany, 
 			HttpServletResponse res) throws Exception {	
 				
 		PrintWriter pw = res.getWriter();
 		String result ="ok";
 		String count = "";
 		if(acompany.equals("")) {
 		}else {
 			result = as.search_company(acompany);
 			count = as.account_ctn();
 			System.out.println("중복체크 결과 : "+result);
 			pw.print(result+","+count);
 			pw.close();
 		}
 		return null;
 	}
 	

 	@GetMapping("/account/accountModify.do")
 	public String accountModify(
 			@RequestParam("aidx") String aidx,
 			Model m) {
 		AccountDTO adto = as.accountIdx(aidx);
 		m.addAttribute("adto",adto);
 		
 		return "account/accountModify";
 	};

 	
 	//거래처 수정 업로드
	@PostMapping("/account/accountModifyok.do")
	public String accountmodifyok(@ModelAttribute("modify") AccountDTO dto,
									Model m) throws Exception {
		
		try {
			int result = as.accountModify(dto);
			System.out.println(result);
			
			if(result > 0) {
				this.output=this.js.ok("정상적으로 수정이 완료 되었습니다.", "/account/accountMain.do");
			}else {
				this.output=this.js.no("거래처 수정을 실패하였습니다. 다시 시도해 주세요.");
			}
		} catch (Exception e) {
			this.output=this.js.no("데이터 오류로 인하여 수정 되지 않습니다. 다시 시도해 주세요"+e);
		}
		m.addAttribute("output", output);
	
 		return "output";
	}

	
	@GetMapping("/account/accountDelete.do")
	public String accountDelete(
			@RequestParam("aidx") String aidx,
			Model m) {
		try {
			int result = as.accountDelete(aidx);
			if(result > 0) {
				this.output=this.js.ok("정상적으로 삭제가 완료되었습니다.", "/account/accountMain.do");
			}else {
				this.output=this.js.no("거래처 삭제를 실패하였습니다. 다시 시도해 주세요.");
			}
		} catch (Exception e) {
			this.output=this.js.no("데이터 오류로 인하여 등록 되지 않습니다. 다시 시도해 주세요"+e);
		}
		m.addAttribute("output", output);
 		return "output";
	}

}
