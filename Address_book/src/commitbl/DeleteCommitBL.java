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


@WebServlet("/DeleteCommitBL")
public class DeleteCommitBL extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			 throws ServletException,IOException
			 {
		request.setCharacterEncoding("utf-8");
		int id = Integer.parseInt(request.getParameter("id"));

		Connection connect = null;
		Statement stmt = null;
		ResultSet rs = null;

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connect = DriverManager.getConnection(
			"jdbc:mysql://localhost:3306/test?characterEncoding=UTF-8&serverTimezone=JST",
			"root","user");
			String UpdQuery = ("UPDATE jyusyoroku SET delete_flg=1 WHERE id=?");
			PreparedStatement ps = connect.prepareStatement(UpdQuery);

			ps.setInt(1,id);
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