package wms_project.service;

import java.util.List;
import java.util.Map;

import wms_project.dto.AccountDTO;
import wms_project.dto.OfficeDTO;

public interface AccountService {
		public int account_insert(AccountDTO dto);
		public String search_company(String acompany);
		public String account_ctn();
		public List<AccountDTO> accountList(Map<String, Object> paramValue);
		public int accountCtn(Map<String, Object> paramValue);
		public int accountListCtn();
		public AccountDTO accountIdx(String aidx);
		public int accountModify(AccountDTO dto);
		public int accountDelete (String aidx);
}
