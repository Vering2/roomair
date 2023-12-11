package com.itwillbs.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.domain.ClientDTO;
import com.itwillbs.domain.OrderManagementDTO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.RawmaterialsDTO;
import com.itwillbs.service.InMaterialService;
import com.itwillbs.service.OrderManagementService;
import com.itwillbs.service.RawmaterialsService;

@Controller
@RequestMapping("/OrderManagement/*")
public class OrderManagementController {

    // OrderManagementService 객체 생성
    @Inject
    private OrderManagementService ordermanagementService;
    @Inject
    private RawmaterialsService rawmaterialsService;
    @Inject
    private InMaterialService inMaterialService;

    // home 페이징 처리, 검색 기능
    @GetMapping("/home")
    public String home(HttpServletRequest request, Model model) {

        String search1 = request.getParameter("search1");
        System.out.println("search1 : " + search1);
        String search2 = request.getParameter("search2");
        System.out.println("search2 : " + search2);
        String search3 = request.getParameter("search3");
        System.out.println("search3 : " + search3);
        String search4 = request.getParameter("search4");
        System.out.println("search4 : " + search4);

        int pageSize = 10;
        String pageNum = request.getParameter("pageNum");
        if (pageNum == null) {
            pageNum = "1";
        }
        System.out.println(pageNum);

        int currentPage = Integer.parseInt(pageNum);
        PageDTO pageDTO = new PageDTO();
        pageDTO.setPageSize(pageSize);
        pageDTO.setPageNum(pageNum);
        pageDTO.setCurrentPage(currentPage);
        pageDTO.setSearch1(search1); // 검색어 저장
        pageDTO.setSearch2(search2);
        pageDTO.setSearch3(search3);
        pageDTO.setSearch4(search4);

        // buyDate가 오늘 또는 이전인 경우, buyInstate가 '신청완료'에서 '발주완료'로 변경
        Date today = java.sql.Date.valueOf(LocalDate.now()); // 오늘 날짜 가져옴
        ordermanagementService.updateBuyInstate(today);

        int count = ordermanagementService.getOrderManagementCount(pageDTO);
        int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
        int pageBlock = 5;
        int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
        int endPage = startPage + pageBlock - 1;
        if (endPage > pageCount) {
            endPage = pageCount;
        }

        pageDTO.setCount(count);
        pageDTO.setPageCount(pageCount);
        pageDTO.setPageBlock(pageBlock);
        pageDTO.setStartPage(startPage);
        pageDTO.setEndPage(endPage);

        // 품목 추가한 내용 뿌려주기
        List<OrderManagementDTO> ordermanagementList = ordermanagementService.getOrderManagementList(pageDTO);

        // 품목 추가한 내용 뿌려주기
        model.addAttribute("ordermanagementList", ordermanagementList);
        model.addAttribute("pageDTO", pageDTO);

        return "OrderManagement/home";
    }

    // 가상 주소 http://localhost:8080/leeweb/OrderManagement/insert
    @GetMapping("/insert")
    public String insert() {
        return "OrderManagement/insert";
    }

    // 가상 주소 http://localhost:8080/leeweb/OrderManagement/insertPro
    @PostMapping("/insertPro")
    public String insertPro(OrderManagementDTO ordermanagementDTO) {
        System.out.println("OrderManagementController insertPro()");
        System.out.println(ordermanagementDTO);

        // buyNum 자동 생성
        // = RA + yyMMddHHmmss
        Date now = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyMMddHHmmss");
        String formattedDate = dateFormat.format(now);
        String buyNum = "RA" + formattedDate;
        System.out.println("발주코드 : " + buyNum);
        ordermanagementDTO.setBuyNum(buyNum);

        // inMaterial 추가한 코드
        ordermanagementService.insertOrderManagement(ordermanagementDTO);
        inMaterialService.insertList(ordermanagementDTO);

        return "redirect:/OrderManagement/home";
    }

    // 체크박스로 선택 삭제
    @RequestMapping(value = "/delete")
    public String ajaxTest(HttpServletRequest request) throws Exception {
        String[] ajaxMsg = request.getParameterValues("valueArr");
        int size = ajaxMsg.length;
        for (int i = 0; i < size; i++) {
            ordermanagementService.delete(ajaxMsg[i]);
//        	inMaterialService.deleteSell(ajaxMsg[i]);
        }
        return "redirect:/OrderManagement/home";
    }

    @GetMapping("/detail")
    public String detail(HttpServletRequest request, Model model) {
        System.out.println("OrderManagementController detail()");

        // 발주번호 잘 들고왔는지 확인
        String buyNum = request.getParameter("buyNum");

        // 1) ordermanagementService, ordermanagementDAO에 getDetail 메서드를 만들어, 들고온
        // buyNum에 해당하는 다른 내용을 가져오게 하고 => ordermanagementDTO 변수에 담기
        OrderManagementDTO ordermanagementDTO = ordermanagementService.getDetail(buyNum);
        // 2) Model을 사용해서 ordermanagementDTO에 넣은 모든 내용을 보여주기
        model.addAttribute("ordermanagementDTO", ordermanagementDTO);

        return "OrderManagement/detail";
    }

