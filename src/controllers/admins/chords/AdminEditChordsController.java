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
public class AdminEditChordsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ChordsDao chordsDao;

	public AdminEditChordsController() {
		super();
		chordsDao = new ChordsDao();
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
			response.sendRedirect(request.getContextPath() + "/admin/chords?msg=0");
			return;
		}
		Chords itemChords = chordsDao.getItem(chordsId);
		request.setAttribute("itemChords", itemChords);

		RequestDispatcher rd = request.getRequestDispatcher("/views/admin/chords/edit.jsp");
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
		int id = Integer.parseInt(request.getParameter("id"));
		String name = request.getParameter("name");
		String picture = request.getParameter("picture");
		// get dữ liệu cũ
		Chords chords = chordsDao.getItem(id);
		if (chords == null) {
			response.sendRedirect(request.getContextPath() + "/admin/chords?msg=0");
			return;
		}
		// xu ly upload file
		String fileName = FileUtil.uploadFile(request, "picture", GlobalConstant.DIR_UPLOAD);
		if (fileName == "") {
			fileName = chords.getPicture();
		}
		// 1. tao doi tuong sau do luu cac thuoc tinh vao doi tuong
		// 2. viet phuong thuc insert table
		Chords itemChords = new Chords(id, name, fileName);
		// insert database
		if (chordsDao.editItem(itemChords) > 0) {
			// Nếu có chọn file và đã thực hiện thành công thì xóa file cũ đi
			if (request.getPart("picture").getSubmittedFileName() != "") {
				String appPath = request.getServletContext().getRealPath("");
				String dirPath = appPath + GlobalConstant.DIR_UPLOAD;
				String oldPathFileName = dirPath + File.separator + chords.getPicture();
				File oldFile = new File(oldPathFileName);
				if (oldFile.exists()) {
					oldFile.delete();
				}
			}
			response.sendRedirect(request.getContextPath() + "/admin/chords?msg=2");
		} else {
			// Nếu có chọn file và không thành công thì xóa file đã upload lên
			if (request.getPart("picture").getSubmittedFileName() != "") {
				String appPath = request.getServletContext().getRealPath("");
				String oldPathFileName = appPath + GlobalConstant.DIR_UPLOAD + File.separator + fileName;
				File oldFile = new File(oldPathFileName);
				if (oldFile.exists()) {
					oldFile.delete();
				}
			}
			RequestDispatcher rd = request.getRequestDispatcher("/views/admin/chords/edit.jsp?msg=0");
			rd.forward(request, response);
		}
	}
}