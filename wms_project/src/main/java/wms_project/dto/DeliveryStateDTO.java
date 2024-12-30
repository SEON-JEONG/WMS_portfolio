package wms_project.dto;

import org.springframework.stereotype.Repository;

import lombok.Data;

@Data
@Repository("deliverystatedto")

public class DeliveryStateDTO {
	String didx,dcode,dname,dhp,dspot,dapprove,deliveredctn,lostctn;
}