    @GetMapping("/update")
    public String update(HttpServletRequest request, Model model) {
        System.out.println("OrderManagementController update()");

        // 발주번호 잘 들고왔는지 확인
        String buyNum = request.getParameter("buyNum");

        // detail 코드 내용 재활용
        OrderManagementDTO ordermanagementDTO = ordermanagementService.getDetail(buyNum);
        model.addAttribute("ordermanagementDTO", ordermanagementDTO);

        return "OrderManagement/update";
    }

    @PostMapping("/updatePro")
    public String updatePro(OrderManagementDTO ordermanagementDTO) {
        System.out.println("OrderManagementController updatePro()");

        // 수정한 내용 잘 들고왔는지 확인
        System.out.println(ordermanagementDTO);

        // insert, update 등은 DB에서 작업하고 끝낼거라 리턴할 필요 없음
        // 따라서 boardDTO = boardService.updateBoard(boardDTO);처럼 boardDTO에 받아올 필요 없고,
        // Service랑 DAO에서 void 쓰고 return 안함
        ordermanagementService.updateOrderManagement(ordermanagementDTO);
        inMaterialService.updateList(ordermanagementDTO);
        return "redirect:/OrderManagement/home";
    }

    // selectrawmaterials 페이징 처리, 검색 기능
    @GetMapping("/selectrawmaterials")
    public String selectrawmaterials(HttpServletRequest request, Model model) {

        String search1 = request.getParameter("search1");
        System.out.println("search1 : " + search1);
        String search2 = request.getParameter("search2");
        System.out.println("search2 : " + search2);
        String search3 = request.getParameter("search3");
        System.out.println("search3 : " + search3);
        String search4 = request.getParameter("search4");
        System.out.println("search4 : " + search4);

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
        pageDTO.setSearch1(search1); // 검색어 저장
        pageDTO.setSearch2(search2);
        pageDTO.setSearch3(search3);
        pageDTO.setSearch4(search4);

        // 품목 추가한 내용 뿌려주기
        List<RawmaterialsDTO> rawmaterialsList = rawmaterialsService.getRawmaterialsList(pageDTO);

        int count = rawmaterialsService.getRawmaterialsCount(pageDTO);
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

        // 품목 추가한 내용 뿌려주기
        model.addAttribute("rawmaterialsList", rawmaterialsList);
        model.addAttribute("pageDTO", pageDTO);

        return "OrderManagement/selectrawmaterials";
    }

    // selectclient 페이징 처리, 검색 기능
    @GetMapping("/selectclient")
    public String selectclient(HttpServletRequest request, Model model) {

        String search1 = request.getParameter("search1");
        System.out.println("search1 : " + search1);
        String search2 = request.getParameter("search2");
        System.out.println("search2 : " + search2);
        String search3 = request.getParameter("search3");
        System.out.println("search3 : " + search3);
        String search4 = request.getParameter("search4");
        System.out.println("search4 : " + search4);

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
        pageDTO.setSearch1(search1); // 검색어 저장
        pageDTO.setSearch2(search2);
        pageDTO.setSearch3(search3);
        pageDTO.setSearch4(search4);

        // 거래처 내용 뿌려주기
        List<ClientDTO> clientList = rawmaterialsService.getClientList(pageDTO);

        int count = rawmaterialsService.getClientCount(pageDTO);
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

        // 거래처 내용 뿌려주기
        model.addAttribute("clientList", clientList);
        model.addAttribute("pageDTO", pageDTO);

        return "OrderManagement/selectclient";
    }

    // 엑셀
    @GetMapping("/download")
    public void download(HttpServletResponse response) throws IOException {
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("rawmaterialsList");
        Row header = sheet.createRow(0);
        header.createCell(0).setCellValue("발주번호");
        header.createCell(1).setCellValue("품번");
        header.createCell(2).setCellValue("품명");
        header.createCell(3).setCellValue("종류");
        header.createCell(4).setCellValue("거래처명");
        header.createCell(5).setCellValue("창고수량");
        header.createCell(6).setCellValue("발주수량");
        header.createCell(7).setCellValue("납입단가");
        header.createCell(8).setCellValue("단가총계");
        header.createCell(9).setCellValue("발주신청일");
        header.createCell(10).setCellValue("담당자");
        header.createCell(11).setCellValue("입고상태");

        List<OrderManagementDTO> orders = ordermanagementService.getOrderManagementList2();
        for (int i = 0; i < orders.size(); i++) {
            OrderManagementDTO order = orders.get(i);
            int rawPrice = (int) order.getRawPrice();
            int buyCount = order.getBuyCount();
            int total = rawPrice * buyCount;
            Row row = sheet.createRow(i + 1);
            row.createCell(0).setCellValue(order.getBuyNum());
            row.createCell(1).setCellValue(order.getRawCode());
            row.createCell(2).setCellValue(order.getRawName());
            row.createCell(3).setCellValue(order.getRawType());
            row.createCell(4).setCellValue(order.getClientCode());
            row.createCell(5).setCellValue(order.getStockCount());
            row.createCell(6).setCellValue(order.getBuyCount());
            row.createCell(7).setCellValue(order.getRawPrice());
            row.createCell(8).setCellValue(total);
            row.createCell(9).setCellValue(order.getBuyDate());
            row.createCell(10).setCellValue(order.getBuyEmpId());
            row.createCell(11).setCellValue(order.getBuyInstate());
        }
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment; filename=rawmaterialsList.xlsx");
        workbook.write(response.getOutputStream());
        workbook.close();
    }

}
