<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList "%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="common.Common"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>住所録管理システム</title>
<link rel="stylesheet" href="css/style.css">
<script type="text/javascript">

function mOver(num,obj) {		// ポップアップする住所を取得
	var address = "";

	address = document.getElementById("address" + num).value;
    document.getElementById(obj).innerHTML = address;
    document.getElementById(obj).style.visibility = "visible";

}

function mOut(obj) {	// 非表示にする
    document.getElementById(obj).style.visibility = "hidden";
}



</script>


</head>
<body>


<%
ArrayList<String> list = new ArrayList<String>();
String SerchName = String.valueOf(request.getAttribute("SerchName"));
if (request.getAttribute("SerchName") == null){
	SerchName = "";
}
int maxPage = 0;
int nowPage = 0;
if (request.getAttribute("Page") == null) {			// ListBLで一覧を取得
	getServletContext().getRequestDispatcher("/ListBL").forward(request, response);
} else {

	ResultSet rs = (ResultSet) request.getAttribute("Result");
 	nowPage = Integer.parseInt(String.valueOf(request.getAttribute("Page")));		// intにキャスト


	maxPage = Integer.parseInt(String.valueOf(request.getAttribute("listCnt")));	// maxPageにlistCntを代入

	if (maxPage != 0){		// maxPageにlistCntを10で割った値を代入
		if (maxPage % 10 >= 1){

			maxPage = maxPage / 10 + 1;
		} else {
			maxPage /= 10;
		}
	} else {
		maxPage = 0;
	}





	if (rs != null){
	try {
		String tel = "";
		int cnt = 0;
		int listcnt = 0;		// 通し番号
		if(nowPage >= 2) {
			listcnt = nowPage * 10 + 1;
		} else {
			listcnt = 1;
		}
		while (rs.next()) {
			tel = "";
			if (rs.getString("tel").getBytes("UTF-8").length == 11) {	// 電話番号が11文字か判定

				tel = new StringBuilder(rs.getString("tel"))		// 電話番号のハイフン表示
						.insert(7, '-')
						.insert(3, '-')
						.toString();

			}

			String s = "<tr><td>" + listcnt + "</td><td>" + rs.getString("name") + "</td><td><div class=listaddress onmouseover=mOver(" + cnt + ",'info1') onmouseout=mOut('info1')>" +		 // 一覧表示 hidden項目で値を保持させる
					rs.getString("address") + "</div></td><td>" + tel + "</td><td class=categoryColor>" + Common.getCategoryName(rs.getString("categoryid"))
					+ "</td><td bgcolor=#808080><form action=../Address_book/Edit.jsp method=post><input type=hidden name=id value=" + String.valueOf(rs.getInt("id")) +		// 編集画面のボタン・保持する値
					"><input type=hidden name=name value=" + rs.getString("name") + "><input type=hidden name=address value=" + rs.getString("address") +
					"><input type=hidden name=number value=" + rs.getString("tel") + "><input type=hidden name=categoryid value=" + rs.getString("categoryid") +
					"><button class=btn-edit-delete type=submit>編集</button></form></td><td  bgcolor=#808080><form action=../Address_book/Delete.jsp method=post><input type=hidden name=id value=" + String.valueOf(rs.getInt("id")) +	// 削除画面のボタン・保持する値
					"><input type=hidden name=name value=" + rs.getString("name") + "><input type=hidden name=address value=" + rs.getString("address") +
					"><input type=hidden name=number value=" + rs.getString("tel") + "><input type=hidden name=categoryid value=" + rs.getString("categoryid") +
					"><button class=btn-edit-delete type=submit>削除</button></form></td><tr><input type=hidden id=address" + cnt + " value=" + rs.getString("address") + ">";
					cnt++;
					listcnt++;
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
	}

}


%>
<div id="info1" style="position:absolute; top:145px; left:170px;z-index: 2; visibility:hidden;  font-size:5; background-color:#FFFFFF; border-style:ridge;">info</div>		<%-- ポップアップ表示 --%>
<h3>住所録管理システム:住所録一覧</h3>
<br>




<form  action="../Address_book/Add.jsp" method="post">
<button type="submit" class="btn-sinki">新規登録</button>
</form>
<br>
<div class="kensaku">
<form action="../Address_book/ListBL" method="post">
<table >
	<tr>
		<th><input class="kensaku-txt" type="text" name="Serchname" value=<%=SerchName%>></th>
	</tr>

	<tr>

		<th><button type="submit" class="btn-kensaku">検索</button></th>
	</tr>

</table>
</form>
</div>
<br>
<div class="pagelist">
<%

int max = 5;		// ページネーションで表示させる番号ボタンの数
int listPage = 0;	// ページネーションで表示させる番号ボタンの始まり
String check = ""; // 活性・非活性判定文字
String lastcheck = ""; // 活性・非活性判定文字
if (maxPage < 5){
	max = maxPage;
}

	if(maxPage != 0){	// maxPageが0ならページネーションの判定をしない

		if (nowPage - 2 > 0){	// ページネーションの番号ボタンの始まりを判定
			if(nowPage > maxPage - 2) {
				if (maxPage < 5){
					listPage = 1;
				} else {
					listPage = nowPage - 2 - (nowPage - (maxPage -2));
				}
			} else {
				listPage = nowPage - 2;
			}

		} else {
			listPage = 1;
		}
	}

out.println("<form action=../Address_book/ListBL method=post>" +
		"<ul class=example2>"
		);
if (request.getAttribute("SerchName") != null){
	out.println("<input type=hidden name=Serchname value=" + request.getAttribute("SerchName") + ">");
}

	if (nowPage == 1 || maxPage == 0) {		// 活性・非活性判定
		check = "disabled";
	}

	if (nowPage == maxPage || maxPage == 0) {
		lastcheck = "disabled";
	}

		out.println("<li class=listfirst><button class=page-btn type=submit name=page value=1 " + check + ">&#171;</button></li>");		// ここからページネーションの処理
		out.println("<li><button class=page-btn type=submit name=page value=" + (nowPage - 1) + " "  + check + ">&#8249;</button></li>");


	for (int i = listPage;i < listPage + 5 && i <= maxPage && maxPage != 0;i++){

		if (i == nowPage){
			out.println("<li><button class=page-btn type=submit name=page value=" + i + " disabled>" + i + "</button></li>");
		} else {
			out.println("<li><button class=page-btn type=submit name=page value=" + i + ">" + i + "</button></li>");
		}

	}
		out.println("<li><button class=page-btn type=submit name=page value=" + (nowPage + 1) + " " + lastcheck + ">&#8250;</button></li>");
		out.println("<li><button class=page-btn type=submit name=page value=" + maxPage + " " + lastcheck + ">&#187;</button></li>");
		out.println("</ul></form>");

%>
</div>
<br>
<br>


<div class="table">
 <table class="box">
        <tr bgcolor="6495ed">
            <th>No.</th>
            <th class="name">名前</th>
            <th class="address">住所</th>
            <th class="tel">電話番号</th>
            <th class="categoryColor">カテゴリ</th>
            <th colspan="2">&emsp;&emsp;</th>

        </tr>

<% for (String str : list) {		// リスト表示
	out.println(str);
}%>



    </table>
    </div>
    <div class="a">
    <%
    out.println("<form action=../Address_book/ListBL method=post>" +
    		"<ul class=example2>"
    		);
    if (request.getAttribute("SerchName") != null){
    	out.println("<input type=hidden name=Serchname value=" + request.getAttribute("SerchName") + ">");
    }

    out.println("<li class=listfirst><button class=page-btn type=submit name=page value=1 " + check + ">&#171;</button></li>");		// ここからページネーションの処理
	out.println("<li><button class=page-btn type=submit name=page value=" + (nowPage - 1) + " "  + check + ">&#8249;</button></li>");


for (int i = listPage;i < listPage + 5 && i <= maxPage && maxPage != 0;i++){

	if (i == nowPage){
		out.println("<li><button class=page-btn type=submit name=page value=" + i + " disabled>" + i + "</button></li>");
	} else {
		out.println("<li><button class=page-btn type=submit name=page value=" + i + ">" + i + "</button></li>");
	}

}
	out.println("<li><button class=page-btn type=submit name=page value=" + (nowPage + 1) + " " + lastcheck + ">&#8250;</button></li>");
	out.println("<li><button class=page-btn type=submit name=page value=" + maxPage + " " + lastcheck + ">&#187;</button></li>");
	out.println("</ul></form>");

    %>
    </div>
    <br>
    <br>
    <br>
<form action="../Address_book/Add.jsp" method="post">
    <button type="submit" class="btn-sinki">新規登録</button>
</form>

</body>
</html>