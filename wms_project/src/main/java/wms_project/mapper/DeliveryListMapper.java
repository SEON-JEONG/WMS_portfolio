package wms_project.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import wms_project.dto.DeliveryListDTO;

@Mapper
public interface DeliveryListMapper {
	public int deliveryInsert(DeliveryListDTO dto);
	public List<DeliveryListDTO> deliveryList(Map<String, Object> params);
	public String deliveryMspotCtn(String mspot);
	public String deliveryCtn();
	public int deliveryApprove(DeliveryListDTO dto);
	public DeliveryListDTO deliveryModifyIdx(String didx);
	public int deliveryModify(DeliveryListDTO dto);
	public DeliveryListDTO approveCk(String dcode);
}
