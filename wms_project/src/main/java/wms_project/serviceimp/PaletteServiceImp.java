package wms_project.serviceimp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import wms_project.dto.PaletteDTO;
import wms_project.mapper.PaletteMapper;
import wms_project.service.PaletteService;

import java.util.List;
import java.util.Map;

@Service
public class PaletteServiceImp implements PaletteService {
    @Autowired
    PaletteMapper pm;

    //로그인한 관리자의 소속 지점에 따른 팔레트 전체 리스트 출력
    @Override
    public List<PaletteDTO> palette_list(String mspot) {
        List<PaletteDTO> result = pm.palette_list(mspot);
        return result;
    }

    //검색한 팔레트 리스트 출력
    @Override
    public List<PaletteDTO> search_palette(String mspot, String search) {
        List<PaletteDTO> result = pm.search_palette(mspot, search);
        return result;
    }

    //페이징 + 팔레트 리스트 출력
    @Override
    public List<PaletteDTO> palette_list_paging(Map<String, Object> paramValue) {
        List<PaletteDTO> result = pm.palette_list_paging(paramValue);
        return result;
    }

    //지점에 따른 전체 팔레트 개수
    @Override
    public int count_palette(Map<String, Object> paramValue) {
        int result = pm.count_palette(paramValue);
        return result;
    }

    //팔레트 수정 페이지 출력
    @Override
    public PaletteDTO modify_palette(String pidx) {
        PaletteDTO paletteDTO = pm.modify_palette(pidx);
        return paletteDTO;
    }

    //팔레트 수정 완료
    @Override
    public int update_palette(PaletteDTO paletteDTO) {
        int result = pm.update_palette(paletteDTO);
        return result;
    }

    //팔레트 삭제
    @Override
    public int delete_palette(String pidx) {
        int result = pm.delete_palette(pidx);
        return result;
    }

    //팔레트명 중복 검사
    @Override
    public String pname_check(String pname) {
        String result = pm.pname_check(pname);
        return result;
    }

    //신규 팔레트 등록
    @Override
    public int insert_palette(Map<String, Object> paramValue) {
        int result = pm.insert_palette(paramValue);
        return result;
    }
}
