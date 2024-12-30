package wms_project.service;

import java.util.List;

import wms_project.dto.MemberDTO;

public interface MemberService {
	public int member_join(MemberDTO dto);
	public String search_id(String mid);
	public List<MemberDTO> login_id(String mid);
}
