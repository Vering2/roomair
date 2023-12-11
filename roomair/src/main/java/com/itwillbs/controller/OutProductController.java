package com.itwillbs.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.domain.OutProductDTO;
import com.itwillbs.service.OutProductService;

@Controller
@RequestMapping("/outProduct/*")
public class OutProductController {

    @Inject
    private OutProductService outProductService;

    // 출고 페이지 이동 -> ajaxOutProductController에서 ajax로 리스트 불러오게 할려고
    @GetMapping("/list")
    public String outProductList(Model model) {

        return "outProduct/outProduct";
    }

    // 페이지 세부 정보
    @GetMapping("/outProductContent")
    public String outProductContent(HttpServletRequest request, Model model) {

        // 선택한 출고 코드 받아오기
        String outCode = request.getParameter("outCode");

        // 해당 출고 코드에 대한 정보 조회
        OutProductDTO outProductDTO = outProductService.outProductContent(outCode);

        // 조회한 정보를 Model에 추가하여 JSP에서 사용할 수 있게 함
        model.addAttribute("outProductDTO", outProductDTO);

        return "outProduct/outProductContent";
    }

}
