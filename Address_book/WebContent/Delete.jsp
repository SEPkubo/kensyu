<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="common.Common"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>住所録編集</title>
<link rel="stylesheet" href="css/delete.css">
</head>
<body>
<%  request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	String address = request.getParameter("address");
	String tel = request.getParameter("number");
	String categoryid = request.getParameter("categoryid");

	tel = new StringBuilder(tel)		// 電話番号のハイフン
			.insert(7, '-')
			.insert(3, '-')
			.toString();


%>

<div class="message">
<h3>下記の住所録を削除します。よろしいですか？</h3>
</div>
<form action="../Address_book/DeleteCommitBL" method="post">
<input type="hidden" name="id" value=<%=id%>>
<div class="table">
<table>
	<tr><th class="categorylist">名前</th><th>:</th><td><%=name%></td></tr>
	<tr><th class="categorylist">住所</th><th>:</th><td><%=address%></td></tr>
	<tr><th class="categorylist">電話番号</th><th>:</th><td><%=tel%></td></tr>
	<tr><th class="categorylist">カテゴリ</th><th>:</th><td><%=Common.getCategoryName(categoryid)%></td></tr>

</table>
</div>
<div class="btn-ok">
<button type="submit" class="btn">OK</button>
</div>
</form>
<br>
<div class="btn-return">
<form action="../Address_book/ListBL" method="post">
<button type="submit" class="btn">キャンセル</button>
</form>
</div>
</body>
</html>