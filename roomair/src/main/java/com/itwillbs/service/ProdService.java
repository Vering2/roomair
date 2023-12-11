package com.itwillbs.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.ProdDAO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.ProdDTO;

@Service
public class ProdService {

	@Inject
	private ProdDAO prodDAO;

//-----------------------------------------------------------------

	public List<ProdDTO> getProdList(PageDTO pageDTO) {
		System.out.println("2");
		System.out.println("ProdService getProdList()");

		// 10개씩 가져올때 현페이지에 대한 시작하는 행번호 구하기
		int startRow = (pageDTO.getCurrentPage() - 1) * pageDTO.getPageSize() + 1;
		// 끝나는 행번호 구하기
		int endRow = startRow + pageDTO.getPageSize() - 1;

		// 디비 startRow - 1
		pageDTO.setStartRow(startRow - 1);
		pageDTO.setEndRow(endRow);

		return prodDAO.getProdList(pageDTO);
	}

	public void productDelete(List<String> checked) throws Exception {
		prodDAO.productDelete(checked);
	}

	public void insert(ProdDTO prodDTO) {
		System.out.println("ProdDAO insert()");

		prodDAO.insert(prodDTO);
	}// insertBoard()

	public List<ProdDTO> getSearch(ProdDTO prodDTO, PageDTO pageDTO) {
		System.out.println("ProService getSearch()");
		int startRow = (pageDTO.getCurrentPage() - 1) * pageDTO.getPageSize() + 1;
		// 끝나는 행번호 구하기
		int endRow = startRow + pageDTO.getPageSize() - 1;

		// 디비 startRow - 1
		pageDTO.setStartRow(startRow - 1);
		pageDTO.setEndRow(endRow);
		return prodDAO.getSearch(prodDTO, pageDTO);

	}

	public ProdDTO getProd(String prodCode) {
		return prodDAO.getProd(prodCode);
	}

	public void updateProd(ProdDTO prodDTO) {
		prodDAO.updateProd(prodDTO);

	}

	public int getSearchcount(ProdDTO prodDTO) {
		return prodDAO.getSearchcount(prodDTO);
	}

	public int getProdCount(PageDTO pageDTO) {
		return prodDAO.getProdCount(pageDTO);
	}

	public String makeCode() {
		String code = "PR";
		Integer inNum = prodDAO.getMaxNum(code);
		if (inNum == null) {
			inNum = 0;
		}
		return this.codeChange(code, inNum);
	}

	public String codeChange(String code_id, int num) {
		return String.format("%s%04d", code_id, ++num);
	}

	public ProdDTO getProdMemo(String prodCode) {
		System.out.println("ProdService getProdMemo()");
		return prodDAO.getProdMemo(prodCode);
	}// getProdMemo

	public void insertProdMemo(ProdDTO prodDTO) {
		System.out.println("ProdService insertProdMemo()");

		prodDAO.insertProdMemo(prodDTO);
	}// insertProdMemo

	public void updateProdMemo(ProdDTO prodDTO) {
		System.out.println("ProdService updateMemo");
		prodDAO.updateProdMemo(prodDTO);
	}// updateMemo

	public List<ProdDTO> getExcelProdSearch(ProdDTO prodDTO) {
		return prodDAO.getExcelProdSearch(prodDTO);
	}

}
