package common;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Common {

	public static String getErr(String name,String address,String tel) {

		String ERRMSG_NAME01 = "名前は全角20文字以内で入力してください";
		String ERRMSG_NAME02 = "名前は必須項目です";
		String ERRMSG_ADDRESS01 = "住所は全角40文字以内で入力してください";
		String ERRMSG_ADDRESS02 = "住所は必須項目です";
		String ERRMSG_TEL01 = "電話番号は「000-0000-0000」の形式で入力してください";
		String ERRMSG_TEL02 = "電話番号は数字で入力してください";


		String tel2 = tel.replace("-", "");		// ハイフンを除外した電話番号
		String returnVal = "";
		Pattern pattern = Pattern.compile("^\\d{3}-\\d{4}-\\d{4}$");		// 電話番号の型判定
		Matcher matcher = pattern.matcher(tel);
		Pattern pattern2 = Pattern.compile("^\\d{11}$");		// 電話番号の数字判定
		Matcher matcher2 = pattern2.matcher(tel2);

		try {
			if(name.getBytes("Shift-JIS").length > 40) {
				returnVal += ERRMSG_NAME01 + "<BR>";
			}

			if (name.getBytes("Shift-JIS").length == 0) {
				returnVal += ERRMSG_NAME02 + "<BR>";
			}

			if (address.getBytes("Shift-JIS").length > 80) {
				returnVal += ERRMSG_ADDRESS01 + "<BR>";
			}

			if (address.getBytes("Shift-JIS").length == 0) {
				returnVal += ERRMSG_ADDRESS02 + "<BR>";
			}

			if (tel.getBytes("Shift-JIS").length > 0 && matcher.find() == false) {
				if(matcher2.find() == false) {
					returnVal += ERRMSG_TEL02 + "<BR>";
				} else {
					returnVal += ERRMSG_TEL01 + "<BR>";
				}

			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return returnVal;

	}



public static ResultSet getCategoryAll() {


	Connection connect = null;
	Statement stmt = null;
	ResultSet rs = null;



	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		connect = DriverManager.getConnection(
		"jdbc:mysql://localhost:3306/kubo?characterEncoding=UTF-8&serverTimezone=JST",
		"root","");
		String getQuery = ("SELECT categoryid FROM category ORDER BY categoryid ASC");
		PreparedStatement ps = connect.prepareStatement(getQuery);
		stmt = connect.createStatement();


		rs = ps.executeQuery();


	} catch (Exception e) {
		e.printStackTrace();
	}

	return rs;

	}


public static String getCategoryName(String id) {

	Connection connect = null;
	Statement stmt = null;
	ResultSet rs = null;

	String categoryname = null;


	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		connect = DriverManager.getConnection(
		"jdbc:mysql://localhost:3306/kubo?characterEncoding=UTF-8&serverTimezone=JST",
		"root","");
		String getQuery = ("SELECT categoryname FROM category WHERE categoryid = ?");
		PreparedStatement ps = connect.prepareStatement(getQuery);

		ps.setString(1,id);
		rs = ps.executeQuery();
		rs.next();
		categoryname = rs.getString(1);


	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException sqlEx) {
			}
		}
		if (stmt != null) {
			try {
				stmt.close();
			} catch (SQLException sqlEx) {
			}
		}
		if (connect != null) {
			try {
				connect.close();
			} catch (SQLException sqlEX) {

			}
		}
	}
	return categoryname;

}







}
