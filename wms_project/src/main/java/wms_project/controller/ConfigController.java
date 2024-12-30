package wms_project.controller;
	
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import wms_project.dto.ConfigDTO;
import wms_project.service.ConfigService;
	
@Controller
public class ConfigController {
	
	
	String output = null;
	javascript js = new javascript();
	
	
	@Autowired
	ConfigService cs;
	
	
	@GetMapping("/config/configMain.do")
    public String showMembers(@RequestParam(value = "pageno",required = false) Integer pageno, @RequestParam(value = "part1",required = false) String part1, @RequestParam(value = "part2",required = false) String part2, @RequestParam(value = "search",required = false) String search, Model m) {
        // 전체 멤버 가져오기
       ConfigDTO configdto = new ConfigDTO();
       Map<String, Object> params = new HashMap<>();
       int total =0;
       int startno = 0;
       int items = 15;
       List<ConfigDTO> members = null;
       params.put("items", items);
       System.out.println("pageno"+pageno);      
       if(pageno == null) {
    	   startno = 0;
    	   pageno = 1;
       }else {
		startno = (pageno-1) * 15;
       }
      
       params.put("startno", startno);
       
       if(search == null) {
    	
    	   total = cs.Total(configdto);
                      
       members = cs.searchall(params);
       }
       else {
    	
       params.put("part1",part1);
       params.put("part2",part2);
       params.put("search",search);
       
       members = cs.all(params);
       total = cs.totalsearch(params);
       }
       
        m.addAttribute("total", total); // 전체 멤버 수
        m.addAttribute("pageno", pageno); // 현재 페이지 번호
        m.addAttribute("members", members); // 모델에 추가
        m.addAttribute("part1", part1);   
        m.addAttribute("part2", part2); 
        m.addAttribute("search", search); 
        return null; // JSP 페이지 이름 반환
    }
	
	
	
	
	@PostMapping("/config/update.do")
    public String getMethodName(@RequestParam("part3") String part3, 
                                 @RequestParam("midx") int midx,
                                 Model m) {
        try {
            // ConfigDTO 객체 생성 및 값 설정
            ConfigDTO configDTO = new ConfigDTO();
            configDTO.setPart3(part3); // part3 값 설정
            configDTO.setMidx(midx);   // midx 값 설정

            // update1 메서드 호출
            int result = cs.update1(configDTO);

            if (result > 0) {
                this.output = this.js.no("변경 되었습니다.");
               
            } else {
                this.output = this.js.no("관리자 계정은 변경할 수 없습니다.");
            }
        } catch (Exception e) {
            System.out.println("변경 실패");
            e.printStackTrace(); // 예외 스택 트레이스 출력
        }

        m.addAttribute("output", output);
		return "output";
    }
	
	
}
