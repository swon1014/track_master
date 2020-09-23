<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%
	// 데이터 베이스 접속 정보
	String driver = "oracle.jdbc.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String id = "scott";
	String pw = "1234";
	
	// 접속
	Class.forName(driver);
	Connection db = DriverManager.getConnection(url, id, pw);
	
	request.setCharacterEncoding("utf-8");
	
	// 업로드 파일 최대 용량
	int maxSize = 1024 * 1024 * 100;		// 100mb
	// 이름 변경 정책(중복된 파일명이 올라왔을 경우 뒤에 숫자를 붙힌다)
	DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
	// 저장될 서버상의 경로
	String path = getServletContext().getRealPath("/upload");
	// 업로드 처리
	MultipartRequest mr = new MultipartRequest(request, path, maxSize, "UTF-8", policy);
	
	String str1 = mr.getParameter("content_idx");
	int content_idx = Integer.parseInt(str1);
	
	String content_subject = mr.getParameter("content_subject");
	String content_text = mr.getParameter("content_text");
	String content_file = mr.getFilesystemName("content_file");
	
	String sql = "update content_table set "
			+ "content_subject = ?, content_text = ? ";
	
	if(content_file != null){
		sql += ", content_file = ?";
	}
	
	sql += " where content_idx = ?";
	
	PreparedStatement pstmt = db.prepareStatement(sql);
	pstmt.setString(1, content_subject);
	pstmt.setString(2, content_text);
	
	if(content_file != null){
		pstmt.setString(3, content_file);
		pstmt.setInt(4, content_idx);
	} else {
		pstmt.setInt(3, content_idx);
	}
	
	pstmt.execute();
	
	db.close();
%>
{
	"result" : true
}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
