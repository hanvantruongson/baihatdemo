package controllers.admins.chords;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import constants.GlobalConstant;
import daos.ChordsDao;
import models.Chords;
import util.AuthUtil;

public class AdminIndexChordsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ChordsDao chordsDao;

	public AdminIndexChordsController() {
		super();
		chordsDao = new ChordsDao();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (!AuthUtil.checkLogin(request, response)) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		
		int numberOfItems = chordsDao.numberOfItems();
		int numberOfPages = (int) Math.ceil((float) numberOfItems / GlobalConstant.NUMBER_PER_PAGE);
		int currentPage = 1;
		try {
			currentPage = Integer.parseInt(request.getParameter("page"));
		} catch (NumberFormatException e) {
		}
		if (currentPage > numberOfPages || currentPage < 1) {
			currentPage = 1;
		}
		int offset = (currentPage - 1) * GlobalConstant.NUMBER_PER_PAGE;
		List<Chords> listChords = chordsDao.getItemPagination(offset);
		request.setAttribute("listChords", listChords);
		request.setAttribute("numberOfPages", numberOfPages);
		request.setAttribute("currentPage", currentPage);

		RequestDispatcher rd = request.getRequestDispatcher("/views/admin/chords/index.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}
}
