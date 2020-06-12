<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="common.Common"%>
<%@page import="java.util.ArrayList "%>
<%@page import="java.sql.SQLException"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>住所録登録</title>
<link rel="stylesheet" href="css/add.css">
</head>
<body>
<%ResultSet rs = Common.getCategoryAll();

ArrayList<String> list = new ArrayList<String>();

try {
	while (rs.next()) {
		String s = rs.getString("categoryid");			// カテゴリid取得
		list.add(s);
	}
} catch (Exception e) {
	e.printStackTrace();
} finally {
	if (rs != null) {
		try {
			rs.close();
		} catch (SQLException sqlEx) {
		}
	}
}


%>




<%
	request.setCharacterEncoding("utf-8");
	String name = "";
	String address = "";
	String tel = "";
	String categoryid = "";
	String errmsg = "";%>
<%if(request.getAttribute("name") != null) {
	name = String.valueOf(request.getAttribute("name"));		// stringにキャスト
	address = String.valueOf(request.getAttribute("address"));
	tel = String.valueOf(request.getAttribute("tel"));
	categoryid = String.valueOf(request.getAttribute("categoryid"));
	errmsg = String.valueOf(request.getAttribute("errmsg"));
}

%>
<h3>住所録管理システム:住所録登録</h3>
<%if (errmsg != "") {
out.println("<h2>" + errmsg + "</h2>");
}
%>

<form action="../Address_book/AddBL" method="post">
<div class="table">
<table>
	<tr><th>名前* : </th><td><input type="text" name="name" value=<%=name%>></td></tr>
	<tr><th>住所* : </th><td><input type="text" class="address-txt" name="address" value=<%=address%>></td></tr>
	<tr><th>電話番号 : </th><td><input type="text" name="tel" value=<%=tel%>></td></tr>
	<tr><th>カテゴリ : </th><td><select class="category" name=categoryid><%

	if(categoryid == null || categoryid == ""){
		categoryid = "-1";
	}
	for (String str : list) {


			if (Integer.parseInt(categoryid) == Integer.parseInt(str)) {		// 数値に変換してから比較する
				out.println("<option value=" + str + " selected>" + str + "</option>");		// 取得したカテゴリidを選択状態にする
			} else {
				out.println("<option value=" + str + ">" + str + "</option>");
			}



	} %>
</select></td></tr>
</table>
</div>
<div class="btn-ok">
<button type="submit" class="btn">確認</button>
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