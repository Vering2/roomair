package com.itwillbs.dao;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.ProdDTO;

@Repository
public class ProdDAO {
	@Inject
	private SqlSession sqlSession;
	
	private static final String namespace="com.itwillbs.mappers.proMapper";
//	---------------------------------------------------------------------------
	
	public List<ProdDTO> getProdList(PageDTO pageDTO) {
		System.out.println("3");
		System.out.println("ProdDAO getProdList()");
		
		return sqlSession.selectList(namespace+".getProdList", pageDTO);
	}
	
	 public void productDelete(List<String> checked) throws Exception {
			Iterator<String> it = checked.iterator();
			int result = 0;
			while (it.hasNext()) {
				String prodCode = it.next();
				result += sqlSession.delete(namespace + ".productDelete", prodCode);
			}
		}
	
	public void insert(ProdDTO prodDTO) {
		System.out.println("ProdDAO insert()");
		
		sqlSession.insert(namespace+".insert", prodDTO);
	}//insertBoard()
	
	public List<ProdDTO> getSearch(ProdDTO prodDTO, PageDTO pageDTO) {
		HashMap<String, Object> data = new HashMap<String, Object>();
		System.out.println("ProdDAO getSearch()");
		
		data.put("startRow", pageDTO.getStartRow());
		data.put("pageSize", pageDTO.getPageSize());
		data.put("prodCode", prodDTO.getProdCode());
		data.put("prodName", prodDTO.getProdName());
		data.put("clientCompany", prodDTO.getClientCompany());

		return sqlSession.selectList(namespace+".getSearch", data);
	}

	public ProdDTO getProd(String prodCode) {
		
		return sqlSession.selectOne(namespace+".getProd", prodCode);
	}

	public void updateProd(ProdDTO prodDTO) {
		sqlSession.update(namespace+".updateProd",prodDTO);
	}
	
	public int getSearchcount(ProdDTO prodDTO) {
		return sqlSession.selectOne(namespace+".getSearchcount",prodDTO);
	}

	public int getProdCount(PageDTO pageDTO) {
		return sqlSession.selectOne(namespace+".getProdCount",pageDTO);
	}

	public Integer getMaxNum(String code) {
		return sqlSession.selectOne(namespace+".getMaxNum",code);
	}

	public ProdDTO getProdMemo(String prodCode) {
		System.out.println("ProdDAO getProdMemo()");
		return sqlSession.selectOne(namespace+".getProdMemo", prodCode);
	}//getProdMemo

	public void insertProdMemo(ProdDTO prodDTO) {
		System.out.println("ProdDAO insertProdMemo()");
		System.out.println(prodDTO);
		sqlSession.insert(namespace + ".insertProdMemo", prodDTO);
	}// insertProdMemo

	public void updateProdMemo(ProdDTO prodDTO) {
		System.out.println("ProdDAO updateProdMemo()");
		sqlSession.update(namespace + ".updateProdMemo", prodDTO);
	}// updateProdMemo

	//엑셀

	public List<ProdDTO> getExcelProdSearch(ProdDTO prodDTO) {
		return sqlSession.selectList(namespace + ".getExcelProdSearch", prodDTO);
	}

	
	
	

}


