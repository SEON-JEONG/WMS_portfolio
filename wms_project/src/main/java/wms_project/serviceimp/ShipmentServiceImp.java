package wms_project.serviceimp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import wms_project.dto.ProductDTO;
import wms_project.dto.ShippingDTO;
import wms_project.mapper.ShipmentMapper;
import wms_project.service.ShipmentService;

import java.util.List;
import java.util.Map;

@Service
public class ShipmentServiceImp implements ShipmentService {
    @Autowired
    ShipmentMapper sm;

    //오더 리스트 출력
    @Override
    public List<ShippingDTO> shipment_list(Map<String, Object> paramValue) {
        List<ShippingDTO> result = sm.shipment_list(paramValue);
        return result;
    }

    //물품 검색 팝업 상품 리스트 출력
    @Override
    public List<ProductDTO> product_list(Map<String, Object> paramValue) {
        List<ProductDTO> result = sm.product_list(paramValue);
        return result;
    }

    //물품 검색 팝업 물품 적용
    @Override
    public ProductDTO apply_product(String pdidx) {
        ProductDTO result = sm.apply_product(pdidx);
        return result;
    }

    //물품 창고명, 팔레트명 저장
    @Override
    public int save_shipment(Map<String, Object> paramValue) {
        int result = sm.save_shipment(paramValue);
        return result;
    }

    //물품 삭제
    @Override
    public int delete_shipment(String aidx) {
        int result = sm.delete_shipment(aidx);
        return result;
    }

    //등록된 오더 개수
    @Override
    public int count_shipment(Map<String, Object> paramValue) {
        int result = sm.count_shipment(paramValue);
        return result;
    }

    //팝업 물품 개수
    @Override
    public int count_product(Map<String, Object> paramValue) {
        int result = sm.count_product(paramValue);
        return result;
    }
}
