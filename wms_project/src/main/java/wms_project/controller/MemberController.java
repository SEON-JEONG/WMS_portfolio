package wms_project.controller;

import java.io.PrintWriter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import wms_project.dto.DeliveryListDTO;
import wms_project.dto.MemberDTO;
import wms_project.dto.OfficeDTO;
import wms_project.dto.ProductDTO;
import wms_project.dto.ShippingDTO;
import wms_project.dto.StorageDTO;
import wms_project.service.MemberService;
import wms_project.service.OfficeService;
import wms_project.service.StorageService;

@Controller
public class MemberController implements security {
	
	@Resource(name="memberdto")
    MemberDTO dto;
	@Autowired
	private MemberService ms;
	
	@Resource(name="OfficeDTO")
	OfficeDTO odto;
	@Autowired
    OfficeService os;
	
	@Autowired
	StorageService ss;
	
	String output = null;
	javascript js = new javascript();
	
	
    @GetMapping("/member/wmsMain.do")
    public String main(@RequestParam (value = "z", required = false) String z, Model m, HttpServletRequest req) {
    	List<ProductDTO> product = ss.newProduct();
    	List<DeliveryListDTO> deliveryman = ss.newDeliveryman();
    	List<DeliveryListDTO> deliverymanList = ss.Deliveryman();
    	List<ShippingDTO> deliveryList = ss.Deliveryman2(z);
    	
    	
    	m.addAttribute("z",z);
    	m.addAttribute("deliveryList",deliveryList);
    	m.addAttribute("product",product);
    	m.addAttribute("deliveryman",deliveryman);
    	m.addAttribute("deliverymanList",deliverymanList);
        return "/member/wmsMain"; 
    }
    
    
    @GetMapping("/member/wmsJoin.do")
    public String wmsJoin(Model m) {
    	List<OfficeDTO> all = os.office_list();
    	m.addAttribute("all", all);
    	return null;
    }
    
 	@PostMapping("/member/wmsJoinok.do")
 	public String joinok(@ModelAttribute("join") MemberDTO dto,
 							Model m)throws Exception {	
 	    if ("N".equals(dto.getMspot())) {
 	        dto.setMspot("본사");
 	    }
 		String userpw = dto.getMpass();	
 		StringBuilder repass = secode(userpw);
 		dto.setMpass(repass.toString());
 		try {
 			int result = ms.member_join(dto);
 				if(result > 0) {
 					this.output=this.js.ok("정상적으로 회원가입이 완료 되었습니다.", "./wmsLogin.jsp");
 				}	
 				else {
 					this.output=this.js.no("회원가입에 실패하였습니다. 다시 시도해 주세요.");
 				}
 		} 
 		catch (Exception e) {
 			this.output=this.js.no("데이터 오류로 인하여 가입이 되지 않습니다. 다시 시도해 주세요");
 		}
 		m.addAttribute("output", output);
 		return "output";
 	}
 	
 	
 	@CrossOrigin("*")
 	@PostMapping("/member/idcheck.do")
 	public String idcheck(@RequestParam("mid") String mid, 
 			HttpServletResponse res) throws Exception {	
 				
 		PrintWriter pw = res.getWriter();
 		String result ="ok";
 		if(mid.equals("")) {
 		}
 		else {
 			result = ms.search_id(mid);
 			pw.print(result);
 			pw.close();
 		}
 		return null;
 	}
 	
    @PostMapping("/member/wmsLoginok.do")
    public String loginok(@RequestParam("mid") String mid, 
    						@RequestParam("mpass") String mpass,
    						@RequestParam(value = "local_id", required = false) String local_id,
    						HttpServletRequest req,
    						Model m) {
        
        List<MemberDTO> member_dto = ms.login_id(mid);
        if (member_dto.size() == 0) { 
        	this.output=this.js.ok("아이디 및 패스워드를 다시 확인해주세요.","./wmsLogin.jsp");	
        } else {
        	try {
        			StringBuilder repass = secode(mpass); 
		            if (member_dto.get(0).getMpass().equals(repass.toString())) {   
		            	if(!member_dto.get(0).getApprove().equals("근무")) {
		        			this.output=this.js.ok("관리자의 승인이 필요합니다. 센터로 문의해주세요.","./wmsLogin.jsp");
		        		}else {
		                HttpSession session = req.getSession();
		                session.setAttribute("id", member_dto.get(0).getMid());
		                session.setAttribute("name", member_dto.get(0).getMname());
		                session.setAttribute("email", member_dto.get(0).getMemail());      
		                session.setAttribute("mpart", member_dto.get(0).getMpart());      
		                session.setAttribute("mspot", member_dto.get(0).getMspot());
		                session.setAttribute("mhp", member_dto.get(0).getMhp());
		                this.output=this.js.ok("로그인되었습니다. 환영합니다","./wmsMain.do");	
		        		}
		        	}
		            else {  
		                	this.output=this.js.ok("아이디 및 패스워드를 다시 확인해주세요.","./wmsLogin.jsp");
		            }
	        } catch (Exception e) {
	            this.output=this.js.no("데이터 오류로 인하여 다시 시도해 주세요.");
	        	}
	    }
	        m.addAttribute("output", this.output);
	        return "output"; 
	    }
	    
  	@GetMapping("/member/logout.do")
  	public String logout(HttpServletRequest req, 
  						Model m) {

  		HttpSession session = req.getSession();
  		session.removeAttribute("id");
  		session.removeAttribute("name");
  		session.removeAttribute("email");
  		session.removeAttribute("mpart");
  		session.removeAttribute("mspot");
  		session.removeAttribute("mhp");
  		
  		try {
  			if (session.getAttribute("id") == null) {
  				this.output = this.js.ok("로그아웃 되었습니다","./wmsLogin.jsp");	
  			} else {
  			    this.output = this.js.no("로그인 실패! 다시시도해주세요.");
  			}
  		} catch (Exception e) {
  				this.output = this.js.no("시스템 서버 오류로 인하여 다시 시도해주세요.");
  		} 
  		m.addAttribute("output", this.output);
  		return "output";
  	}
}
