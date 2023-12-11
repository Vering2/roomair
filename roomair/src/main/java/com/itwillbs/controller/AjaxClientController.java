package com.itwillbs.controller;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.itwillbs.domain.ClientDTO;
import com.itwillbs.service.ClientService;

import lombok.extern.slf4j.Slf4j;

/*
 * AjaxClientController: 이 클래스는 클라이언트 작업과 관련된 AJAX 요청을 처리하는 Spring MVC 컨트롤러입니다.
 * 비동기적으로 클라이언트 정보를 삽입하고 업데이트하는 데 사용되는 엔드포인트를 제공합니다.
 */

@RestController
@Slf4j
@RequestMapping("/client_ajax/*")
public class AjaxClientController {

	@Inject
	private ClientService clientService;

	/*
	 * 클라이언트 정보를 비동기적으로 삽입하는 엔드포인트입니다.
	 * 
	 * @param clientDTO 삽입할 클라이언트를 나타내는 데이터.
	 * 
	 * @return ResponseEntity<String> 삽입이 성공하면 "true"를, 그렇지 않으면 "false"를 반환합니다.
	 */
	@PostMapping("/insertPro")
	public ResponseEntity<String> insertClient(ClientDTO clientDTO) {
		try {
			clientService.insertClient(clientDTO);
			return new ResponseEntity<>("true", HttpStatus.OK); // 성공 시 "true" 반환
		} catch (Exception e) {
			log.error("클라이언트 삽입 중 오류 발생: {}", e.getMessage());
			return new ResponseEntity<>("false", HttpStatus.INTERNAL_SERVER_ERROR); // 실패 시 "false" 반환
		}
	}

	/*
	 * 클라이언트 정보를 비동기적으로 업데이트하는 엔드포인트입니다.
	 * 
	 * @param clientDTO 업데이트할 클라이언트를 나타내는 데이터.
	 * 
	 * @return ResponseEntity<String> 업데이트가 성공하면 "success"를, 그렇지 않으면 "error"를 반환합니다.
	 */
	@PostMapping("/clientupdatePro")
	public ResponseEntity<String> clientupdatePro(ClientDTO clientDTO) {
		System.out.println("AXJAX ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ" + clientDTO);
		try {
			clientService.clientupdate(clientDTO);
			return ResponseEntity.ok("success"); // 성공 시 "success" 반환
		} catch (Exception e) {
			log.error("클라이언트 업데이트 중 오류 발생: {}", e.getMessage());
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error"); // 실패 시 "error" 반환
		}
	}
}
