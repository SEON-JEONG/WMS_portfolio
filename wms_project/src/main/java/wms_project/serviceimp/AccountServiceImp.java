package wms_project.serviceimp;


import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import wms_project.controller.AccountController;
import wms_project.dto.AccountDTO;
import wms_project.dto.OfficeDTO;
import wms_project.mapper.AccountMapper;
import wms_project.service.AccountService;

@Service
public class AccountServiceImp implements AccountService {
	@Autowired
	private AccountMapper am;

		@Override
		public int account_insert(AccountDTO dto) {

			int result = am.account_insert(dto);
			return result;
		};
	
		@Override
		public String search_company(String acompany) {	
			String result = am.search_company(acompany);
			return result;
		};
		
		@Override
		public String account_ctn() {
			String result = am.account_ctn();
			return result;
		};
		
		@Override
		public List<AccountDTO> accountList(Map<String, Object> paramValue) {
			List<AccountDTO> result = am.accountList(paramValue);
			return result;
		};
		
		@Override
		public int accountCtn(Map<String, Object> paramValue) {
			int result = am.accountCtn(paramValue);
			return result;
		};

		@Override
		public AccountDTO accountIdx(String aidx) {
			AccountDTO adto = am.accountIdx(aidx);
			return adto;
		};
		
		@Override
		public int accountModify(AccountDTO dto) {
			int result = am.accountModify(dto);
			return result;
		};
		
		@Override
		public int accountDelete(String aidx) {
			int result = am.accountDelete(aidx);
			return result;
		};

		@Override
		public int accountListCtn() {
			int result = am.accountListCtn();
			return result;
		};
}
