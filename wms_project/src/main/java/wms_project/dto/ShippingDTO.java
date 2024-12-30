package wms_project.dto;

import lombok.Data;
import org.springframework.stereotype.Repository;

@Data
@Repository("ShippingDTO")
public class ShippingDTO {
    //orderMain.jsp 오더 등록 페이지
    int aidx;   //주문 번호
    String aordercode, aproductcode, aproduct;
    String acustomer, ahp, addr;
    String account, acode;
    String adeliveryck, date;

    //shipmentMain.jsp 배송 선택(본사, 지점) 페이지
    String bstorage, bstoragecode, bpalett, bpalettcode, bapprove;

    //StoreDelivery.jsp 배송 기사 배정 페이지
    String deliveryname, dcode, dspot, dapprove;

    //shippingDelivery.jsp 배송현황 및 운송장 출력 페이지
    String stracking, sqrimg, sqrurl, shipstate;
}
