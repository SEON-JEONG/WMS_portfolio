package wms_project.service;

import java.util.List;
import java.util.Map;

import jakarta.servlet.http.HttpSession;
import wms_project.dto.DeliveryListDTO;

public interface DeliveryListService {
	public int deliveryInsert(DeliveryListDTO dto);
	public List<DeliveryListDTO> deliveryList(Map<String, Object> params);
	public String deliveryMspotCtn(String mspot);
	public String deliveryCtn();
	public int deliveryApprove(DeliveryListDTO dto);
	public DeliveryListDTO deliveryModifyIdx(String didx);
	public int deliveryModify(DeliveryListDTO dto);
	public DeliveryListDTO approveCk(String dcode);
}
