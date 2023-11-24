package com.itwillbs.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.WarehouseDTO;

@Repository
public class WarehouseDAO {
	
	// 마이바티스 객체생성
	@Inject
	private SqlSession sqlSession;
	
	private static final String namespace="com.itwillbs.Mappers.WarehouseMapper";

	public WarehouseDTO getWarehouse(String whseCode) {
		System.out.println("WarehouseDAO getWarehouse()");
		return sqlSession.selectOne(namespace+".getWarehouse", whseCode);
	}

	public List<WarehouseDTO> getWarehouseList(PageDTO pageDTO) {
		System.out.println("WarehouseDAO getWarehouseList()");
		return sqlSession.selectList(namespace+".getWarehouseList", pageDTO);
	}

	public int getWarehouseCount(PageDTO pageDTO) {
		System.out.println("WarehouseDAO getWarehouseCount()");
		return sqlSession.selectOne(namespace+".getWarehouseCount", pageDTO);
	}

	public void insertWarehouse(WarehouseDTO warehouseDTO) {
		System.out.println("WarehouseDAO insertWarehouse()");
		System.out.println(warehouseDTO);
		sqlSession.insert(namespace+".insertWarehouse", warehouseDTO);
	}

	public void updateWarehouse(WarehouseDTO warehouseDTO) {
		System.out.println("WarehouseDAO updateWarehouse()");
		sqlSession.update(namespace+".updateWarehouse", warehouseDTO);
	}

	public void delete(String whseCode) {
		sqlSession.delete(namespace+".delete", whseCode);
	}

}
