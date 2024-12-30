package wms_project.service;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.web.multipart.MultipartFile;
import wms_project.dto.ShippingDTO;

import java.util.List;
import java.util.Map;

public interface OrderService {
    //첨부파일 저장
    String file_save(MultipartFile order_file, HttpServletRequest req);
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
