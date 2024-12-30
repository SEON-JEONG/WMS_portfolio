package wms_project.mapper;

import org.apache.ibatis.annotations.Mapper;
import wms_project.dto.ShippingDTO;

import java.util.List;
import java.util.Map;

@Mapper
public interface OrderMapper {
    //첨부파일 내용 insert
    int insert_order(ShippingDTO sdto);
    //주문 등록 리스트
    List<ShippingDTO> order_list(Map<String, Object> paramValue);
    //등록 주문 개수
    int order_count(Map<String, Object> paramValue);
    //등록된 주문 거래처 종류
    List<String> account_list();
    //주문 삭제
    int delete_order(String aidx);

}
