package wms_project.dto;

import org.springframework.stereotype.Repository;

import lombok.Data;

@Data
@Repository("StorageDTO")
public class StorageDTO {
	int suse;
	String scode, sspot, sname, saddress1, saddress2, smname, smhp, spost;                    
    boolean sdeleted;        // 사용 여부
    String mid;         // 외래 키 (MemberDTO)
    String search;
    String mspot;
}
