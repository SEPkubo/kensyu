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


@WebServlet("/EditCommitBL")
public class EditCommitBL extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			 throws ServletException,IOException
			 {
		request.setCharacterEncoding("utf-8");
		int id = Integer.parseInt(request.getParameter("id"));
		String name = request.getParameter("name");
		String address = request.getParameter("address");
		String tel = request.getParameter("tel");
		String categoryid = request.getParameter("categoryid");

		String oldname = request.getParameter("oldname");		// 更新確認用データ
		String oldaddress = request.getParameter("oldaddress");
		String oldtel = request.getParameter("oldtel");
		String oldcategoryid = request.getParameter("oldcategoryid");



		if (name.equals(oldname) && address.equals(oldaddress) && tel.equals(oldtel) && categoryid.equals(oldcategoryid)) {		// どのデータも更新がなければ処理を行わない
			getServletContext().getRequestDispatcher("/ListBL").forward(request, response);
			System.out.println("更新を行いませんでした");
		} else {

			tel = tel.replace("-", "");			// ハイフン除外


			Connection connect = null;
			Statement stmt = null;
			ResultSet rs = null;

			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				connect = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/kubo?characterEncoding=UTF-8&serverTimezone=JST",
				"root","");
				String UpdQuery = ("UPDATE jyusyoroku SET name=?,address=?,tel=?,categoryid=? WHERE id=?");
				PreparedStatement ps = connect.prepareStatement(UpdQuery);

				ps.setString(1,name);
				ps.setString(2,address);
				ps.setString(3,tel);
				ps.setInt(4,Integer.parseInt(categoryid));
				ps.setInt(5,id);
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


			 }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}