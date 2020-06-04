package bl;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.Common;


@WebServlet("/EditBL")
public class EditBL extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			 throws ServletException,IOException
			 {
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String address = request.getParameter("address");
		String tel = request.getParameter("tel");
		String categoryid = request.getParameter("categoryid");
		String errmsg = Common.getErr(name,address,tel);

		request.setAttribute("id",id);
		request.setAttribute("name",name);
		request.setAttribute("address",address);
		request.setAttribute("tel",tel);
		request.setAttribute("categoryid",categoryid);



		if (errmsg != null) {
			request.setAttribute("errmsg",errmsg);
			getServletContext().getRequestDispatcher("/Edit.jsp").forward(request, response);
		} else {
			getServletContext().getRequestDispatcher("/EditCheck.jsp").forward(request, response);
		}


			 }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}