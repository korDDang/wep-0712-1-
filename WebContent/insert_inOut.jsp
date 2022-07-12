
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
function ch() {
	var doc=document.form;
	doc.submit();
}
function check() {
	var doc=document.form;
	var chk=document.getElementsByName("gubun");
	int cnt=0;
	for(var i=0; i<chk.length;i++){
		if(chk[i].checked==true){
			cnt++;
			break;
		}
	}
	if(doc.inOutDate.value==""){
		alert("입출고 일자를 입력해주세요");
		doc.inOutDate.focus();
		return false;
	}if(doc.storeCode.value==""){
		alert("매장코드를 입력해주세요");
		doc.storeCode.focus();
		return false;
	}if(doc.productCode.value==""){
		alert("상품코드를 입력해주세요");
		doc.productCode.focus();
		return false;
	}if(doc.saleQty.value==""){
		alert("입출고 수량을 입력해주세요");
		doc.saleQty.focus();
		return false;
	}if(cnt==0){
		alert("구분을 체크해주세요");
		return false;
	}else{
		form.action="insert_inOutProcess.jsp";
	}
}
</script>
</head>
<body>
<%@ include file="header.jsp" %>
<%@ include file="nav.jsp" %>
<%@ include file="DBConn.jsp" %>
<section id="sec1">
<%
String inOutDate=request.getParameter("inOutDate");
if(inOutDate==null){
	inOutDate="";
}

String productCode=request.getParameter("productCode");
if(productCode==null){
	productCode="";
}
int total=0;
int qty=0;
String saleQty=request.getParameter("saleQty");
if(saleQty==null){
	saleQty="0"; 
}else{
	qty=Integer.parseInt(saleQty);
}
String unitPrice=request.getParameter("unitPrice");
if(unitPrice==null){
	unitPrice="0"; 
}else{
	total=Integer.parseInt(unitPrice);
}
String storeName="";
String productName="";

String storeCode=request.getParameter("storeCode");
if(storeCode==null){
	storeCode="";
}else{
	try{
		String sql="select p.productName,s.storeName from product0712 p,store0712 s where p.productCode=s.productCode and p.productCode=? and p.storeCode=? ";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, productCode);
		pstmt.setString(2, storeCode);
		rs=pstmt.executeQuery();
		if(rs.next()){
			productName=rs.getString(1);
			storeName=rs.getString(2);
		}
	}catch(SQLException e){
		e.printStackTrace();
	}
}
%>
<h2>입출고 정보 등록</h2>
<form name="form" method="post" action="insert_inOut.jsp">
<table border="1" id="tab1">
<tr>
<th class="th1">입출고일자</th>
<td colspan="3">
<input type="text" name="inOutDate" value=<%=inOutDate %>>
</td>
</tr>
<tr>
<th class="th1">매장코드</th>
<td>
<input type="text" name="storeCode" value=<%=storeCode%>></td>
<th class="th1">매 장 명</th>
<td>
<input type="text" name="storeName" value=<%=storeName %>></td>
</tr>
<tr>
<th class="th1">상품코드</th>
<td>
<input type="text" name="productCode" onchange="ch()" value=<%=productCode %>></td>
<th class="th1">상 품 명</th>
<td>
<input type="text" name="productName" value=<%=productName %>></td>
</tr>
<tr>
<th class="th1">입출고 수량</th>
<td colspan="3">
<input type="radio" name="gubun" value="1" checked>입고
<input type="radio" name="gubun" value="2">출고
</td>
</tr>
<tr>
<th class="th1">입출고 수량</th>
<td>
<input type="text" name="saleQty" value=<%=saleQty %>></td>
<th class="th1">입출고 금액</th>
<td>
<input type="text" name="total" value=<%=total %>></td>
</tr>
<tr>
<td colspan="4" class="td1">
<input type="button" value="목록" onclick="location.href='select_inOut.jsp'" class="bt2">
<input type="submit" value="저장" onclick="check()" class="bt2">
</table>
</form>
</section>
<%@ include file="footer.jsp" %>
</body>
</html>