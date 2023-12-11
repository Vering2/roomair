package com.itwillbs.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.OutProductDAO;
import com.itwillbs.domain.ClientDTO;
import com.itwillbs.domain.EmployeesDTO;
import com.itwillbs.domain.OutProductDTO;
import com.itwillbs.domain.ProdDTO;
import com.itwillbs.domain.RawmaterialsDTO;
import com.itwillbs.domain.SellDTO;

@Service
public class OutProductService {

	@Inject
	private OutProductDAO outProductDAO;

	public List<OutProductDTO> getOutProductList(OutProductDTO outProductDTO) {
//		시박하는 행부터 10개 뽑아오기
//		페이지 번호 	한화면에 보여줄 글개수 => 			시작하는 행번호
//		currentPage		pageSize	=>		 	startRow
//		1				10			=> 0*10 +1	 1 ~ 10
//		2				10			=> 1*10 +1 	11 ~ 20
//		3				10			=> 2*10 +1 	21 ~ 30
//		((currentPage-1)*10)+1
		int startRow = (outProductDTO.getCurrentPage() - 1) * outProductDTO.getPageSize() + 1;
		int endRow = startRow + outProductDTO.getPageSize() - 1;
		System.out.println("start Row : " + startRow);
		System.out.println("end Row : " + endRow);
//		디비에 표현하기 위해서
		outProductDTO.setStartRow(startRow - 1);
		outProductDTO.setEndRow(endRow);

		return outProductDAO.getOutProductList(outProductDTO);
	}

	public int getOutProductListCount(OutProductDTO outProductDTO) {
		return outProductDAO.getOutProductListCount(outProductDTO);
	}

	public OutProductDTO outProductContent(String outCode) {
		return outProductDAO.outProductContent(outCode);
	}

	public void updateSellState(OutProductDTO outProductDTO) {
		outProductDAO.updateSellState(outProductDTO);
	}

	public void updateOutDate(OutProductDTO outProductDTO) {
		outProductDAO.updateOutDate(outProductDTO);
	}

	public void updateOutRedate(OutProductDTO outProductDTO) {
		outProductDAO.updateOutRedate(outProductDTO);
	}

	public void updateWhseCount(OutProductDTO outProductDTO) {
		outProductDAO.updateWhseCount(outProductDTO);
	}

	public void updateOutProductContent(OutProductDTO outProductDTO) {
		outProductDAO.updateOutProductContent(outProductDTO);
	}

	public void insertList(SellDTO sellDTO) {

		Date now = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyMMddHHmmss");
		String formattedDate = dateFormat.format(now);
		String code = "OP" + formattedDate;

//		제품 단가 가져오기
		String prodCode = sellDTO.getProdCode();
		int price = sellDTO.getSellCount() * outProductDAO.getProdPrice(prodCode);

		OutProductDTO outProductDTO = new OutProductDTO();
		outProductDTO.setOutCode(code);
		outProductDTO.setProdCode(prodCode);
		outProductDTO.setOutPrice(price);
		outProductDTO.setSellCode(sellDTO.getSellCode());

		outProductDAO.insertList(outProductDTO);

	}

	public String codeChange(String code_id, int num) {
		return String.format("%s%05d", code_id, ++num);
	}

	public List<OutProductDTO> getExcelList(OutProductDTO outProductDTO) {
		return outProductDAO.getExcelList(outProductDTO);
	}

	public void deleteSell(List<String> checked) {
		outProductDAO.deleteSell(checked);
	}

	public void updateList(SellDTO sellDTO) {
//		제품 단가 가져오기
		String prodCode = sellDTO.getProdCode();
		int price = sellDTO.getSellCount() * outProductDAO.getProdPrice(prodCode);

		OutProductDTO outProductDTO = new OutProductDTO();
		outProductDTO.setProdCode(prodCode);
		outProductDTO.setOutPrice(price);
		outProductDTO.setSellCode(sellDTO.getSellCode());

		outProductDAO.updateList(outProductDTO);

	}

	public void updateClientSale(OutProductDTO outProductDTO) {
		outProductDAO.updateClientSale(outProductDTO);
	}

	public EmployeesDTO outProductEmpInfo(EmployeesDTO employeesDTO) {
		return outProductDAO.outProductEmpInfo(employeesDTO);
	}

	public ProdDTO getProdInfo(String data) {
		return outProductDAO.getProdInfo(data);
	}

	public ClientDTO getClientInfo(String data) {
		return outProductDAO.getClientInfo(data);
	}

	public RawmaterialsDTO getRawMaterialInfo(String data) {
		return outProductDAO.getRawMaterialInfo(data);
	}

}
