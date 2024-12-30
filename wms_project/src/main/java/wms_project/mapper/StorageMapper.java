package wms_project.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import wms_project.dto.AccountDTO;
import wms_project.dto.DeliveryListDTO;
import wms_project.dto.PaletteDTO;
import wms_project.dto.ProductDTO;
import wms_project.dto.ShippingDTO;
import wms_project.dto.StorageDTO;

@Mapper
public interface StorageMapper {

    int insert1(StorageDTO storageDTO);

    int checkCode(String scode);

    List<StorageDTO> searchall(Map<String, Object> params);
    
    List<StorageDTO> searchalluse(Map<String, Object> params);
    
    List<StorageDTO> searchto(String selectstorage); //전체 창고 리스트

    StorageDTO getByID(String scode);

    int updateByID(StorageDTO storageDTO);
    
    Integer productlistotal(Map<String, Object> params);
    
    Integer storageTotal(Map<String, Object> params);
    
    List<StorageDTO> all(Map<String, Object> params);
    
    int deleteByID(String scode);
    
    //상품 입고 관련
    //거래처 이름으로 거래처 코드 찾기
    String getAcode(String acompany); 
    //상품 입고하기
    int insertStore(Map<String, Object> params);
    //창고에 따른 상품 리스트 출력하기
    List<ProductDTO> productlist(Map<String, Object> params);
    //체크한 행의 컬럼값들 가져오기
    ProductDTO selectProduct(String pdidx);
    //새로운 창고로 물건 이동시키기    
    String searchmspot(Map<String, String> params);
    void moveProduct(ProductDTO newProduct);
    int	updateProduct1(ProductDTO newProduct);
    
    //새로운 팔레트로 물건 이동시키기
    void movePalette(ProductDTO newProduct);
    int	updateProduct2(ProductDTO newProduct);
    
    void updateProduct(Map<String, String> params);
    //사용자에 맞는 창고 안에 있는 모든 파레트의 정보
    List<Map<String, Object>> paletteall(String mspot);
    //선택한 파레트에 맞는 물건의 행 갯수
    int paletteSearchallCount(Map<String, Object> params);
    //선택되지 않은 모든 파레트의 정보
    List<Map<String, String>> paletteAnother(Map<String, Object> params);
    //모든 파레트의 정보
    List<Map<String, Object>> paletteSearchall(Map<String, Object> params);
    //사용자에 맞는 파레트의 정보
    List<PaletteDTO> palettelist(String mspot);
    
    //사용자가 입고한 팔레트의 코드 정보
    String palettecode(String pname);
    //메인페이지용 최근 5개 출력
    List<ProductDTO> newProduct();
    List<DeliveryListDTO> Deliveryman();
    List<ShippingDTO> Deliveryman2(String z);
    List<DeliveryListDTO> newDeliveryman();
    
    	
}
