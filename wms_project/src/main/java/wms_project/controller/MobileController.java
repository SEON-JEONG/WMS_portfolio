package wms_project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import wms_project.dto.MobileDTO;
import wms_project.service.MobileService;

@Controller
public class MobileController implements security {
	@Resource(name="mobiledto")
	MobileDTO dto;
	@Autowired
	MobileService ms;
	
	String output = null;
	javascript js = new javascript();
	
	@PostMapping("/deliveryMobile/mobileLoginOk.do")
	public String mobileLoginOk(
			@RequestParam(value = "deliver_id", required = false) String deliver_id,
			@RequestParam(value = "deliver_pw", required = false) String deliver_pw,
			HttpServletRequest req,
			Model m) {
		System.out.println(deliver_id);
		System.out.println(deliver_pw);
		
		List<MobileDTO> result = ms.MobileLogin(deliver_id);
		if(result.size() == 0) {
			this.output=this.js.ok("기사님 사원번호 및 패스워드를 다시 확인해주세요.","./mobileLogin.jsp");	
		}
		else {
			try {
				StringBuilder repass = secode(deliver_pw);
				if(result.get(0).getDpass().equals(repass.toString())) {
					
					
					if(!result.get(0).getDapprove().equals("근무중")) {
						System.out.println("배송기사 상태는? : " + result.get(0).getDapprove());
						this.output=this.js.ok("현재 [근무중] 인 기사님만 로그인이 가능합니다.\\n관리자 센터로 문의해주세요.","./mobileLogin.jsp");
					}
					else {
						HttpSession session = req.getSession();
						session.setAttribute("dcode", result.get(0).getDcode());
						session.setAttribute("name", result.get(0).getDname());
						session.setAttribute("email", result.get(0).getDemail());
						session.setAttribute("spot", result.get(0).getDspot());
						session.setAttribute("hp", result.get(0).getDhp());
						session.setAttribute("approve", result.get(0).getDapprove());
						this.output=this.js.ok("로그인되었습니다. 안전운전하세요!","./mobileMain.do");	
					}
				}
				else {
						this.output=this.js.ok("사원번호 및 패스워드를 다시 확인해주세요.","./mobileLogin.jsp");
				}
				
			} catch (Exception e) {
				this.output=this.js.no("데이터 오류로 인하여 다시 시도해 주세요.");
			}
		}
		m.addAttribute("output", this.output);
        return "output"; 
	}
	
	
	@GetMapping("/deliveryMobile/logout.do")
  	public String logout(HttpServletRequest req, 
  						Model m) {

  		HttpSession session = req.getSession();
  		session.removeAttribute("dcode");
  		session.removeAttribute("name");
  		session.removeAttribute("email");
  		session.removeAttribute("spot");
  		session.removeAttribute("hp");
  		session.removeAttribute("approve");
  		
  		try {
  			if (session.getAttribute("dcode") == null) {
  				this.output = this.js.ok("로그아웃 되었습니다","./mobileLogin.jsp");	
  			} else {
  			    this.output = this.js.no("로그인에 실패하였습니다. 다시시도해주세요.");
  			}
  		} catch (Exception e) {
  				this.output = this.js.no("시스템 서버 오류로 인하여 다시 시도해주세요.");
  		} 
  		m.addAttribute("output", this.output);
  		return "output";
  	}
	
	
	
	@GetMapping("/deliveryMobile/mobileMain.do")
	public String mobileMain(
			HttpServletRequest req,
			Model m) {
		
		Map<String, Object> list = new HashMap<>();
		
		
		List<MobileDTO> result = ms.MobileList(list);
		m.addAttribute("result", result);
		
		return null;
	}
	
	
	@GetMapping("deliveryShip/QrCheck.do")
	public String QrCheck(
			@RequestParam(value = "tracking", required = false) String tracking,
			Model m) {
		System.out.println("파라미터값 : " +tracking);
		
		//파라미터 값없을때!!
		if(tracking.equals("")) {
			this.output = this.js.ok("비정상적인 접근입니다.\\n배송기사 모바일 전용 페이지를 이용해주세요.","/deliveryMobile/mobileLogin.jsp");
		}
		else {
			
			//얼럿에 같이 출력할애!!
	        List<MobileDTO> md = ms.QrCk(tracking);
	        if (md != null && !md.isEmpty()) {
	            // 예시로 첫 번째 결과의 값들을 출력
	        	//System.out.println("shipstate: " + md.get(0).getShipstate());
	            //System.out.println("aordercode: " + md.get(0).getAordercode());
	            //System.out.println("acustomer: " + md.get(0).getAcustomer());
	            //System.out.println("ahp: " + md.get(0).getAhp());
	            //System.out.println("addr: " + md.get(0).getAddr());
	            //System.out.println("shipstate: " + md.get(0).getShipstate());
	            //System.out.println("mobileck: " + md.get(0).getMobileck());
	            //System.out.println("stracking: " + md.get(0).getStracking());
	            
	            if(!md.get(0).getShipstate().equals("대기") || !md.get(0).getMobileck().equals("대기")) {
	            	this.output = this.js.ok("[배송정보]\\n운송장번호 : ["+md.get(0).getStracking()+"]\\n고객명 : "+md.get(0).getAcustomer()+"\\n연락처 : "+md.get(0).getAhp()+"\\n주소 : "+md.get(0).getAddr()+"\\n\\n배송상태는 이미 [ "+md.get(0).getShipstate() +" ] 이며,\\n▷ 배송현황 업데이트가 불가능합니다.", "/deliveryMobile/mobileLogin.jsp");
	            }
	            else {
	            	 dto.setTracking(tracking);
	 	            try {
	 	            	int result = ms.QrUpdate(dto);
	 	            
	 	            	if(result > 0) {
	 	            		System.out.println("result 값 : " +result);
	 	            		this.output = this.js.ok("[배송정보]\\n운송장번호 : "+md.get(0).getStracking()+"\\n고객명 : "+md.get(0).getAcustomer()+"\\n연락처 : "+md.get(0).getAhp()+"\\n주소 : "+md.get(0).getAddr()+"\\n\\n▷ 배송을 시작합니다.","/deliveryMobile/mobileLogin.jsp");
	 	            	}
	 	            	else {
	 	            		this.output = this.js.ok("QR코드 오류입니다.\\n다시 시도해주세요.","/deliveryMobile/mobileLogin.jsp");
	 	            	}
	 					
	 				} catch (Exception e) {
	 					e.printStackTrace();
	 					this.output = this.js.ok("QR코드 스캔 오류입니다.\\n다시 시도해주세요.","/deliveryMobile/mobileLogin.jsp");
	 				}
	            }
	        } else {
	        	this.output = this.js.ok("비정상적인 QR코드 입니다.\\n관리자에게 문의해주세요.","/deliveryMobile/mobileLogin.jsp");
	        }
	    }
		
		m.addAttribute("output", this.output);
  		return "output";
	}
	
	
	
