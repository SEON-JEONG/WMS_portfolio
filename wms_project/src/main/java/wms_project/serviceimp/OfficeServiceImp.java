package wms_project.serviceimp;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import wms_project.dto.MemberDTO;
import wms_project.dto.OfficeDTO;
import wms_project.mapper.OfficeMapper;
import wms_project.service.OfficeService;

@Service
public class OfficeServiceImp implements OfficeService{

	@Autowired
    OfficeMapper om;
	
	
	//지점 현황 전체 목록 조회
	@Override
	public List<OfficeDTO> office_list() {
		List<OfficeDTO> all = om.office_list();
		return all;
	}
	
	//검색한 지점 목록 조회
	@Override
	public List<OfficeDTO> search_office(String search) {
		List<OfficeDTO> result = om.search_office(search);
		return result;
	}

	//페이징 + 리스트 조회
	@Override
	public List<OfficeDTO> office_list_paging(Map<String, Object> paramValue) {
		List<OfficeDTO> result = om.office_list_paging(paramValue);
		return result;
	}

	//지점 개수 조회
	@Override
	public Integer count_office(String search) {
		Integer result = om.count_office(search);
		return result;
	}

	//지점 삭제
	@Override
	public int delete_office(String oidx) {
		int result = om.delete_office(oidx);
		return result;
	}
	
	//등록할 지점명 중복 확인
	@Override
	public String check_officename(String officename) {
		String result = om.check_officename(officename);
		return result;
	}
	
	//팝업창 지점 관리자 리스트 출력
	@Override
	public List<MemberDTO> poplist_member() {
		List<MemberDTO> result = om.poplist_member();
		return result;
	}
	
	//관리자 리스트 팝업 관리자 검색
	@Override
	public List<MemberDTO> search_member(Map<String, String> keyword) {
		List<MemberDTO> all = om.search_member(keyword);
		return all;
	}

	//페이징 + 지점 관리자 현황
	@Override
	public List<MemberDTO> poplist_paging(Map<String, Object> paramValue) {
		List<MemberDTO> result = om.poplist_paging(paramValue);
		return result;
	}

	//지점 관리자 수 조회
	@Override
	public int count_member() {
		int result = om.count_member();
		return result;
	}

	//관리자 지정 시 해당 관리자의 정보 가져오기
	@Override
	public List<MemberDTO> apply_member(String midx) {
		List<MemberDTO> result = om.apply_member(midx);
		return result;
	}
	
	//officeInsert 지점 등록하기 버튼 시 적용
	@Override
	public int insert_office(OfficeDTO odto) {
		int result = om.insert_office(odto);
		return result;
	}

	//지점 수정 페이지 출력
	@Override
	public OfficeDTO modify_office(String oidx) {
		OfficeDTO officeDTO = om.modify_office(oidx);
		return officeDTO;
	}

	//지점 정보 수정
	@Override
	public int update_office(OfficeDTO officeDTO) {
		int result = om.update_office(officeDTO);
		return result;
	}
}
