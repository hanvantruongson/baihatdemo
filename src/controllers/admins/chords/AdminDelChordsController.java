package controllers.admins.chords;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import daos.ChordsDao;
import util.AuthUtil;

public class AdminDelChordsController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminDelChordsController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (!AuthUtil.checkLogin(request, response)) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		int chordsId = 0;
		try {
			chordsId = Integer.parseInt(request.getParameter("id"));
		} catch (NumberFormatException e) {
			response.sendRedirect(request.getContextPath() + "/admin/chords?msg=4");
			return;
		}
		ChordsDao chordsDao = new ChordsDao();
		int chordsIdDel = chordsDao.delItem(chordsId);
		if (chordsIdDel > 0) {
			response.sendRedirect(request.getContextPath() + "/admin/chords?msg=3&chords_id_del=" + chordsIdDel);
			return;
		} else {
			response.sendRedirect(request.getContextPath() + "/admin/chords?msg=0");
			return;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}
}