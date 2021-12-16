<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
<head>
	<title>Đăng ký</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="<%=request.getContextPath() %>/templates/auth/images/icons/icon.jpg"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/templates/auth/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/templates/auth/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/templates/auth/fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/templates/auth/vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/templates/auth/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/templates/auth/vendor/select2/select2.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/templates/auth/css/util.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/templates/auth/css/main.css">
<!--===============================================================================================-->
</head>
<body>
	
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100 p-l-50 p-r-50 p-t-77 p-b-30">
				<form class="login100-form validate-form"  method="post" id="register" role="form">
					<span class="login100-form-title p-b-55" >
						Đăng ký
					</span>
								<%
	        					String username = request.getParameter("username");
	        					String fullname = request.getParameter("fullname");
									if(request.getParameter("msg")!=null){
										int msg = Integer.parseInt(request.getParameter("msg"));
										switch(msg){
											case 0: out.print("<h5> style='background: yellow; color: red'>Có lỗi trong quá trình xử lý!</h5>");
											break;
											case 1: out.print("<p style='background: yellow; color: red'>Vui lòng nhập username vào!</p>");
											break;
											case 2: out.print("<p style='background: yellow; color: red'>Vui lòng nhập password vào!</p>");
											break;
											case 3: out.print("<p style='background: yellow; color: red'>Vui lòng nhập fullname vào!</p>");
											break;
											case 4: out.print("<h5 style='margin-bottom: 10px; color: red'>Tên đăng nhập đã tồn tại!</h5>");
											break;
											case 5: out.print("<h5 style='margin-bottom: 10px; color: red'>Mật khẩu không đúng!</h5>");
											break;
											case 6: out.print("<h5 style='margin-bottom: 10px; color: green'>Đăng ký thành công!</h5>");
											break;
										}
									}
							%>

					<div class="wrap-input100 validate-input m-b-16" >
						<input class="input100" type="text" name="username" placeholder="Tên đăng nhập" value="<%if(username!=null) out.print(username); %>" >
						<span class="focus-input100"></span>
						<span class="symbol-input100">
							<span class="lnr lnr-envelope"></span>
						</span>
					</div>
					
					<div class="wrap-input100 validate-input m-b-16" >
						<input class="input100" type="text" name="fullname" placeholder="Họ tên" value="<%if(username!=null) out.print(username); %>" >
						<span class="focus-input100"></span>
						<span class="symbol-input100">
							<span class="lnr lnr-envelope"></span>
						</span>
					</div>

					<div class="wrap-input100 validate-input m-b-16">
						<input class="input100" type="password" id="password" name="password"  placeholder="Mật khẩu">
						<span class="focus-input100"></span>
						<span class="symbol-input100">
							<span class="lnr lnr-lock"></span>
						</span>
					</div>
					
					<div class="wrap-input100 validate-input m-b-16"  >
						<input class="input100" type="password" id="repassword" name="repassword" placeholder="Nhập lại mật khẩu">
						<span class="focus-input100"></span>
						<span class="symbol-input100">
							<span class="lnr lnr-lock"></span>
						</span>
					</div>

					
					<div class="container-login100-form-btn p-t-25">
						<button type="submit" name="submit" class="login100-form-btn"> Đăng ký </button>
					</div>
					
					<div class="text-center w-full p-t-115">
					<span class="txt1">	Trở về	</span>
						<a class="txt1 bo1 hov1" href="<%=request.getContextPath() %>/home"> Trang chủ </a>
						
						<br>	
						<span class="txt1">	Bạn đã có tài khoản	</span>

						<a class="txt1 bo1 hov1" href="<%=request.getContextPath()%>/login"> Đăng nhập </a>
					</div>
				</form>
			</div>
		</div>
	</div>

<!--===============================================================================================-->	
	<script src="<%=request.getContextPath() %>/templates/auth/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="<%=request.getContextPath() %>/templates/auth/vendor/bootstrap/js/popper.js"></script>
	<script src="<%=request.getContextPath() %>/templates/auth/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="<%=request.getContextPath() %>/templates/auth/vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="<%=request.getContextPath() %>/templates/auth/js/main.js"></script>

</body>
</html>