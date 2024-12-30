package wms_project.dto;

import org.springframework.stereotype.Repository;

import lombok.Data;

@Data
@Repository("mobiledto")
public class MobileDTO {

	int didx;
	String dspot, demail, dhp, dcode, dname, dpass, dimgck, dapprove;
	String aordercode, acustomer, ahp, addr, adeliveryck, bapprove;
	String b_dcode, d_approve, stracking, shipstate, mobileck;
	String state,idx,sts,tracking;
}
