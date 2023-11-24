package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.WarehouseDAO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.WarehouseDTO;

@Service
public class WarehouseService {
	
	@Inject
	private WarehouseDAO warehouseDAO;

	public List<WarehouseDTO> getWarehouseList(PageDTO pageDTO) {
		System.out.println("WarehouseService getWarehouseList()");
		// 시작하는 행번호
		int startRow=(pageDTO.getCurrentPage()-1)*pageDTO.getPageSize()+1;
		// 끝나는 행번호
		int endRow = startRow + pageDTO.getPageSize()-1;
		// 디비작업 startRow -1
		pageDTO.setStartRow(startRow-1);
		pageDTO.setEndRow(endRow);
		return warehouseDAO.getWarehouseList(pageDTO);
	} // getWarehouseList

	public int getWarehouseCount(PageDTO pageDTO) {
		
		return warehouseDAO.getWarehouseCount(pageDTO);
	}


	public void insertWarehouse(WarehouseDTO warehouseDTO) {
		System.out.println("WarehouseService insert()");
		
		warehouseDAO.insertWarehouse(warehouseDTO);
	}

	public WarehouseDTO getWarehouse(String whseCode) {
		System.out.println("WarehouseService getWarehouse()");
		return warehouseDAO.getWarehouse(whseCode);
	}

	public void updateWarehouse(WarehouseDTO warehouseDTO) {
		System.out.println("WarehouseService update()");
		warehouseDAO.updateWarehouse(warehouseDTO);
	}

	public void delete(String whseCode) {
		warehouseDAO.delete(whseCode);
	}

}
