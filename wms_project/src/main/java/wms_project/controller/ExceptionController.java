package wms_project.controller;

import java.io.IOException;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

@Controller
public class ExceptionController {

	  @GetMapping("/runtime-exception")
	    public void RuntimeException() {
	        throw new RuntimeException();
	    }

	    @GetMapping("/error-404")
	    public void error404(HttpServletResponse response) throws IOException {
	        response.sendError(404);
	    }

	    @GetMapping("/error-400")
	    public void error400(HttpServletResponse response) throws IOException {
	        response.sendError(400);
	    }
	    
	    @GetMapping("/error-401")
	    public void error401(HttpServletResponse response) throws IOException {
	        response.sendError(401);
	    }
	    

	    @GetMapping("/error-500")
	    public void error500(HttpServletResponse response) throws IOException {
	        response.sendError(500);
	    }
	    
}
