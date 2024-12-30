package wms_project.dto;

import org.springframework.stereotype.Repository;

import lombok.Data;

@Data
@Repository("OfficeDTO")
public class OfficeDTO {
	int oidx;
	String officename, mhp, otel, mname, memail, opost, oroad, oaddress, oview;
	
	//검색어
	String search;
}