	@PostMapping("/deliveryMobile/mobileState.do")
	public String mobileState(
			@RequestParam(value = "state", required = false) String state,
			@RequestParam(value = "tracking", required = false) String tracking,
			@RequestParam(value = "img", required = false) MultipartFile img,
			Model m) {
		System.out.println("state : " + state);
		System.out.println("tracking: " + tracking);
		
		
		if(tracking.equals("")) {
			this.output = this.js.ok("비정상적인 접근입니다.\\n배송기사 모바일 전용 페이지를 이용해주세요.","/deliveryMobile/mobileLogin.jsp");
		}
		else {
			//얼럿에 같이 출력할애!!
	        List<MobileDTO> md = ms.QrCk(tracking);
	        if (md != null && !md.isEmpty()) {
	            // 예시로 첫 번째 결과의 값들을 출력
	        	System.out.println("1.shipstate: " + md.get(0).getShipstate());
	            System.out.println("2.aordercode: " + md.get(0).getAordercode());
	            System.out.println("3.acustomer: " + md.get(0).getAcustomer());
	            System.out.println("4.ahp: " + md.get(0).getAhp());
	            System.out.println("5.addr: " + md.get(0).getAddr());
	            System.out.println("6.shipstate: " + md.get(0).getShipstate());
	            System.out.println("7.mobileck: " + md.get(0).getMobileck());
	            System.out.println("8.stracking: " + md.get(0).getStracking());
		
	            
	       if(state.equals("대기")) {
	    	  dto.setState("배송중");
	    	  dto.setSts("배송중");
	    	  dto.setTracking(tracking);
	       }
	       else if(state.equals("배송중")) {
	    	  dto.setState("촬영하기");
	    	  dto.setSts("배송중");
	    	  dto.setTracking(tracking);
	       }
	       else if(state.equals("촬영하기")) {
	    	   dto.setState("완료하기");
	    	   dto.setSts("배송완료");
	    	   dto.setTracking(tracking);
	       }
	       else if(state.equals("완료하기")) {
	    	   dto.setState("N");
	    	   dto.setSts("배송완료");
	    	   dto.setTracking(tracking);
	       }
	      
	       
			
			try {
				int result = ms.MobileState(dto);
				if(result > 0) {
					
					if(state.equals("대기")) {
						this.output = this.js.ok("[배송정보]\\n운송장번호 : "+md.get(0).getStracking()+"\\n고객명 : "+md.get(0).getAcustomer()+"\\n연락처 : "+md.get(0).getAhp()+"\\n주소 : "+md.get(0).getAddr()+"\\n\\n▷ 배송상태가 [ "+dto.getState() +" ] 로 변경되었습니다.", "/deliveryMobile/mobileMain.do");
					}
					else if(state.equals("배송중")) {
						this.output = this.js.ok("[배송정보]\\n운송장번호 : "+md.get(0).getStracking()+"\\n고객명 : "+md.get(0).getAcustomer()+"\\n연락처 : "+md.get(0).getAhp()+"\\n주소 : "+md.get(0).getAddr()+"\\n\\n▷ 배송을 완료하셨다면 사진촬영을 해주세요.", "/deliveryMobile/mobileMain.do");
					}
					else if(state.equals("촬영하기")) {
							this.output = this.js.ok("[배송정보]\\n운송장번호 : "+md.get(0).getStracking()+"\\n고객명 : "+md.get(0).getAcustomer()+"\\n연락처 : "+md.get(0).getAhp()+"\\n주소 : "+md.get(0).getAddr()+"\\n\\n▷ 배송이 완료되었습니다!", "/deliveryMobile/mobileMain.do");
					
					}
				
				}
				else {
					System.out.println("실패");
				}
			} catch (Exception e) {
				System.out.println("DB 오류");
			}
	    }	
     }//list end
		
		
		
	  m.addAttribute("output", this.output);
	  return "output";
	}
	
	
}
