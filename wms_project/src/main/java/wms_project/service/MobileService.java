package wms_project.service;

import java.util.List;
import java.util.Map;

import wms_project.dto.DeliveryShipDTO;
import wms_project.dto.MobileDTO;

public interface MobileService {
	public List<MobileDTO> MobileLogin(String deliver_id);
	public List<MobileDTO> MobileList(Map<String, Object>list);
	public List<MobileDTO> QrCk(String tracking);
	public int QrUpdate(MobileDTO dto);
	public int MobileState(MobileDTO dto);
}
