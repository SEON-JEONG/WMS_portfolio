package wms_project.controller;

import java.io.PrintWriter;
import java.net.http.HttpResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import wms_project.dto.AccountDTO;
import wms_project.dto.PaletteDTO;
import wms_project.dto.ProductDTO;
import wms_project.dto.StorageDTO;
import wms_project.service.AccountService;
import wms_project.service.PaletteService;
import wms_project.service.StorageService;

@Controller
public class StorageController {

	@Resource(name = "accountdto")
	AccountDTO dto;

	@Resource(name = "PaletteDTO")
	PaletteDTO pdto;

	@Autowired
	AccountService as;

	@Autowired
	PaletteService ps;

	String output = null;
	javascript js = new javascript();

	@Autowired
	StorageService ss;

	PrintWriter pw = null;
	
	@PostMapping("/storage/movePalette.do")
	public String movePalette(@RequestBody String data, HttpServletResponse res) {

		
		try {
			this.pw = res.getWriter();
			JSONArray ja = new JSONArray(data);
			// System.out.println(ja);
			// System.out.println(ja.length());

			int w = 0;

			while (w < ja.length()) {
				Map<String, String> params = new HashMap<>();

				JSONObject jo = (JSONObject) ja.getJSONObject(w);
				String pdidx = jo.get("pdidx").toString();
				String quantity = jo.get("quantity").toString();
				String instorepalette = jo.get("instorepalette").toString();
				String pcode = (String) jo.get("instorepcode");
				
				System.out.println(pdidx + ":" + quantity + ":"+instorepalette + ":" + pcode);

				params.put("pdidx", pdidx);
				params.put("quantity", quantity);

				ss.updateProduct(params); // 선택한 창고에서 이동시키기(수량감소)
				ProductDTO productInfo = ss.selectProduct(pdidx); // 이동한 상품의 정보들 추출

				// 새로운 창고에 재고 추가
				ProductDTO newProduct = new ProductDTO();
				newProduct.setAcompany(productInfo.getAcompany());
				newProduct.setAcode(productInfo.getAcode());
				newProduct.setPdcode(productInfo.getPdcode());
				newProduct.setPdname(productInfo.getPdname());
				newProduct.setQuantity(quantity); // 이동할 수량
				newProduct.setSname(productInfo.getSname());
				newProduct.setScode(productInfo.getScode());
				newProduct.setInstorepalette(instorepalette);
				newProduct.setPcode(pcode);
				newProduct.setMspot(productInfo.getMspot());

				
				ss.movePalette(newProduct);

				w++;
			}
			
			System.out.println(w);
			this.pw.print("ok");

		} catch (Exception e) {
			e.printStackTrace();

		}
		
		
		
	 return null;
	}

	
	
	@GetMapping("/storage/storagePalette.do")
	public String storagePaletteString(@RequestParam(value ="sname", required = false) String sname,
									@RequestParam(value ="pname", required = false) String pname,
									@RequestParam(value = "pageno",required = false) Integer pageno,
			HttpServletRequest req, Model m) {
		HttpSession sess = req.getSession();
		String mspot = (String) sess.getAttribute("mspot");
		Map<String, Object> params = new HashMap<>();
		params.put("mspot", mspot);
		params.put("sname", sname);
		params.put("pname", pname);
		   int total = 0;
	       int startno = 0;
	       int endno = 20;
	       
	       if(pageno == null) {
	    	   startno = 0;
	    	   pageno = 1;
	       }else {
			startno = (pageno-1) * 20;
	       }
	    params.put("startno", startno);
		params.put("endno", endno);
		
		
		
		
		List<Map<String, Object>> all = ss.paletteall(mspot);
		List<Map<String, Object>> paletteall = ss.paletteSearchall(params);
		List<Map<String, String>> palettAnother = ss.paletteAnother(params);
		total = ss.paletteSearchallCount(params);
		System.out.println(total);
		
		
		m.addAttribute("pname", pname);
		m.addAttribute("sname",sname);
		m.addAttribute("total",total);
		m.addAttribute("all", all);
		m.addAttribute("paletteall", paletteall);
		m.addAttribute("params",params);
		m.addAttribute("palettAnother",palettAnother);
		return null;
	}

	
	
