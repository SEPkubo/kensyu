<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@page import="common.Common"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>住所録登録</title>
<link rel="stylesheet" href="css/add.css">
</head>
<body>
<%request.setCharacterEncoding("utf-8");
String name = request.getParameter("name");
String address = request.getParameter("address");
String tel = request.getParameter("tel");
String categoryid = request.getParameter("categoryid");
%>
<h3>住所録管理システム:住所録登録</h3>
<form action="../Address_book/AddCommitBL" method="post">
<input type="hidden" name="categoryid" value=<%=categoryid%>>
<input type="hidden" name="name" value=<%=name%>>
<input type="hidden" name="address" value=<%=address%>>
<input type="hidden" name="tel" value=<%=tel%>>
<div class="table">
<table>
	<tr><th>名前* : </th><td><%=request.getAttribute("name")%></td></tr>
	<tr><th>住所* : </th><td><%=request.getAttribute("address")%></td></tr>
	<tr><th>電話番号 : </th><td><%=request.getAttribute("tel")%></td></tr>
	<tr><th>カテゴリ:</th><td><%=Common.getCategoryName(categoryid)%></td></tr>

</table>
</div>
<div class="btn-ok">
<input type="submit" value="登録" class="btn">
</div>
</form>

<br>
<div class="btn-return">
<form action="../Address_book/ListBL" method="post">
<input type="submit" value="戻る" class="btn return">
</form>
</div>
</body>
</html>