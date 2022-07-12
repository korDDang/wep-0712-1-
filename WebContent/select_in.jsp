<%@ page import="java.text.DecimalFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>입/출고 정보 목록</title>
</head>
<body>
<%@ include file="header.jsp" %>
<%@ include file="nav.jsp" %>
<%@ include file="DBConn.jsp" %>
<section id="sec1">
<br>
<h2>입고 정보(금액)목록</h2>
<hr>
<table border="1" id="tab1">
<tr>
	<th class="th1">no</th>
	<th class="th1">입.출고일자</th>
	<th class="th1">매장코드</th>
	<th class="th1">매 장 명</th>
	<th class="th1">상품코드</th>
	<th class="th1">상 품 명</th>
	<th class="th1">입고수량</th>
	<th class="th1">단가</th>
	<th class="th1">입고금액</th>
</tr>
<%
int total=0;
int no=0;
try{
	String sql="select to_char(i.inOutDate,'YYYY-MM-DD'),i.storeCode,s.storeName,i.productCode,p.productName,i.saleQty,p.unitPrice from product0712 p,store0712 s,inOut0712 i where i.storeCode=s.storeCode and i.productCode=p.productCode and i.gubun=2 ";
	pstmt=conn.prepareStatement(sql);
	rs=pstmt.executeQuery();
	while(rs.next()){
		String inOutDate=rs.getString(1);
		String storeCode=rs.getString(2);
		String storeName=rs.getString(3);
		String productCode=rs.getString(4);
		String productName=rs.getString(5);
		int saleQty=rs.getInt(6);
		int unitPrice=rs.getInt(7);
		total=saleQty*unitPrice;
		no++;
	
%>
<tr>
<td class="td1"><%=no %></td>
<td class="td1"><%=inOutDate %></td>
<td class="td1"><%=storeCode %></td>
<td class="td1"><%=storeName %></td>
<td class="td1"><%=productCode%></td>
<td class="td1"><%=productName%></td>
<td class="td1"><%=saleQty%></td>
<td class="td1"><%=unitPrice%></td>
<td class="td1"><%=total%></td>
</tr>
<%
	}


	}catch(Exception e){
		e.printStackTrace();
		System.out.println("조회실패");
	}
%>
</table>
<div class="td1"><input type="button" value="입출고 정보 추가" onclick="location.href='insert_inOut.jsp'" class="bt2"></div>
</section>
<%@ include file="footer.jsp" %>
</body>
</html>