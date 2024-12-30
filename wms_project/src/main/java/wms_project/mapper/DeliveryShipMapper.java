package wms_project.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import wms_project.dto.DeliveryShipDTO;
import wms_project.dto.MobileDTO;

@Mapper
public interface DeliveryShipMapper {

	
	public List<DeliveryShipDTO> ShipName();
	public List<DeliveryShipDTO> ShipList(Map<String, Object> list);
	public int ShipCtn(Map<String, Object> ctn);
	public int ShipTracking(DeliveryShipDTO dto);
	public String ShipTR(String aidx);
	public String ShipQR(String aidx);
	public int QRmake(DeliveryShipDTO dto);
}
