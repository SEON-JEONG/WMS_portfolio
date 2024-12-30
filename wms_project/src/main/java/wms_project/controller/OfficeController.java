package wms_project.controller;

import java.io.PrintWriter;
import java.util.Base64.Decoder;
import java.util.HashMap;
import java.util.Base64;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.annotation.Resource;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletResponse;
import wms_project.dto.MemberDTO;
import wms_project.dto.OfficeDTO;
import wms_project.service.OfficeService;

@Controller
public class OfficeController {
    PrintWriter pw = null;

    @Resource(name = "OfficeDTO")
    OfficeDTO odto;

    @Autowired
    OfficeService os;

    //officeMain.jsp Controller
    //전체 지점 현황 페이지 출력 / 검색어 있는 경우 검색어에 해당하는 리스트 출력
    @GetMapping("/office/officeMain.do")
    public String office_main(Model m, @RequestParam(value = "search", required = false) String search,
                              @RequestParam(value = "pageno", required = false) Integer pageno) {
        int startno = 0;    //글 시작 번호
        int items = 15;     //한 페이지에 출력될 행 개수
        if(pageno == null){
            pageno = 1;
        } else {
            startno = (pageno-1) * 15;
        }

        //mapper로 보내기 위한 글 시작 번호, 한 페이지에 출력할 글 개수, 검색어 Map에 추가
        Map<String, Object> paramValue = new HashMap<>();
        paramValue.put("startno", startno);
        paramValue.put("items", items);
        paramValue.put("search", search);

        List<OfficeDTO> all = os.office_list_paging(paramValue);
        int total = os.count_office(search);      //전체 글 개수

        m.addAttribute("all", all);
        m.addAttribute("total", total);
        m.addAttribute("pageno", pageno);
        m.addAttribute("search", search);
        return null;
    }

    //지점 삭제
    @GetMapping("/office/office_delete.do")
    public String office_delete(@RequestParam("oidx") String oidx, @RequestParam("key") String key, ServletResponse res) {
        res.setContentType("text/html;charset=utf-8");
        try {
            this.pw = res.getWriter();

            Decoder decoder = Base64.getDecoder();
            byte[] keycheck = decoder.decode(key);
            String keycode = new String(keycheck);
            if (keycode.equals("wms.test")) {
                byte[] oidxcheck = decoder.decode(oidx);
                String no = new String(oidxcheck);
                int result = os.delete_office(no);
                if (result > 0) {
                    this.pw.print("<script>"
                            + "alert('해당 지점이 삭제 되었습니다.');"
                            + "location.href='./officeMain.do';"
                            + "</script>");
                } else {
                    this.pw.print("<script>"
                            + "alert('해당 게시물의 정보가 올바르지 않습니다.');"
                            + "location.href='./officeMain.do';"
                            + "</script>");
                }
            } else {
                this.pw.print("<script>"
                        + "alert('해당 페이지에 접근이 잘 못 되었습니다.');"
                        + "history.go(-1);"
                        + "</script>");
            }
        } catch (Exception e) {
            System.out.println("삭제 실패");
            System.out.println(e.getMessage());
        } finally {
            this.pw.close();
        }
        return null;
    }


//officeInsert.jsp Controller

    //등록할 지점 중복 검사
    @CrossOrigin("*")    //AJAX CORS 방지
    @PostMapping("/office/officenameCheck.do")
    public String oname_check(@RequestParam("officename") String officename, HttpServletResponse res) {
        res.setContentType("text/html;charset=utf-8");
        try {
            this.pw = res.getWriter();
            String result = "";

            if (officename.equals("")) {
                System.out.println("빈 값");
            } else {
                result = os.check_officename(officename);
                this.pw.print(result);
            }
        } catch (Exception e) {
            this.pw.print("<script>"
                    + "alert('서버가 불안정합니다. 잠시 후에 다시 시도 해주세요.');"
                    + "history.go(-1);"
                    + "</script>");
        } finally {
            this.pw.close();
        }
        return null;
    }

