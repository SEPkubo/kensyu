package commitbl;

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




@WebServlet("/AddCommitBL")
public class AddCommitBL extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			 throws ServletException,IOException
			 {

		Connection connect = null;
		Statement stmt = null;
		ResultSet rs = null;

		request.setCharacterEncoding("utf-8");
		String name = request.getParameter("name");
		String address = request.getParameter("address");
		String tel = request.getParameter("tel");
		String categoryid = request.getParameter("categoryid");


		tel = tel.replace("-", "");			// ハイフン除外



		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connect = DriverManager.getConnection(
			"jdbc:mysql://localhost:3306/kubo?characterEncoding=UTF-8&serverTimezone=JST",
			"root","");
			String sql = ("INSERT INTO jyusyoroku(name,address,tel,categoryid,delete_flg) VALUES (?,?,?,?,0)");
			PreparedStatement ps = connect.prepareStatement(sql);

			ps.setString(1,name);
			ps.setString(2,address);
			ps.setString(3,tel);
			ps.setString(4,categoryid);
			ps.executeUpdate();


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



		getServletContext().getRequestDispatcher("/ListBL").forward(request, response);


			 }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}