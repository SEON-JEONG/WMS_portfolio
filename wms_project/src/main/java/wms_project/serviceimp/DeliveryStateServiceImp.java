package wms_project.serviceimp;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import wms_project.dto.DeliveryStateDTO;
import wms_project.mapper.DeliveryStateMapper;
import wms_project.service.DeliveryStateService;

@Service
public class DeliveryStateServiceImp implements DeliveryStateService {

	@Autowired
	private DeliveryStateMapper dssm;
	
	@Override
	public List<DeliveryStateDTO> shipstatus(Map<String, Object> list){
		List<DeliveryStateDTO> result = dssm.shipstatus(list);
		return result;
	};
	
	@Override
	public int stateCtn(Map<String, Object> ctn) {
		int result = dssm.stateCtn(ctn);
		return result;
	};
}
