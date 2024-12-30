package wms_project.dto;

import org.springframework.stereotype.Repository;

import lombok.Data;

@Data
@Repository("memberdto")
public class MemberDTO {
	int midx;
	String mpart, mspot, mname, mjob, mid, mpass, memail, mhp, approve, mdate;
}
