package com.itwillbs.controller;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.itwillbs.domain.ClientDTO;
import com.itwillbs.service.ClientService;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
@RequestMapping("/client_ajax/*")
public class AjaxClientController {
	
	@Inject
	private ClientService clientService;
	
	
	
	  @PostMapping("/insertPro")
	    public ResponseEntity<String> insertClient(ClientDTO clientDTO) {
		  
	        try {
	        	
	            clientService.insertClient(clientDTO);
	            
	            return new ResponseEntity<>("true", HttpStatus.OK); // 성공 시 "true" 반환
	            
	        } catch (Exception e) {
	        	
	            log.error("Error during buy insertion: {}", e.getMessage());
	            
	            return new ResponseEntity<>("false", HttpStatus.INTERNAL_SERVER_ERROR); // 실패 시 "false" 반환
	        }
	    }
	  
	  @PostMapping("/clientupdatePro")
		public ResponseEntity <String> clinetupdatePro(ClientDTO clientDTO) {

		  System.out.println("AXJAX ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ" + clientDTO);
			
			try {
				
				clientService.clientupdate(clientDTO);
				
				return ResponseEntity.ok("success"); // 성공 시 "success" 반환
				 
			} catch (Exception e) {
				   log.error("Error during buy insertion: {}", e.getMessage());
		            
		            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error"); // 실패 시 "error" 반환
			}
			
		}
	


}
