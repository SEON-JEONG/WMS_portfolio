package wms_project.service;

import java.util.List;
import java.util.Map;

import wms_project.dto.DeliveryShipDTO;

public interface DeliveryShipService {
	public List<DeliveryShipDTO> ShipName();
	public List<DeliveryShipDTO> ShipList(Map<String, Object> list);
	public int ShipCtn(Map<String, Object> ctn);
	public int ShipTracking(DeliveryShipDTO dto);
	public String ShipTR(String aidx);
	public String ShipQR(String aidx);	
	public int QRmake(DeliveryShipDTO dto);
}
