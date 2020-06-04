package bl;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/ListBL")
public class ListBL extends HttpServlet {
	private static final long serialVersionUID = 1L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			 throws ServletException,IOException
			 {

		request.setCharacterEncoding("utf-8");
		Connection connect = null;  //DB接続用変数
		Statement stmt = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int listCnt = 0;				// 総件数
		int list = 0;					// 表示させる件数
		String SelectQuery = null;		// 表取得用クエリ
		String CntQuery = null;		// 件数取得用クエリ
		String nowPage = request.getParameter("page");		// 現在のページ
		if (nowPage == null) {		// 取得したページの値がnullなら1を代入する
			nowPage = "1";
		}

		String SerchName = request.getParameter("Serchname");		// 検索用文字列
		int limitSta = (Integer.parseInt(nowPage) - 1) * 10;				// 検索開始件数
		if (SerchName == "" || SerchName == null) {


			try {		// 検索文字列が無い場合の処理
				Class.forName("com.mysql.cj.jdbc.Driver");
				connect = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/test?characterEncoding=UTF-8&serverTimezone=JST",
				"root","user");
				CntQuery = ("SELECT COUNT(*) cnt FROM jyusyoroku,category WHERE jyusyoroku.categoryid = category.categoryid AND delete_flg=0");
				ps = connect.prepareStatement(CntQuery);
				rs = ps.executeQuery();

				rs.next();
				listCnt = rs.getInt("cnt");			// 総件数取得
				if(listCnt > 10) {		// 表示件数
					list = 10;
				} else {
					list = listCnt;
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

			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				connect = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/test?characterEncoding=UTF-8&serverTimezone=JST",
				"root","user");
				SelectQuery = ("SELECT * FROM jyusyoroku,category WHERE jyusyoroku.categoryid = category.categoryid AND delete_flg=0 ORDER BY address ASC,tel ASC,id LIMIT ?,?");
				ps = connect.prepareStatement(SelectQuery);
				ps.setInt(1,limitSta);
				ps.setInt(2,list);
				rs = ps.executeQuery();



					} catch (Exception e) {
						e.printStackTrace();
					}
			request.setAttribute("Result", rs);
			request.setAttribute("Page", nowPage);
			request.setAttribute("listCnt", listCnt);
			getServletContext().getRequestDispatcher("/List.jsp").forward(request, response);


		} else {		// 検索文字列がある場合の処理
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				connect = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/test?characterEncoding=UTF-8&serverTimezone=JST",
				"root","user");
				CntQuery = ("SELECT COUNT(*) cnt FROM jyusyoroku,category WHERE jyusyoroku.categoryid = category.categoryid AND delete_flg=0 AND address LIKE ?");
				ps = connect.prepareStatement(CntQuery);
				ps.setString(1,"%" + SerchName + "%");
				rs = ps.executeQuery();

				rs.next();
				listCnt = rs.getInt("cnt");			// 総件数取得
				if(listCnt > 10) {
					list = 10;
				} else {
					list = listCnt;
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



			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				connect = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/test?characterEncoding=UTF-8&serverTimezone=JST",
				"root","user");
				SelectQuery = ("SELECT * FROM jyusyoroku,category WHERE jyusyoroku.categoryid = category.categoryid AND delete_flg=0 AND address LIKE ? ORDER BY address ASC,tel ASC,id LIMIT ?,?");
				ps = connect.prepareStatement(SelectQuery);
				ps.setString(1,"%" + SerchName + "%");
				ps.setInt(2,limitSta);
				ps.setInt(3,list);
				rs = ps.executeQuery();



					} catch (Exception e) {
						e.printStackTrace();
					}


			request.setAttribute("Result", rs);
			request.setAttribute("Page", nowPage);
			request.setAttribute("listCnt", listCnt);
			request.setAttribute("SerchName", SerchName);
			getServletContext().getRequestDispatcher("/List.jsp").forward(request, response);

		}



			 }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
