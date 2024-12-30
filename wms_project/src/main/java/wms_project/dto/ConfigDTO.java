package wms_project.dto;

import org.springframework.stereotype.Repository;

import lombok.Data;

@Data
@Repository("ConfigDTO")
public class ConfigDTO {
	int midx;
	String mpart, mspot, mname, mjob, mid, mpass, memail, mhp, approve, mdate;
	
	String part1, part2, part3, search;
}
