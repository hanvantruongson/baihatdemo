package controllers.admins.chords;

import java.io.File;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import constants.GlobalConstant;
import daos.ChordsDao;
import models.Chords;
import util.AuthUtil;
import util.FileUtil;

@MultipartConfig
public class AdminAddChordsController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminAddChordsController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (!AuthUtil.checkLogin(request, response)) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}

		RequestDispatcher rd = request.getRequestDispatcher("/views/admin/chords/add.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (!AuthUtil.checkLogin(request, response)) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html");
		ChordsDao chordsDao = new ChordsDao();
		// lay cac gia tri khong phai la file
		String name = request.getParameter("name");
		if ("".equals(name)) {
			RequestDispatcher rd = request.getRequestDispatcher("/views/admin/chords/add.jsp?msg=1");
			rd.forward(request, response);
			return;
		}
		// xu ly upload file
		String fileName = FileUtil.uploadFile(request, "picture", GlobalConstant.DIR_UPLOAD);
		// 1. tao doi tuong sau do luu cac thuoc tinh vao doi tuong
		// 2. viet phuong thuc insert table
		Chords itemChords = new Chords(0, name, fileName);
		// insert database
		if (chordsDao.addItem(itemChords) > 0) {
			// Nếu insert thành công thì chuyển hướng sang trang index và thông báo cho
			// người dùng biết
			response.sendRedirect(request.getContextPath() + "/admin/chords?msg=1");
		} else {
			// Nếu không thành công thì xóa ảnh vừa upload đi
			String appPath = request.getServletContext().getRealPath("");
			String oldPathFileName = appPath + GlobalConstant.DIR_UPLOAD + File.separator + fileName;
			File oldFile = new File(oldPathFileName);
			if (oldFile.exists()) {
				oldFile.delete();
			}
			RequestDispatcher rd = request.getRequestDispatcher("/views/admin/chords/add.jsp?msg=0");
			rd.forward(request, response);
		}
	}
}