    //지점 등록
    @GetMapping("/office/officeInsert.do")
    public String office_insert(@ModelAttribute OfficeDTO officeDTO, ServletResponse res) {
        res.setContentType("text/html;charset=utf-8");
        try {
            this.pw = res.getWriter();

            int result = os.insert_office(officeDTO);
            if (result > 0) {
                this.pw.print("<script>"
                        + "alert('해당 지점이 등록 되었습니다.');"
                        + "location.href='./officeMain.do';"
                        + "</script>");
            } else {
                this.pw.print("<script>"
                        + "alert('게시물 등록에 실패하였습니다.\n입력한 정보를 다시 한 번 확인해주세요.');"
                        + "history.go(-1);"
                        + "</script>");
            }
        } catch (Exception e) {
            System.out.println("지점 등록 실패");
            System.out.println(e.getMessage());
        } finally {
            this.pw.close();
        }
        return null;
    }


    //officePopList.jsp Controller
    //지점 관리자 목록 출력
    @GetMapping("/office/officePopList.do")
    public String office_poplist(@RequestParam(value = "part", required = false) String part,
                                 @RequestParam( value = "search", required = false) String search,
                                 @RequestParam(value = "pageno", required = false) Integer pageno,
                                 Model m) {
        int total = os.count_member();
        int startno = 0;
        int items = 15;
        if(pageno == null){
            pageno = 1;
        } else {
            startno = (pageno - 1) * 15;
        }
        Map<String, Object> paramValue = new HashMap<>();
        paramValue.put("items", items);
        paramValue.put("startno", startno);
        paramValue.put("part", part);
        paramValue.put("search", search);

        List<MemberDTO> all = os.poplist_paging(paramValue);

        m.addAttribute("all", all);
        m.addAttribute("total", total);
        m.addAttribute("pageno", pageno);
        m.addAttribute("part", part);
        m.addAttribute("search", search);
        return null;
    }

    //관리자 적용 버튼 클릭 시 insert
    @CrossOrigin("*")
    @PostMapping("/office/officeInsert.do")
    @ResponseBody
    public Map<String, String> apply_member(@RequestParam("midx") String midx) {
        Map<String, String> response = new HashMap<>();
        try {
            if (midx.isEmpty()) {
                response.put("error", "해당 관리자는 적용이 불가능합니다. 다른 관리자를 확인해주세요.");
            } else {
                List<MemberDTO> result = os.apply_member(midx);
                if (result == null) {
                    response.put("error", "적용할 수 없는 관리자 입니다. 관리자 현황을 다시 한 번 확인해주세요.");
                } else {
                    MemberDTO member = result.get(0);
                    response.put("mname", member.getMname());
                    response.put("mhp", member.getMhp());
                    response.put("memail", member.getMemail());
                }
            }
        } catch (Exception e) {
            response.put("error", "서버가 불안정합니다. 잠시 후 다시 이용해주세요.");
        }
        return response;
    }


    //officeModify.jsp
    @GetMapping("/office/officeModify.do")
    public String office_modify(@RequestParam("oidx") String oidx, Model m) {
        OfficeDTO officeDTO = os.modify_office(oidx);
        m.addAttribute("officeDTO", officeDTO);
        return null;
    }

    @PostMapping("/office/office_modifyok.do")
    public String update_office(@ModelAttribute OfficeDTO officeDTO, HttpServletResponse res) {
        res.setContentType("text/html;charset=utf-8");
        try {
            this.pw = res.getWriter();
            int result = os.update_office(officeDTO);
            if (result > 0) {
                this.pw.print("<script>" +
                        "alert('지점 정보 수정이 완료되었습니다.');" +
                        "location.href='/office/officeMain.do';" +
                        "</script>");
            } else {
                this.pw.print("<script>" +
                        "alert('지점 정보 수정에 실패했습니다.\n입력하신 정보를 다시 한 번 확인해주세요.');" +
                        "history.go(-1);" +
                        "</script>");
            }
        } catch (Exception e) {
            this.pw.print("<script>" +
                    "alert('시스템 오류로 인해 지점 수정에 실패했습니다.\n잠시 후 다시 시도해주세요.');" +
                    "history.go(-1);" +
                    "</script>");
        } finally {
            this.pw.close();
        }
        return null;
    }
}
