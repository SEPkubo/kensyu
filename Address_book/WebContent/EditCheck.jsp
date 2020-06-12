<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="common.Common"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>住所録編集</title>
<link rel="stylesheet" href="css/editcheck.css">
</head>
<body>

<%  request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	String address = request.getParameter("address");
	String tel = request.getParameter("tel");
	String categoryid = request.getParameter("categoryid");

%>
<h3>住所録管理システム:住所録編集</h3>
<form action="../Address_book/EditCommitBL" method="post">
<input type="hidden" name="id" value=<%=id%>>
<input type="hidden" name="categoryid" value=<%=categoryid%>>
<input type="hidden" name="name" value=<%=name%>>
<input type="hidden" name="address" value=<%=address%>>
<input type="hidden" name="tel" value=<%=tel%>>

<input type="hidden" name="oldcategoryid" value=<%=request.getParameter("oldcategoryid")%>>
<input type="hidden" name="oldname" value=<%=request.getParameter("oldname")%>>
<input type="hidden" name="oldaddress" value=<%=request.getParameter("oldaddress")%>>
<input type="hidden" name="oldtel" value=<%=request.getParameter("oldtel")%>>
<div class="table">
<table>
	<tr><th>名前* : </th><td><%=name%></tr>
	<tr><th>住所* : </th><td><%=address%></td></tr>
	<tr><th>電話番号 : </th><td><%=tel%></td></tr>
	<tr><th>カテゴリ:</th><td><%=Common.getCategoryName(categoryid)%></td></tr>

</table>
</div>
<div class="btn-ok">
<button type="submit" class="btn">編集</button>
</div>
</form>
<br>
<div class="btn-return">
<form action="../Address_book/ListBL" method="post">
<button type="submit" class="btn">戻る</button>
</form>
</div>
</body>
</html>