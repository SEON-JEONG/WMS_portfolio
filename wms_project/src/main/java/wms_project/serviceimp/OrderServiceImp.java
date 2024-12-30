package wms_project.serviceimp;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import wms_project.dto.ShippingDTO;
import wms_project.mapper.OrderMapper;
import wms_project.service.OrderService;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class OrderServiceImp implements OrderService {

    @Autowired
    OrderMapper om;

    //첨부파일 내용 insert
    @Override
    public int insert_order(ShippingDTO sdto) {
        int result = om.insert_order(sdto);
        return result;
    }

    //첨부파일 저장
    @Override
    public String file_save(MultipartFile order_file, HttpServletRequest req){
        Date today = new Date();
        SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddhhmmss");
        String ymd = sf.format(today);

        String storage_url = req.getServletContext().getRealPath("/excelUpload/");
        String oriname = order_file.getOriginalFilename();
        String types = oriname.substring(oriname.lastIndexOf("."));
        //String filetype = order_file.getContentType(); //application/vnd.ms-excel

        //첨부파일 이름 변경하여 저장
        int random_num = (int)Math.ceil(Math.random()*100);
        String new_name = ymd + random_num + types;
        try {
            FileCopyUtils.copy(order_file.getBytes(), new File(storage_url + new_name));
        }catch (IOException e){
            e.getStackTrace();
        }
        return new_name;
    }

    //주문 등록 리스트
    @Override
    public List<ShippingDTO> order_list(Map<String, Object> paramValue) {
        List<ShippingDTO> result = om.order_list(paramValue);
        return result;
    }

    //등록된 주문 개수
    @Override
    public int order_count(Map<String, Object> paramValue) {
        int result = om.order_count(paramValue);
        return result;
    }

    //등록된 주문 거래처 종류
    @Override
    public List<String> account_list() {
        List<String> result = om.account_list();
        return result;
    }

    //주문 삭제
    @Override
    public int delete_order(String aidx) {
        int result = om.delete_order(aidx);
        return result;
    }
}
