<%@page import="java.io.Console"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="bean.BoardDTO"%>
<%@page import="bean.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
		
		<%
			BoardDAO dao = new BoardDAO();
			BoardDTO dto = new BoardDTO();
			// 날짜
			Calendar cal = Calendar.getInstance();
			int year = cal.get(cal.YEAR);
			int month = cal.get(cal.MONTH);
			int day = cal.get(cal.DATE);
			String date=null;
			
			if(month < 10){
				date = Integer.toString(year) + "0"  + Integer.toString(month) + Integer.toString(day);
			}else if(month >= 10){
				date = Integer.toString(year) + Integer.toString(month) + Integer.toString(day);
			}
			// write.jsp에서 값 받아오기
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			String num1 = request.getParameter("num");
			int num = Integer.parseInt(num1);
			
			System.out.print(num); //0 출력됨
			// dto에 넣을 값 세팅
			dto.setTitle(title);
			dto.setContent(content);
			dto.setDate(date);
			dto.setNum(num);
			
			dao.update(dto);
			/* out.write(dto.toString()); */
		%>
