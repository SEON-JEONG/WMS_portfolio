package wms_project.controller;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import wms_project.dto.PaletteDTO;
import wms_project.service.PaletteService;

import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class PaletteController {
    @Resource(name="PaletteDTO")
    PaletteDTO pdto;

    @Autowired
    PaletteService ps;

    @Autowired
    HttpSession session;

    PrintWriter pw = null;

//paletteMain.jsp
    //팔레트 메인 페이지 출력 - 로그인한 관리자의 소속 지점에 따른 팔레트 전체 리스트 출력
    @GetMapping("/palette/paletteMain.do")
    public String palette_list(Model m, @RequestParam(value = "search", required = false) String search,
                               @RequestParam(value = "pageno", required = false) Integer pageno){
        String mspot = (String)this.session.getAttribute("mspot");
        System.out.println(search);
        System.out.println(mspot);

        Map<String, Object> paramValue = new HashMap<>();
        paramValue.put("search", search);
        paramValue.put("mspot", mspot);

        int startno = 0;
        int items = 15;
        if(pageno == null){
            pageno = 1;
        } else {
            startno = (pageno-1) * 15;
        }
        paramValue.put("items", items);
        paramValue.put("startno", startno);

        List<PaletteDTO> result = ps.palette_list_paging(paramValue);
        int total = ps.count_palette(paramValue);

        m.addAttribute("all", result);
        m.addAttribute("total", total);
        m.addAttribute("pageno", pageno);
        m.addAttribute("search", search);
        return null;
    }

    //팔레트 수정 페이지 출력
    @GetMapping("/palette/paletteModify.do")
    public String palette_modify(@RequestParam("pidx") String pidx, Model m){
        PaletteDTO paletteDTO = ps.modify_palette(pidx);
        m.addAttribute("paletteDTO", paletteDTO);
        return null;
    }

    //팔레트 수정 완료
    @PostMapping("/palette/palette_modifyok.do")
    public String palette_modifyok(@ModelAttribute PaletteDTO pdto, HttpServletResponse res){
        System.out.println(pdto);
        res.setContentType("text/html;charset=utf-8");
        try {
            this.pw = res.getWriter();
            int result = ps.update_palette(pdto);
            if(result > 0){
                this.pw.print("<script>" +
                        "alert('정상적으로 파렛트가 수정되었습니다.');" +
                        "location.href='/palette/paletteMain.do';" +
                        "</script>");
            }
            else{
                this.pw.print("<script>" +
                        "alert('팔레트 수정에 실패했습니다.\n입력하신 정보를 다시 한 번 확인해주세요.');" +
                        "history.go(-1);" +
                        "</script>");
            }
        } catch (Exception e) {
            this.pw.print("<script>" +
                    "alert('시스템 오류로 인해 수정에 실패했습니다.\n잠시 후 다시 시도해주세요.');" +
                    "history.go(-1);" +
                    "</script>");
        } finally {
            this.pw.close();
        }
        return null;
    }

    //팔레트 삭제하기
    @PostMapping("/palette/palette_delete.do")
    public String delete_palette(@RequestParam("pidx") String pidx, HttpServletResponse res){
        res.setContentType("text/html;charset=utf-8");
        try {
            this.pw = res.getWriter();

            int result = ps.delete_palette(pidx);
            if(result > 0){
                this.pw.print("<script>" +
                        "alert('해당 팔레트가 성공적으로 삭제되었습니다.');" +
                        "location.href='/palette/paletteMain.do';" +
                        "</script>");
            }
            else{
                this.pw.print("<script>" +
                        "alert('삭제에 실패했습니다.\n삭제할 팔레트를 다시 한번 확인하고 잠시 후에 다시 시도해주세요.');" +
                        "history.go(-1);" +
                        "</script>");
            }
        } catch (Exception e) {
            this.pw.print("<script>" +
                    "alert('시스템 오류로 인해 정상적으로 삭제되지 않았습니다.\n잠시 후에 다시 시도해주세요.');" +
                    "history.go(-1);" +
                    "</script>");
        } finally {
            this.pw.close();
        }
        return null;
    }

    //팔레트 등록 이름 중복 검사
    @CrossOrigin("*")
    @PostMapping("/palette/pnameCheckOk.do")
    public String pnameCheckOk(@RequestParam("pname") String pname, HttpServletResponse res){
        res.setContentType("text/html;charset=utf-8");
        try {
            this.pw = res.getWriter();
            String result = "";

            if(pname.equals("")) {
                System.out.println("빈 값");
            }
            else {
                result = ps.pname_check(pname);
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

    //팔레트 등록
    @PostMapping("/palette/palette_insertok.do")
    public String insert_ok(@ModelAttribute PaletteDTO pdto, HttpServletResponse res){
        res.setContentType("text/html;charset=utf-8");
        String mspot = (String)this.session.getAttribute("mspot");
        try {
            this.pw = res.getWriter();
            Map<String, Object> paramValue = new HashMap<>();
            paramValue.put("pdto", pdto);
            paramValue.put("mspot", mspot);
            int result = ps.insert_palette(paramValue);
            if(result > 0){
                this.pw.print("<script>" +
                        "alert('정상적으로 파렛트가 등록되었습니다.');" +
                        "location.href='/palette/paletteMain.do';" +
                        "</script>");
            }
            else{
                this.pw.print("<script>" +
                        "alert('팔레트 등록에 실패하였습니다.\n입력하신 정보를 다시 한 번 확인해주세요.');" +
                        "history.go(-1);" +
                        "</script>");
            }
        } catch (Exception e) {
            this.pw.print("<script>" +
                    "alert('시스템 오류로 인해 정상적으로 등록되지 않았습니다.\n잠시 후에 다시 시도해주세요.');" +
                    "history.go(-1);" +
                    "</script>");
        } finally {
            this.pw.close();
        }
        return null;
    }


}
