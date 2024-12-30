package wms_project.serviceimp;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import wms_project.dto.MobileDTO;
import wms_project.mapper.MobileMapper;
import wms_project.service.MobileService;

@Service
public class MobileServiceImp implements MobileService {

	@Autowired
	private MobileMapper mm;
	
	@Override
	public List<MobileDTO> MobileLogin(String deliver_id) {
		List<MobileDTO> result = mm.MobileLogin(deliver_id);
		return result;
	};
	
	@Override
	public List<MobileDTO> MobileList(Map<String, Object> list) {
		List<MobileDTO> result = mm.MobileList(list);
		return result;
	};
	
	@Override
	public List<MobileDTO> QrCk(String tracking) {
		List<MobileDTO> result = mm.QrCk(tracking);
		return result;
	}
	


	@Override
	public int MobileState(MobileDTO dto) {
		int result = mm.MobileState(dto);
		return result;
	};
	
	
	@Override
	public int QrUpdate(MobileDTO dto) {
		int result = mm.QrUpdate(dto);
		return result;
	}
}
