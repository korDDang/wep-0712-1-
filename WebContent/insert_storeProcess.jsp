<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="DBConn.jsp" %>
<%
try{
	String sql="insert into store0712 values(?,?,?,?)";
	pstmt=conn.prepareStatement(sql);
	pstmt.setString(1, request.getParameter("storeCode"));
	pstmt.setString(2, request.getParameter("storeName"));
	pstmt.setString(3, request.getParameter("productCode"));
	pstmt.setString(4, request.getParameter("Qty"));
	pstmt.executeUpdate();
	%>
	<script>
	alert("매장 테이블 등록 성공");
	location.href="select_store.jsp";
	</script>
	<% 
}catch(SQLException e){
	e.printStackTrace();
	System.out.println("데이터베이스연결 실패");
}
%>
</body>
</html>