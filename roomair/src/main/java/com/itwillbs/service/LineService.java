package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.LineDAO;
import com.itwillbs.domain.LineDTO;
import com.itwillbs.domain.PageDTO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class LineService {
	
	@Inject
	private LineDAO lineDAO;

	public List<LineDTO> getlineList(PageDTO pageDTO) {
		int startRow = (pageDTO.getCurrentPage()-1)*pageDTO.getPageSize() + 1;
		int endRow = startRow + pageDTO.getPageSize() - 1;
		pageDTO.setStartRow(startRow - 1);
		pageDTO.setEndRow(endRow);
		return lineDAO.getlineList(pageDTO);
	}

	public int getlineCount(PageDTO pageDTO) {
		return lineDAO.getlineCount(pageDTO);
	}

	public void insertLine(LineDTO lineDTO) {
		lineDAO.insertLine(lineDTO);
	}

	public void delete(String lineCode) {
		lineDAO.delete(lineCode);
	}

	public LineDTO getLine(String lineCode) {
		return lineDAO.getLine(lineCode);
	}

	public void updateLine(LineDTO lineDTO) {
		lineDAO.updateLine(lineDTO);
	}
	

}
