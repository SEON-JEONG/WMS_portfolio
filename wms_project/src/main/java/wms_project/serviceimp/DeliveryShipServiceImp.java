package wms_project.serviceimp;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import wms_project.dto.DeliveryShipDTO;
import wms_project.mapper.DeliveryShipMapper;
import wms_project.service.DeliveryShipService;

@Service
public class DeliveryShipServiceImp implements DeliveryShipService {
	
	@Autowired
	private DeliveryShipMapper dsm;
	
	@Override
	public List<DeliveryShipDTO> ShipName() {
		List<DeliveryShipDTO> dsnm = dsm.ShipName();
		return dsnm;
	};
	
	@Override
	public List<DeliveryShipDTO> ShipList(Map<String, Object> list) {
		List<DeliveryShipDTO> result = dsm.ShipList(list);
		return result;
	};
	
	@Override
	public int ShipCtn(Map<String, Object> ctn) {
		int result = dsm.ShipCtn(ctn);
		return result;
	}
	;
	@Override
	public int ShipTracking(DeliveryShipDTO dto) {
		int result = dsm.ShipTracking(dto);
		return result;
	};
	
	@Override
	public String ShipTR(String aidx) {
		String result = dsm.ShipTR(aidx);
		return result;
	};
	
	@Override
	public String ShipQR(String aidx){
		String result = dsm.ShipQR(aidx);
		return result;
	};
	
	@Override
	public int QRmake(DeliveryShipDTO dto) {
		int result = dsm.QRmake(dto);
		return result;
	};
}
