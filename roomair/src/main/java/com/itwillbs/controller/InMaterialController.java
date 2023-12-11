package com.itwillbs.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.itwillbs.domain.InMaterialDTO;
import com.itwillbs.service.InMaterialService;

import lombok.extern.slf4j.Slf4j;

/*
 * InMaterialController: 자재 입고 정보를 처리하는 Spring MVC 컨트롤러입니다.
 */

@Controller
@RequestMapping("/inMaterial/*")
@Slf4j
public class InMaterialController {

    @Inject
    private InMaterialService inMaterialService;

    /*
     * 자재 입고 페이지로 이동하는 메서드입니다.
     * 
     * @param model Spring의 Model 인터페이스
     * @return String 뷰 페이지 경로
     */
    @GetMapping("/list")
    public String getInMaterialList(Model model) {
        log.debug("호출한 곳");
        return "inMaterial/inMaterial";
    }

    /*
     * 자재 입고 상세 정보를 보여주는 페이지로 이동하는 메서드입니다.
     * 
     * @param request HTTP 요청 객체
     * @param model   Spring의 Model 인터페이스
     * @return String 뷰 페이지 경로
     */
    @GetMapping("/inMaterialContent")
    public String inMaterialContent(HttpServletRequest request, Model model) {
        log.debug("inMaterialController inMaterialContent");
        String inNum = request.getParameter("inNum");
        InMaterialDTO inMaterialDTO = inMaterialService.inMaterialContent(inNum);
        model.addAttribute("inMaterialDTO", inMaterialDTO);
        return "inMaterial/inMaterialContent";
    }

}
