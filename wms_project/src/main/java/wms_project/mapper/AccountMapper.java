package wms_project.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import wms_project.dto.AccountDTO;
import wms_project.dto.OfficeDTO;

@Mapper
public interface AccountMapper {

	public int account_insert(AccountDTO dto);	
	public String search_company(String acompany);
	public String account_ctn();
	public List<AccountDTO> accountList(Map<String, Object> paramValue);
	public int accountCtn(Map<String, Object> paramValue);
	public int accountListCtn();
	public AccountDTO accountIdx(String aidx);
	public int accountModify(AccountDTO dto);
	public int accountDelete (String aidx);
	public List<AccountDTO> accountListALL(Map<String, String> pg);
	public Integer accountAllCtn(String search);
}
