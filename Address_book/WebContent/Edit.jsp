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
<title>住所録編集</title>
<link rel="stylesheet" href="css/edit.css">
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
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	String address = request.getParameter("address");
	String tel = request.getParameter("number");
	String categoryid = request.getParameter("categoryid");
	String errmsg = String.valueOf(request.getAttribute("errmsg"));

	int valLen = String.valueOf(tel).length();			// 電話番号の桁数チェック
	if (valLen == 11){					// 11桁ならハイフンを付ける
		tel = new StringBuilder(tel)
				.insert(7, '-')
				.insert(3, '-')
				.toString();
	}





%>
<h3>住所録管理システム:住所録編集</h3>
<form action="../Address_book/EditBL" method="post">
<input type="hidden" name="id" value=<%=id%>>
<input type="hidden" name="oldname" value=<%=name%>>
<input type="hidden" name="oldaddress" value=<%=address%>>
<input type="hidden" name="oldtel" value=<%=tel%>>
<input type="hidden" name="oldcategoryid" value=<%=categoryid%>>
<%if (errmsg != "null") {
out.println("<h2>" + errmsg + "</h2>");
tel = request.getParameter("tel");
}
%>
<div class="table">
<table>
	<tr><th>名前* : </th><td class="addresssize"><input type="text" class="namesize" name="name" value=<%=name%>></td></tr>
	<tr><th>住所* : </th><td class="addresssize"><input type="text" class="address-txt" name="address" value=<%=address%>></td></tr>
	<tr><th>電話番号 : </th><td><input type="text" name="tel" value=<%=tel%>></td></tr>
	<tr><th class="categoryColor">カテゴリ : </th><td><select name=categoryid class="category"><%

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