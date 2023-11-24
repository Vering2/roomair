package com.itwillbs.service;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.CalendarDAO;
import com.itwillbs.domain.CalendarDTO;
import com.itwillbs.domain.ChartDTO;
import com.itwillbs.domain.ClientDTO;
import com.itwillbs.domain.OrderManagementDTO;
import com.itwillbs.domain.SellDTO;

@Service
public class CalendarService {
	
	@Inject
	private CalendarDAO calendarDAO;

	public List<CalendarDTO> getCalendarList() {
		return calendarDAO.getCalendarList();
	}

	public List<ChartDTO> getSalesList() {
		return calendarDAO.getSalesList();
	}

	public List<ChartDTO> getStockList() {
		return calendarDAO.getStockList();
	}

	public List<ChartDTO> getPerfList() {
		return calendarDAO.getPerfList();
	}

	public List<ChartDTO> getLinePerfList() {
		return calendarDAO.getLinePerfList();
	}
	
	public void insertSellCalendar(SellDTO sellDTO) {
		
		CalendarDTO calendarDTO = new CalendarDTO();
		
		calendarDTO.setCode(sellDTO.getSellCode());
		calendarDTO.setCalendar_title("수주");
		calendarDTO.setStartDate(sellDTO.getSellDate());
		calendarDTO.setEndDate(sellDTO.getSellDuedate());
		
		String memo = sellDTO.getClientCompany() + " " + sellDTO.getProdName() +"("+ sellDTO.getProdCode() + ") " + sellDTO.getSellCount();
		calendarDTO.setCalendar_memo(memo);
		
		calendarDAO.insertSellCalendar(calendarDTO);
	}

	public void insertOrderCalendar(OrderManagementDTO ordermanagementDTO) {
		CalendarDTO calendarDTO = new CalendarDTO();
		
		String clientCode = ordermanagementDTO.getClientCode();
		ClientDTO clientDTO = calendarDAO.getClient(clientCode);
		
		calendarDTO.setCode(ordermanagementDTO.getBuyNum());
		calendarDTO.setCalendar_title("원자재 발주");
		Date date = ordermanagementDTO.getBuyDate();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String formattedDate = dateFormat.format(date);
		calendarDTO.setStartDate(formattedDate);
		String memo = clientDTO.getClientCompany() + " " + ordermanagementDTO.getRawName() +"("+ ordermanagementDTO.getRawCode() + ") " + ordermanagementDTO.getBuyCount();
		calendarDTO.setCalendar_memo(memo);
	}

	public void deleteSellCalendar(List<String> checked) {
		calendarDAO.deleteSellCalendar(checked);
	}

	
	
	
}
