package wms_project.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import wms_project.dto.MemberDTO;
import wms_project.dto.OfficeDTO;

@Mapper
public interface OfficeMapper {

	public List<OfficeDTO> office_list();
	public List<OfficeDTO> search_office(String search);
	List<OfficeDTO> office_list_paging(Map<String, Object> paramValue);

	Integer count_office(String search);	//전체 지점 개수 / 검색한 지점 개수
	public int delete_office(String oidx);
	public String check_officename(String officename);
	public List<MemberDTO> poplist_member();
	public List<MemberDTO> search_member(Map<String, String> keyword);
	List<MemberDTO> poplist_paging(Map<String, Object> paramValue);	// 페이징 + 지점 관리자 현황
	int count_member();	//지점 관리자 수
	public List<MemberDTO> apply_member(String midx);
	public int insert_office(OfficeDTO odto);
	OfficeDTO modify_office(String oidx);
	//지점 정보 수정
	int update_office(OfficeDTO officeDTO);
}
