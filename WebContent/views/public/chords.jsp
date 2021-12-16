<%@page import="models.Chords"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/templates/public/inc/header.jsp" %>
<div class="content_resize">
  <div class="mainbar">
  <%
  	@SuppressWarnings("unchecked")
  	List<Chords> listChords = (List<Chords>) request.getAttribute("listChords");
	  	if(listChords != null && listChords.size() > 0){
  		int i = 0;
  		for(Chords objChords : listChords){
  			i++;
  			String urlSlug = request.getContextPath() + "/chi-tiet/" + StringUtil.makeSlug(objChords.getName()) + "-" + objChords.getId() + ".html";
  %>
    <div class="article col-md-4 col-sm-4 col-xs-4 ">
    <h2><%=objChords.getName() %></h2>
    <%if(!"".equals(objChords.getPicture())){%>
      <img src="<%=GlobalConstant.URL_PICTURE%>/<%=objChords.getPicture() %>" alt="Không có hình ảnh" width="177" height="213" class="fl" />
      <%}else{%>
      <img src="<%=GlobalConstant.URL_PICTURE%>/nopicture.jpg" alt="Không có hình ảnh" width="177" height="213" class="fl" />
      <%}%>
      <div class="clr"></div>
      
      <div class="clr"></div>
    </div>
    <%
  		}} else {
    %>
    <div class="article">
    	Không có hợp âm nào!
    </div>
    <%} %>
    <%
	    int numberOfPages = (Integer) request.getAttribute("numberOfPages");
		int currentPage = (Integer) request.getAttribute("currentPage");
		if(listChords != null && listChords.size() > 0 && numberOfPages > 1){
    %>
    <p class="pages"><small>Trang <%=currentPage %> của <%=numberOfPages %></small>
    <a href="<%=request.getContextPath()%>/chords?page=<%=currentPage-1%>" style="<%if(currentPage==1) out.print("display: none");%>">&laquo;</a>
    <%
	    for(int i = 1; i <= numberOfPages; i++){
	    	if(currentPage == i){
    %>
    <span><%=i %></span>
    <%} else { %>
    <a href="<%=request.getContextPath()%>/chords?page=<%=i%>"><%=i %></a>
    <%}} %>
    <a href="<%=request.getContextPath()%>/chords?page=<%=currentPage+1%>" style="<%if(currentPage==numberOfPages) out.print("display: none");%>">&raquo;</a></p>
  <%} %>
  </div>
  <div class="sidebar">
      <%@ include file="/templates/public/inc/leftbar.jsp" %>
  </div>
  <div class="clr"></div>
</div>
<script>
    document.getElementById("chords").classList.add('active');
</script>
<%@ include file="/templates/public/inc/footer.jsp" %>