	// , @RequestParam("to") String to
	@PostMapping("/storage/moveProduct.do")
	public String moveProduct(@RequestBody String data, HttpServletResponse res) {

		System.out.println("="+data);
		try {
			this.pw = res.getWriter();
			JSONArray ja = new JSONArray(data);
			// System.out.println(ja);
			// System.out.println(ja.length());

			int w = 0;

			while (w < ja.length()) {
				Map<String, String> params = new HashMap<>();

				JSONObject jo = (JSONObject) ja.getJSONObject(w);
				String pdidx = jo.get("pdidx").toString();
				String quantity = jo.get("quantity").toString();
				String instorename = jo.get("instorename").toString();
				String instorecode = jo.get("instorecode").toString();
				System.out.println(pdidx + ":" + quantity + ":" + instorename + ":" + instorecode);

				params.put("pdidx", pdidx);
				params.put("quantity", quantity);
				params.put("instorename", instorename);
				params.put("instorecode", instorecode);

				ss.updateProduct(params); // 선택한 창고에서 이동시키기(수량감소)
				ProductDTO productInfo = ss.selectProduct(pdidx); // 이동할 상품의 정보들 추출
				String mspot = ss.searchmspot(params);
				// 새로운 창고에 재고 추가
				ProductDTO newProduct = new ProductDTO();
				newProduct.setAcompany(productInfo.getAcompany());
				newProduct.setAcode(productInfo.getAcode());
				newProduct.setPdcode(productInfo.getPdcode());
				newProduct.setPdname(productInfo.getPdname());
				newProduct.setQuantity(quantity); // 이동할 수량
				newProduct.setInstorename(instorename);
				newProduct.setInstorecode(instorecode);
				newProduct.setLastmove(productInfo.getSname());
				//newProduct.setPname(productInfo.getPname());
				//newProduct.setPcode(productInfo.getPcode());
				newProduct.setMspot(mspot);

				ss.moveProduct(newProduct);

				w++;
			}

			this.pw.print("ok");

		} catch (Exception e) {
			e.printStackTrace();

		}

		return null;

	}

	@GetMapping("/storage/storageList.do")
	public String productList(@RequestParam(value = "selectstorage", required = false) String selectstorage,
			@RequestParam(value = "storageto", required = false) String storageto, 
			@RequestParam(value = "pageno",required = false) Integer pageno, HttpServletRequest req, Model m) {
		HttpSession sess = req.getSession();
		String mspot = (String) sess.getAttribute("mspot");
		Map<String, Object> params = new HashMap<>();
		params.put("selectstorage", selectstorage);
		params.put("storageto", storageto);
		params.put("mspot", mspot);
		
		   int total =0;
	       int startno = 0;
	       int endno = 20;
	       
	       if(pageno == null) {
	    	   startno = 0;
	    	   pageno = 1;
	       }else {
			startno = (pageno-1) * 20;
	       }
	    params.put("startno", startno);
		params.put("endno", endno);
	       	
		List<StorageDTO> members = ss.searchalluse(params);
		List<StorageDTO> membersall = ss.searchto(selectstorage);
		List<ProductDTO> list = new ArrayList<>();

		if (selectstorage != null && !selectstorage.isEmpty()) {
			list = ss.productlist(params);
			
		}
		total = ss.productlistotal(params);
		System.out.println("total" + total);
		
		m.addAttribute("storageto", storageto);
		m.addAttribute("selectstorage",selectstorage);
		m.addAttribute("total", total); // 전체 멤버 수
        m.addAttribute("pageno", pageno); // 현재 페이지 번호
        m.addAttribute("startno", startno);
        m.addAttribute("endno", endno);
		m.addAttribute("product", list);// 사용자가 선택한 창고 상품 리스트
		m.addAttribute("members", members); // 사용자와 맞는 창고 리스트
		m.addAttribute("membersall", membersall); // 첫번째 선택한 창고를 제외한 전체 창고 리스트
		return null;
	}

