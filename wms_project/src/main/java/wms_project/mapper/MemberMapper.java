package wms_project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import wms_project.dto.MemberDTO;

@Mapper
public interface MemberMapper {
	int member_join(MemberDTO dto);
	String search_id(String mid);
	List<MemberDTO> login_id(String mid);
}
