<%@page import="models.Comment"%>
<%@page import="daos.RatingDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/templates/public/inc/header.jsp" %>
   <div class="content">
<div class="content_resize">
  <div class="mainbar">
    <div class="article">
    <%
		    RatingDao ratingDao = new RatingDao();
		    float rating = 0;
		  	Song itemSong = (Song) request.getAttribute("itemSong");
		  	if(itemSong != null){
		  		rating =  ratingDao.getRating(itemSong.getId());
		  		String songDate = new SimpleDateFormat("dd-MM-yyyy").format(itemSong.getCreateAt());
  	%>
  		<p style="display: none" id="idSong"><%=itemSong.getId() %></p>
      <div class="clr"></div>
      <h1><%=itemSong.getName() %></h1>
      <p>Ngày đăng: <%=songDate %>. Lượt xem: <%=itemSong.getCount()%></p>
      <div class="white-space-pre-line"><%=itemSong.getDetail() %>
      </div>
      <div>
      <h2> Hợp âm</h2>
		<img src="<%=GlobalConstant.URL_PICTURE%>/<%=itemSong.getPicture() %>" style = "border: none" alt="Không có hình ảnh" class="fl" />
      </div>
      
    
    <b>Đánh giá bài hát</b>
    <span id="rating"> </span>
    <p style="color:
     black; font-size: 20px;">Danh sách bình luận</p>
    <div id="comment">
		<%
			@SuppressWarnings("unchecked")
			List<Comment> listCmts = (List<Comment>) request.getAttribute("listCmts");
			if(listCmts != null && listCmts.size() > 0) {
				for(Comment objCmt: listCmts) {
						String cmtDate = new SimpleDateFormat("dd-MM-yyyy").format(objCmt.getDate_create());
		%>
		<b><%=objCmt.getUsername() %>:</b>
		<span><%=objCmt.getComment() %> -----</span>
		<i><%=cmtDate %></i>
		<br />
		<%}} %>
	</div>
    <form>
    		 <%
            	if(session.getAttribute("userLogin")!=null){
            		User userLogin = (User) session.getAttribute("userLogin");
            %>
			<input type="text" name="fullname" id="fullname" value="<%=userLogin.getUsername()%>" placeholder="Nhập tên" />
			<input type="text" name="cmt" id="cmt" value="" placeholder="Nhập bình luận" />
			<a href="javascript:void(0)" title="" onclick="onClickComment()">Bình luận</a>
			<% } else {%>
			<input type="text" name="fullname" id="fullname" value="" placeholder="Nhập tên" />
			<input type="text" name="cmt" id="cmt" value="" placeholder="Nhập bình luận" />
			<a href="" title="" onclick="return confirm('Bạn phải đăng nhập')">Bình luận</a>
			<%} %>
	</form>
      <%} else { %>
      <p>Không có chi tiết bài hát</p>
      <%} %>
    </div>
    
  </div>
  <div class="sidebar">
  <%@ include file="/templates/public/inc/leftbar.jsp" %>
  </div>
  <div class="clr"></div>
</div>

<script type="text/javascript">
	var idSong = $("#idSong").text();
	$(function() {
		$('#rating').raty({
			number:		10,
			click: function(score) {
				if(score==null) score = 0;
				$.ajax({
					url: '<%=request.getContextPath()%>/rating',
					type: 'POST',
					data: {ascore: score, aid: idSong},
					success: function(data){
						alert(data);
					},
					error: function (){
						alert('Có lỗi xảy ra');
					}
				})
			},
			cancel: true,
			cancelPlace: 'left',
			half: true,
			start: <%=rating%>,
			path:"/chiasehopam/templates/public/imgs/",
		});
	});
	
	function onClickComment() {
			var fullname=$("#fullname").val();
			var cmt=$("#cmt").val();
			if(fullname!="" && cmt!=""){
				$.ajax({
					url : '<%=request.getContextPath()%>/comment',
					type : 'POST',
					data : {
						afullname : fullname,
						acmt : cmt,
						aid: idSong
					},
					success : function(data) {
						$("#comment").append(data);
						$("#fullname").val("");
						$("#cmt").val("");
					},
					error : function() {
						alert("Có lỗi rồi!");
					}
				});
			} else {
				alert("Vui lòng nhập đầy đủ thông tin khi bình luận!");
			}
		};
	document.getElementById("index").classList.add('active');
	<%if(itemSong!=null){%>
		document.getElementById("<%=itemSong.getCat().getId()%>").classList.add('active_cat');
	<%}%>
</script>
</div>

  </div>
  <div style=" height: 100px;  width: 100%;"></div>
  <%@ include file="/templates/public/inc/footer.jsp" %>