	@PostMapping("/storage/insertStore.do")
	public String storageInsert(@RequestBody String data, HttpServletResponse res) {
		// System.out.println(productDTO);
		
		try {
			this.pw = res.getWriter();
			JSONArray ja = new JSONArray(data);
			int w = 0;
			
			while (w < ja.length()) {
				Map<String, Object> params = new HashMap<>();

				JSONObject jo = (JSONObject) ja.getJSONObject(w);
				String acompany = jo.get("acompany").toString();
				String acode = jo.get("acode").toString();
				String pdcode = jo.get("pdcode").toString();
				String pdname = jo.get("pdname").toString();
				int pdamount = jo.getInt("pdamount");
				String sname = jo.get("sname").toString();
				String scode = jo.get("scode").toString();
				String pname = jo.get("pname").toString();
				String pddate = jo.get("pddate").toString();
				String mspot = jo.get("mspot").toString();
				
				String pcode = ss.palettecode(pname);
				
				params.put("acompany", acompany);
				params.put("acode", acode);
				params.put("pdcode", pdcode);
				params.put("pdname", pdname);
				params.put("pdamount", pdamount);
				params.put("sname", sname);
				params.put("scode", scode);
				params.put("pname", pname);
				params.put("pddate", pddate);
				params.put("mspot", mspot);
				params.put("pcode", pcode);
;				
				ss.insertStore(params);
			
			w++;
			}
			System.out.println(w +"행이 입력되었습니다.");
			
			this.pw.print("ok");
			this.pw.flush();
		} catch (Exception e) {
			e.printStackTrace();
			
		}

		
		return null;
	}

	@GetMapping("/account/getAccountCode")
	@ResponseBody // JSON 응답을 반환하기 위해 추가
	public String getAccountCode(@RequestParam("acompany") String acompany) {

		String acode = null;
		if (acompany != null && !acompany.isEmpty()) {
			acode = ss.getAcode(acompany); // 거래처 코드 조회
		}

		return acode;
	}

	//
	@GetMapping("/storage/storageInstore.do")
	public String storageInstore1(@RequestParam(value = "acompany", required = false) String acompany,
			StorageDTO storageDTO,
			HttpServletRequest req, Model m) {
		HttpSession sess = req.getSession();
		String mspot = (String) sess.getAttribute("mspot");
		Map<String, Object> params = new HashMap<>();
		params.put("mspot", mspot);
		List<StorageDTO> members = ss.searchalluse(params);
		List<PaletteDTO> palette = ss.palettelist(mspot);
		

		m.addAttribute("mspot",mspot);
		m.addAttribute("palette", palette);// 사용자와 맞는 팔레트 리스트
		m.addAttribute("members", members);

		return null;
	}

	/*
	 * @PostMapping("/storage/storageInstore.do") public String
	 * storageInstore(StorageDTO storageDTO,HttpServletRequest req, Model m) {
	 * HttpSession sess = req.getSession(); String mspot = (String)
	 * sess.getAttribute("mspot"); List<StorageDTO> members = ss.searchall(mspot);
	 * List<PaletteDTO> palette = ps.palette_list(mspot);
	 * System.out.println("palette"+palette);
	 * 
	 * 
	 * m.addAttribute("palette",palette);//사용자와 맞는 팔레트 리스트
	 * m.addAttribute("members",members);//사용자와 맞는 창고 리스트
	 * 
	 * return null; }
	 */

	@GetMapping("/storage/storageInsert.do")
	public String storageInsert(StorageDTO storageDTO) {

		return null;
	}

