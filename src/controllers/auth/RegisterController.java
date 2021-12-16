package controllers.auth;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import daos.UserDao;
import models.User;
import util.AuthUtil;
import util.StringUtil;

public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDao userDao;

	public RegisterController() {
		super();
		userDao = new UserDao();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
				// Chuyển tiếp sang trang login
				RequestDispatcher rd = request.getRequestDispatcher("/views/auth/register.jsp");
				rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String repassword = request.getParameter("repassword");
		String fullname = request.getParameter("fullname");
		if("".equals(username)) {
			RequestDispatcher rd = request.getRequestDispatcher("/views/auth/register.jsp?msg=1");
			rd.forward(request, response);
			return;
		}
		if("".equals(password)) {
			RequestDispatcher rd = request.getRequestDispatcher("/views/auth/register.jsp?msg=2");
			rd.forward(request, response);
			return;
		}
		if(password.equals(repassword) == false) {
			RequestDispatcher rd = request.getRequestDispatcher("/views/auth/register.jsp?msg=5");
			rd.forward(request, response);
			return;
		}
		if("".equals(fullname)) {
			RequestDispatcher rd = request.getRequestDispatcher("/views/auth/register.jsp?msg=3");
			rd.forward(request, response);
			return;
		}
		if(userDao.hasUser(username)) {
			RequestDispatcher rd = request.getRequestDispatcher("/views/auth/register.jsp?msg=4");
			rd.forward(request, response);
			return;
		}
		password = util.StringUtil.md5(password);
		User item = new User(0, username, password, fullname);
		if(userDao.addItem(item)>0) {
			response.sendRedirect(request.getContextPath()+"/register?msg=6");
			return;
		} else {
			RequestDispatcher rd = request.getRequestDispatcher(request.getContextPath()+"/register?msg=0");
			rd.forward(request, response);
			return;
		}
	}
}
