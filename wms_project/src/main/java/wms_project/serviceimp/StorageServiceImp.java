package wms_project.serviceimp;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import wms_project.dto.AccountDTO;
import wms_project.dto.ConfigDTO;
import wms_project.dto.DeliveryListDTO;
import wms_project.dto.PaletteDTO;
import wms_project.dto.ProductDTO;
import wms_project.dto.ShippingDTO;
import wms_project.dto.StorageDTO;
import wms_project.mapper.StorageMapper;
import wms_project.service.StorageService;

@Service
public class StorageServiceImp implements StorageService {


    @Autowired
    StorageMapper sm;

    @Override
    public int insert1(StorageDTO storageDTO) {

        return sm.insert1(storageDTO);
    }

    @Override
    public int checkCode(String scode) {
        int count = sm.checkCode(scode);
        return count;
    }

    @Override
    public List<StorageDTO> searchall(Map<String, Object> params) {

        return sm.searchall(params);
    }
    
    @Override
    public List<StorageDTO> searchalluse(Map<String, Object> params) {
    	
    	return sm.searchalluse(params);
    }
    
    @Override
    public Integer productlistotal(Map<String, Object> params) {
    	
    	return sm.productlistotal(params);
    }
    
    @Override
    public Integer storageTotal(Map<String, Object> params) {
    	
    	return sm.storageTotal(params);
    }
    
    @Override
    public List<StorageDTO> searchto(String selectstorage) {
    	
    	return sm.searchto(selectstorage);
    }
    

    @Override
    public StorageDTO getByID(String scode) {
        return sm.getByID(scode);
    }

    @Override
    public int updateByID(StorageDTO storageDTO) {
        return sm.updateByID(storageDTO);
    }
    
    @Override
    public List<StorageDTO> all(Map<String, Object> params) {
    	
    	return sm.all(params);
    }
    
    @Override
    public int deleteByID(String scode) {
    	StorageDTO storageDTO = new StorageDTO();
        storageDTO.setScode(scode);  	
    	return sm.deleteByID(scode);
    }
    
    //상품 입고 관련
    //거래처 이름 입력하면 코드 자동 삽입
    @Override
    public String getAcode(String acompany) {
        return sm.getAcode(acompany);
    }
    //상품 입고
    @Override
    public int insertStore(Map<String, Object> params){   	   	
	   
    	
    	return sm.insertStore(params);
	    
	    
    }
    //선택 창고에 따른 리스트 출력
    @Override
    public List<ProductDTO> productlist(Map<String, Object> params) {
    	
    	return sm.productlist(params);
    }
    
    @Override
    public ProductDTO selectProduct(String pdidx) {
    	
    	return sm.selectProduct(pdidx);
    }
    //새로운 창고로 물건 이동시키기
    @Override
    public void moveProduct(ProductDTO newProduct) {
    	int row = sm.updateProduct1(newProduct);
    	
    	if(row == 0) {
    	sm.moveProduct(newProduct);
    	}
    }
    @Override
    public String searchmspot(Map<String, String> params) {
    	
    	return sm.searchmspot(params);
    }
    
    //새로운 팔레트로 물건 이동시키기
    @Override
    public void movePalette(ProductDTO newProduct) {
    	int row = sm.updateProduct2(newProduct);
    	
    	if(row == 0) {
        sm.movePalette(newProduct);
        	}
    	
    }
    
    
    @Override
    public void updateProduct(Map<String, String> params) {
    	
    	sm.updateProduct(params);
    	
    }
    
    //사용자에 맞는 창고 안에 있는 모든 파레트의 정보
    @Override
    public List<Map<String, Object>> paletteall(String mspot) {
    	return sm.paletteall(mspot);
    }
    
    @Override
    public int paletteSearchallCount(Map<String, Object> params) {
    	
    	return sm.paletteSearchallCount(params);
    }
    //선택되지 않은 모든 파레트의 정보
    @Override
    public List<Map<String, String>> paletteAnother(Map<String, Object> params) {
    	
    	return sm.paletteAnother(params);
    }
    
    //모든 파레트의 정보
    @Override
    public List<Map<String, Object>> paletteSearchall(Map<String, Object> params) {
    	return sm.paletteSearchall(params);
    }
    
    @Override
    public List<PaletteDTO> palettelist(String mspot) {
    	
    	return sm.palettelist(mspot);
    }
    //입고시 선택한 파레트의 코드
    @Override
    public String palettecode(String pname) {
    	
    	return sm.palettecode(pname);
    }
    //메인페이지용 최근 5개 출력
    @Override
    public List<ProductDTO> newProduct() {
    	
    	return sm.newProduct();
    }
    @Override
    public List<DeliveryListDTO> Deliveryman() {
    
    	return sm.Deliveryman();
    }
    @Override
    public List<ShippingDTO> Deliveryman2(String z) {
    	
    	return sm.Deliveryman2(z);
    }
    @Override
    public List<DeliveryListDTO> newDeliveryman() {
	
    	return sm.newDeliveryman();
}
}
