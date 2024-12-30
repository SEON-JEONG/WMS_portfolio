package wms_project.dto;

import org.springframework.stereotype.Repository;

import lombok.Data;

@Data
@Repository("dsdto")
public class   DeliveryShipDTO  {

	int aidx;
	String aordercode, aproductcode, aproduct, acustomer, ahp, addr, account, acode, adeliveryck, date;
	String bstorage, bstoragecode, bpalett, bpalettcode, bapprove;
	String deliveryname, dcode, dspot, dapprove;
	String stracking, sqrimg, sqrurl, shipstate;
	

}
