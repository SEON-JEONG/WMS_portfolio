package wms_project.service;

import wms_project.dto.ProductDTO;
import wms_project.dto.ShippingDTO;

import java.util.List;
import java.util.Map;

public interface ShipmentService {
    //오더 리스트 출력
    List<ShippingDTO> shipment_list(Map<String, Object> paramValue);
    //물품 검색 팝업 상품 리스트 출력
    List<ProductDTO> product_list(Map<String, Object> paramValue);
    //물품 검색 팝업 물품 적용
    ProductDTO apply_product(String pdidx);
    //물품 창고명, 팔레트명 저장
    int save_shipment(Map<String, Object> paramValue);
    //물품 삭제
    int delete_shipment(String aidx);
    //등록된 오더 개수
    int count_shipment(Map<String, Object> paramValue);
    //팝업 물품 개수
    int count_product(Map<String, Object> paramValue);
}
