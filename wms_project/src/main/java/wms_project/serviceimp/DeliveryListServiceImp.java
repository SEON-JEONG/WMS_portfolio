package wms_project.serviceimp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import wms_project.controller.AccountController;
import wms_project.controller.DeliveryListController;
import wms_project.dto.DeliveryListDTO;
import wms_project.mapper.DeliveryListMapper;
import wms_project.service.DeliveryListService;

@Service
public class DeliveryListServiceImp implements DeliveryListService{

	@Autowired
	private DeliveryListMapper dm;
	
	@Override
	public int deliveryInsert(DeliveryListDTO dto) {
		int result = dm.deliveryInsert(dto);
		return result;
	};

	@Override
	public List<DeliveryListDTO> deliveryList(Map<String, Object> paramValue) {
		List<DeliveryListDTO> result = dm.deliveryList(paramValue);
		return result;
	};

	@Override
	public String deliveryMspotCtn(String mspot) {
		return dm.deliveryMspotCtn(mspot);
	};
	
	@Override
	public String deliveryCtn() {
		String result = dm.deliveryCtn();
		
		return result;
	};

	@Override
	public int deliveryApprove(DeliveryListDTO dto) {
		int result = dm.deliveryApprove(dto);
		return result;
	};


	@Override
	public DeliveryListDTO deliveryModifyIdx(String didx) {
		DeliveryListDTO ddto = dm.deliveryModifyIdx(didx);
		return ddto;
	};

	@Override
	public int deliveryModify(DeliveryListDTO dto) {
		int result = dm.deliveryModify(dto);
		return result;
	};
	
	@Override
	public DeliveryListDTO approveCk(String dcode) {
		DeliveryListDTO result = dm.approveCk(dcode);
		return result;
	}
}
