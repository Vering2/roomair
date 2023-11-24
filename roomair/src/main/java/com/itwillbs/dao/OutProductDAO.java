package com.itwillbs.dao;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.ClientDTO;
import com.itwillbs.domain.EmployeesDTO;
import com.itwillbs.domain.OutProductDTO;
import com.itwillbs.domain.ProdDTO;
import com.itwillbs.domain.RawmaterialsDTO;

@Repository
public class OutProductDAO {

	@Inject
	private SqlSession sqlSession;

	private static final String namespace = "com.itwillbs.mappers.outProductMapper.";

	public List<OutProductDTO> getOutProductList(OutProductDTO outProductDTO) {

		if ("전체".equals(outProductDTO.getSellState())) {
			System.out.println("전체용");
			return sqlSession.selectList(namespace + "getOutProductList", outProductDTO);
		} else if ("총검색".equals(outProductDTO.getSellState())) {
			System.out.println("전체검색");
			return sqlSession.selectList(namespace + "getOutProductListAllSearch", outProductDTO);
		} else {
			System.out.println("나머지용");
			return sqlSession.selectList(namespace + "getOutProductListSearch", outProductDTO);
		}
	}

	public int getOutProductListCount(OutProductDTO outProductDTO) {
		System.out.println("outProductDTO.getSellState(): " + outProductDTO.getSellState());
		if ("전체".equals(outProductDTO.getSellState())) {
			System.out.println("전체용 카운트");
			return sqlSession.selectOne(namespace + "getOutProductListCount", outProductDTO);
		} else if ("총검색".equals(outProductDTO.getSellState())) {
			System.out.println("전체검색 카운트");
			return sqlSession.selectOne(namespace + "getOutProductListAllSearchCount", outProductDTO);
		} else {
			System.out.println("나머지용 카운트");
			return sqlSession.selectOne(namespace + "getOutProductListSearchCount", outProductDTO);
		}
	}

	public OutProductDTO outProductContent(String outCode) {
		return sqlSession.selectOne(namespace + "outProductContent", outCode);
	}

	public void updateSellState(OutProductDTO outProductDTO) {
		sqlSession.update(namespace + "updateSellState", outProductDTO);
	}

	public void updateOutDate(OutProductDTO outProductDTO) {
		sqlSession.update(namespace + "updateOutDate", outProductDTO);
	}

	public void updateOutRedate(OutProductDTO outProductDTO) {
		sqlSession.update(namespace + "updateOutRedate", outProductDTO);
	}

	public void updateWhseCount(OutProductDTO outProductDTO) {
		sqlSession.update(namespace + "updateWhseCount", outProductDTO);
	}

	public void updateOutProductContent(OutProductDTO outProductDTO) {
		sqlSession.update(namespace + "updateOutProductContent", outProductDTO);
	}

	public Integer getMaxNum(String code) {
		return sqlSession.selectOne(namespace + "getMaxNum", code);
	}

	public int getProdPrice(String prodCode) {
		return sqlSession.selectOne(namespace + "getProdPrice", prodCode);
	}

	public void insertList(OutProductDTO outProductDTO) {
		sqlSession.insert(namespace + "insertList", outProductDTO);
	}

	public List<OutProductDTO> getExcelList(OutProductDTO outProductDTO) {
		if ("전체".equals(outProductDTO.getSellState())) {
			System.out.println("전체용");
			return sqlSession.selectList(namespace + "getExcelList", outProductDTO);
		} else if ("총검색".equals(outProductDTO.getSellState())) {
			System.out.println("전체검색");
			return sqlSession.selectList(namespace + "getExcelListAllSearch", outProductDTO);
		} else {
			System.out.println("나머지용");
			return sqlSession.selectList(namespace + "getExcelListSearch", outProductDTO);
		}
	}

	public void deleteSell(List<String> checked) {

		Iterator<String> it = checked.iterator();

		while (it.hasNext()) {
			String code = it.next();
			System.out.println("삭제할 코드 값 : " + code);
			sqlSession.delete(namespace + "deleteSell", code);
		}
	}

	public void updateList(OutProductDTO outProductDTO) {
		sqlSession.update(namespace + "updateList", outProductDTO);
	}

	public void updateClientSale(OutProductDTO outProductDTO) {
		sqlSession.update(namespace + "updateClientSale", outProductDTO);
		
	}

	public EmployeesDTO outProductEmpInfo(EmployeesDTO employeesDTO) {
		return sqlSession.selectOne(namespace + "outProductEmpInfo", employeesDTO); 
	}

	public ProdDTO getProdInfo(String data) {
		return sqlSession.selectOne(namespace + "getProdInfo", data); 
	}

	public ClientDTO getClientInfo(String data) {
		return sqlSession.selectOne(namespace + "getClientInfo", data); 
	}

	public RawmaterialsDTO getRawMaterialInfo(String data) {
		return sqlSession.selectOne(namespace + "getRawMaterialInfo", data); 
	}

}