	@PostMapping("/storageInsert.do")
	public String InsertStorage(StorageDTO storageDTO, Model m) {

		try {

			int result = ss.insert1(storageDTO);

			// 결과에 따라 뷰에 메시지 추가
			if (result > 0) {
				this.output = this.js.ok("등록 되었습니다.", "/storage/storageMain.do");

			} else {
				this.output = this.js.no("등록 실패하였습니다.");

			}
		} catch (Exception e) {
			System.out.println("등록 실패");
		}

		m.addAttribute("output", output);

		return "output";
	}

	// GET 요청을 처리하는 checkCode 메서드
	@GetMapping("/api/checkCode/{scode}") // /api/checkCode/{scode} 경로로 매핑
	@ResponseBody // 메서드의 반환값을 HTTP 응답 본문으로 사용
	public ResponseEntity<Integer> checkCode(@PathVariable("scode") String scode) {
		int count = ss.checkCode(scode); // 서비스 메서드 호출
		System.out.println("count" + count);
		return ResponseEntity.ok(count); // count 값을 HTTP 응답으로 반환
	}

	@GetMapping("/storage/storageMain.do")
	public String showMembers(@RequestParam(value = "mspot", required = false) String mspot,
			@RequestParam(value = "search", required = false) String search, 
			@RequestParam(value = "pageno",required = false) Integer pageno,
			Model m, HttpServletRequest req) {
		HttpSession sess = req.getSession();
		String sessionMspot = (String) sess.getAttribute("mspot");
		Map<String, Object> params = new HashMap<>();
		mspot = sessionMspot;
		int total = 0;
	    int startno = 0;
	    int endno = 15;
	    
	    params.put("mspot", mspot);
	    params.put("startno", startno);
	    params.put("endno", endno);
	    params.put("search", search);
	    
	    
		if (search == "" || search == null) {
			List<StorageDTO> members = ss.searchall(params); // 전체 창고 가져오기
			m.addAttribute("members", members); // 모델에 추가
		} else {

			List<StorageDTO> all = ss.all(params);
			m.addAttribute("members", all);
		}
		if(pageno == null) {
	    startno = 0;
	    pageno = 1;
		}else {
			startno = (pageno-1) * 15;
	       }
		total = ss.storageTotal(params);
		System.out.println(total);
		
		m.addAttribute("total", total); // 전체 멤버 수
        m.addAttribute("pageno", pageno); // 현재 페이지 번호
        m.addAttribute("startno", startno);
        m.addAttribute("endno", endno);
        m.addAttribute("search", search); 
		return null; // JSP 페이지 이름 반환
	}

	@GetMapping("/storage/storageUpdate.do")
	public String getMember(@RequestParam(value = "scode") String scode, Model m) {
		m.addAttribute("member", ss.getByID(scode));
		return null;
	}

	@PostMapping("/storage/storageUpdate.do")
	public String updateMember(StorageDTO storageDTO, Model m) {

		try {
			ss.updateByID(storageDTO);

			this.output = this.js.ok("수정 되었습니다.", "/storage/storageMain.do");

		} catch (Exception e) {
			this.output = this.js.no("변경 실패하였습니다.");
		}

		m.addAttribute("output", output);
		m.addAttribute("member", ss.getByID(storageDTO.getScode()));
		return "output";
	}

	@PostMapping("/storageDelete.do")
	public String deleteStorage(@RequestParam("scode") String scode, Model m) {
		System.out.println(scode);
		try {
			int result = ss.deleteByID(scode);
			System.out.println(result);

			if (result > 0) {
				this.output = this.js.ok("수정 되었습니다.", "/storage/storageMain.do");
			} else {
				this.output = this.js.no("변경 하실 수 없습니다.");
			}

		} catch (Exception e) {
			this.output = this.js.no("변경 실패하였습니다.");
		}

		m.addAttribute("output", output);
		return "output";
	}

}
