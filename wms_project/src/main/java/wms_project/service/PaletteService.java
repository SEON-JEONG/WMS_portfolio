package wms_project.service;

import wms_project.dto.PaletteDTO;

import java.util.List;
import java.util.Map;

public interface PaletteService {
    //로그인한 관리자의 소속 지점에 따른 팔레트 전체 리스트 출력
    List<PaletteDTO> palette_list(String mspot);
    //검색한 팔레트 리스트 출력
    List<PaletteDTO> search_palette(String mspot, String search);
    //페이징 + 팔레트 리스트 출력
    List<PaletteDTO> palette_list_paging(Map<String, Object> paramValue);
    //지점에 따른 전체 팔레트 개수
    int count_palette(Map<String, Object> paramValue);
    //팔레트 수정 페이지 출력
    PaletteDTO modify_palette(String pidx);
    //팔레트 수정 완료
    int update_palette(PaletteDTO paletteDTO);
    //팔레트 삭제
    int delete_palette(String pidx);
    //팔레트명 중복 검사
    String pname_check(String pname);
    //신규 팔레트 등록
    int insert_palette(Map<String, Object> paramValue);
}
