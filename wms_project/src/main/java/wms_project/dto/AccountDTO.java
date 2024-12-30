package wms_project.dto;

import org.springframework.stereotype.Repository;

import lombok.Data;

@Data
@Repository("accountdto")
public class AccountDTO {
	int aidx;
	String acode, acompany, aname, aindustry, ahp, anum, atype, afax, apost, aroad, addr, approve, adate, amodify;
	String search;
}
