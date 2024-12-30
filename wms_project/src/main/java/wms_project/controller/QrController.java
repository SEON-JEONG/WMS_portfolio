package wms_project.controller;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.OutputStream;
import java.io.PrintWriter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.messaging.handler.annotation.support.MethodArgumentTypeMismatchException;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;

import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.client.j2se.MatrixToImageConfig;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import wms_project.dto.DeliveryShipDTO;
import wms_project.service.DeliveryShipService;

@RestController
public class QrController {

	@Resource(name="dsdto")
	DeliveryShipDTO dto;
	
	@Autowired
	private DeliveryShipService dss;
	
	String output = null;
	javascript js = new javascript();
	
	PrintWriter pw = null;
	
	
	
	
	
	//공용 도매인 프로퍼티스에서 핸들링 하는방법!!
	// 프로퍼티스 값 가져와서 핸들링 하는방법!!!!!
	@Value("${domain}")
	public String domain;
	

	
	
	
	// QR 잠시 핸들링
		@ExceptionHandler(MethodArgumentTypeMismatchException.class)
		@PutMapping("/qr/qr/{scode}")
		public String qrApi(@PathVariable(name="scode") String scode,
							HttpServletRequest req,
							HttpServletResponse res)throws Exception {
			
			
			System.out.println("input에서 쓴값 : " + scode);
			
			// this.domain 은 data.properties 에있는 주고값을 가져와서 핸들링함!!
			String url = "http://"+this.domain+":8080/qr/qrScan.do?scode="+scode;
			//System.out.println("카메라로 찍으면 찍힘!!! : "+url);
			//System.out.println(scode);
			int size =300;	//QR 이미지 가로 세로 사이즈
			
			//QR 객체 생성 뒤에 사이즈는 위에 사이즈 가로300 세로 300
			BitMatrix bm = new MultiFormatWriter().encode(url, BarcodeFormat.QR_CODE, size, size);
			
			
			
			//색상없이 기본으로 할땐 그냥!!
			//MatrixToImageConfig mc = new MatrixToImageConfig();
			
			// QR 색상 변경도 가능
			// int 는 유일하게 색상코드는 인식이됨!!! 아래 0x~ 처럼
			int qrcode = 0xFFFF8629;	// QR색상
			int qrbscolor = 0xFFFFFFFF;	// QR 배경색
			MatrixToImageConfig mc = new MatrixToImageConfig(qrcode,qrbscolor);	// 여기에 적용
			
			// 저장 및 이미지를 바로 출력하기 위한 OutputStream
			ByteArrayOutputStream bs = null;
			
			
			try {
				bs = new ByteArrayOutputStream();
				
				// QR 이미지화 시켜라 (Byte 로 이미지를 생성하는 스트림!!)
				MatrixToImageWriter.writeToStream(bm, "PNG", bs, mc);
				
				// QR 생성 디렉토리 경로 (QR 이미지 저장디렉토리)
				String fileurl = req.getServletContext().getRealPath("/qrCode/"); 
				FileCopyUtils.copy(bs.toByteArray(), new File(fileurl + scode + ".png"));
				bs.flush();
				
				
				
				
				// 프론트에게 전달하여 이미지 및 경로를 출력할수있도록 셋팅!!
				this.pw =res.getWriter();
				this.pw.print("http://192.168.10.142:8080/qrCode/" + scode + ".png");
				this.pw.close();
				
				
			} catch (Exception e) {
				this.pw.print("error");	//프론트에게 에이젝스로 에러 찍을수있게!!
				System.out.println("QR 라이브러리 생성 오류 발생!!");
			}
			
			return null;
		}
		
		
		// 카메라로 찍으면 이경로로 접속!! 그래서 배송완료 되던가 하게!!
		// QR을 스캔하여 접속되는 메소드
		//레스트 컨트롤러는 모델 로 안찎힌다!!!! 그래서 이부분은 일반 컨트롤러로 뺴라!!!!!!!
		// 만약 여기서 쓰려면 String이 아니라 ModelAndView이걸로!!! 
		@GetMapping("/qr/qrScan.do")
		public ModelAndView qrscan(@RequestParam(name="scode", required = false) String scode,
				Model m) {
			System.out.println("카메라로 찍었을때 찍힌다!!! >이건 아마 운송장번호던 뭐던 : " + scode);
			String test ="홍길동";
			ModelAndView mv = new ModelAndView("/qr/qrScan");
			
			//SQL select 쿼리문으로 데이터 조회후 
			m.addAttribute("scode", scode);
			m.addAttribute("usernm", "홍길동");
			m.addAttribute("delivery", "배송중");
	         
	 		return mv;
		}

	
		
		
		
}
