package wms_project.service;

import java.util.List;
import java.util.Map;

import wms_project.dto.DeliveryStateDTO;
import wms_project.mapper.DeliveryStateMapper;

public interface DeliveryStateService {
	public List<DeliveryStateDTO> shipstatus(Map<String, Object> list);
	public int stateCtn(Map<String, Object> ctn);
}
