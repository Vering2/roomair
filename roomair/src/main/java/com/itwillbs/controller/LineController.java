package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.domain.LineDTO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.service.LineService;

/*
 * LineController: 라인(Line) 정보를 관리하는 Spring MVC Controller입니다.
 */

@Controller
@RequestMapping("/line/*")
public class LineController {

    @Inject
    private LineService lineService;

    /*
     * 라인 목록을 조회하고 페이징 처리하여 화면에 전달하는 메서드입니다.
     * 
     * @param request HttpServletRequest 객체
     * @param model   Model 객체
     * @return String  라인 목록 화면의 뷰 이름
     */
    @GetMapping("/line")
    public String line(HttpServletRequest request, Model model) {
        String search = request.getParameter("search");
        int pageSize = 10;
        String pageNum = request.getParameter("pageNum");
        if (pageNum == null) {
            pageNum = "1";
        }
        int currentPage = Integer.parseInt(pageNum);
        PageDTO pageDTO = new PageDTO();
        pageDTO.setPageSize(pageSize);
        pageDTO.setPageNum(pageNum);
        pageDTO.setCurrentPage(currentPage);
        pageDTO.setSearch(search);
        List<LineDTO> lineList = lineService.getlineList(pageDTO);
        int count = lineService.getlineCount(pageDTO);
        int pageBlock = 10;
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
        model.addAttribute("pageDTO", pageDTO);
        model.addAttribute("lineList", lineList);
        return "line/line";
    }

    /*
     * 라인 등록 화면을 보여주는 메서드입니다.
     * 
     * @return String 라인 등록 화면의 뷰 이름
     */
    @GetMapping("/line2")
    public String line2() {
        return "line/line2";
    }

    /*
     * 라인을 등록하는 메서드입니다.
     * 
     * @param lineDTO 등록할 라인 정보
     * @return String  라인 목록 화면으로 리다이렉트
     */
    @PostMapping("/insertPro")
    public String insertPro(LineDTO lineDTO) {
        lineService.insertLine(lineDTO);
        return "redirect:/line/line";
    }

    /*
     * 선택된 게시물을 삭제하는 메서드입니다.
     * 
     * @param request HttpServletRequest 객체
     * @return String  라인 목록 화면으로 리다이렉트
     * @throws Exception 예외 발생 시
     */
    @RequestMapping(value = "/delete")
    public String ajaxTest(HttpServletRequest request) throws Exception {
        String[] ajaxMsg = request.getParameterValues("valueArr");
        int size = ajaxMsg.length;
        for (int i = 0; i < size; i++) {
            lineService.delete(ajaxMsg[i]);
        }
        return "redirect:/line/line";
    }

    /*
     * 라인 수정 화면을 보여주는 메서드입니다.
     * 
     * @param request HttpServletRequest 객체
     * @param model   Model 객체
     * @return String  라인 수정 화면의 뷰 이름
     */
    @GetMapping("/update")
    public String update(HttpServletRequest request, Model model) {
        String lineCode = request.getParameter("lineCode");
        LineDTO lineDTO = lineService.getLine(lineCode);
        model.addAttribute("lineDTO", lineDTO);
        return "line/line3";
    }

    /*
     * 라인을 수정하는 메서드입니다.
     * 
     * @param lineDTO 수정할 라인 정보
     * @param rttr    RedirectAttributes 객체
     * @return String  라인 목록 화면으로 리다이렉트
     */
    @PostMapping("/updatePro")
    public String updatePro(LineDTO lineDTO, RedirectAttributes rttr) {
        lineService.updateLine(lineDTO);
        rttr.addFlashAttribute("refreshAndClose", true);
        return "redirect:/line/line";
    }

}
