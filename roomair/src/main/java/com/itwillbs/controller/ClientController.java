package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.itwillbs.domain.ClientDTO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.service.ClientService;

/*
 * ClientController: 이 클래스는 거래처 관리와 관련된 요청을 처리하는 Spring MVC 컨트롤러입니다.
 */

@Controller
@RequestMapping("/client/*")
public class ClientController {

    @Inject
    private ClientService clientService;

    /*
     * 거래처 목록을 화면에 출력하는 메서드입니다.
     * 
     * @param model     Model 객체
     * @param request   HttpServletRequest 객체
     * @param clientDTO ClientDTO 객체
     * @return String   거래처 목록 화면의 뷰 이름
     */
    @GetMapping("/client")
    public String client(Model model, HttpServletRequest request, ClientDTO clientDTO) {

        // 검색어 가져오기
        String search = request.getParameter("search");

        // 한 화면에 보여줄 글 개수
        int pageSize = 10;

        // 현 페이지 번호 가져오기
        String pageNum = request.getParameter("pageNum");
        // 페이지 번호가 없을 경우에는 1로 설정
        if (pageNum == null) {
            pageNum = "1";
        }

        // 페이지 번호 => 정수형 변경
        int currentPage = Integer.parseInt(pageNum);

        // 페이지 정보를 담은 PageDTO 객체 생성
        PageDTO pageDTO = new PageDTO();
        pageDTO.setPageSize(pageSize);
        pageDTO.setPageNum(pageNum);
        pageDTO.setCurrentPage(currentPage);
        pageDTO.setSearch(search);

        List<ClientDTO> clientList;
        int count;

        // 검색 조건이 존재하는 경우와 그렇지 않은 경우로 나눠 처리
        if (clientDTO.getClientCode() != null || clientDTO.getClientName() != null
                || clientDTO.getClientCompany() != null) {
            clientList = clientService.getSearch(clientDTO, pageDTO);
            count = clientService.getSearchcount(clientDTO);
        } else {
            clientList = clientService.getclientList(pageDTO);
            count = clientService.getclientCount(pageDTO);
        }

        int pageBlock = 5;
        int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
        int endPage = startPage + pageBlock - 1;

        int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);

        if (endPage > pageCount) {
            endPage = pageCount;
        }

        pageDTO.setCount(count);
        pageDTO.setPageBlock(pageBlock);
        pageDTO.setStartPage(startPage);
        pageDTO.setEndPage(endPage);
        pageDTO.setPageCount(pageCount);

        model.addAttribute("clientList", clientList);
        model.addAttribute("pageDTO", pageDTO);
        return "client/client";
    }

    /*
     * 거래처 추가 페이지를 출력하는 메서드입니다.
     * 
     * @return String 거래처 추가 페이지의 뷰 이름
     */
    @GetMapping("/clientinsert")
    public String client() {
        return "client/clientinsert";
    }

    /*
     * 거래처를 추가하는 메서드입니다.
     * 
     * @param clientDTO ClientDTO 객체
     */
    @PostMapping("/insertPro")
    public void insert(ClientDTO clientDTO) {
        clientService.insertClient(clientDTO);
    }

    /*
     * 거래처 코드를 받아오는 메서드입니다.
     * 
     * @param clientType 거래처 유형
     * @return String    거래처 코드
     */
    @ResponseBody
    @GetMapping("/getclientCode")
    public String getclientCode(String clientType) {
        clientService.getclientCode(clientType);
        String clientCode = clientService.getclientCode(clientType);
        return clientCode;
    }

    /*
     * 거래처 상세 정보 페이지를 출력하는 메서드입니다.
     * 
     * @param req   HttpServletRequest 객체
     * @param model Model 객체
     * @return String 거래처 상세 정보 페이지의 뷰 이름
     */
    @GetMapping("/clientdetail")
    public String clientdetail(HttpServletRequest req, Model model) {
        String clientCompany = req.getParameter("clientCompany");
        ClientDTO clientDTO = clientService.clientdetail(clientCompany);
        model.addAttribute("clientDTO", clientDTO);
        return "client/clientdetail";
    }

    /*
     * 거래처를 삭제하는 메서드입니다.
     * 
     * @param clientCompany 삭제할 거래처의 회사명
     * @return String       거래처 목록 페이지로 리다이렉트하는 뷰 이름
     */
    @GetMapping("/delete")
    public String clientdelete(String clientCompany) {
        clientService.clientdelete(clientCompany);
        return "redirect:/client/client";
    }
}
