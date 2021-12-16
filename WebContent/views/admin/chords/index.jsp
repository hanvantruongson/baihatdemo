<%@page import="java.util.ArrayList"%>
<%@page import="daos.ChordsDao"%>
<%@page import="models.Chords"%>
<%@page import="constants.GlobalConstant"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/templates/admin/inc/header.jsp" %>
<%@ include file="/templates/admin/inc/leftbar.jsp" %>
<div id="page-wrapper">
    <div id="page-inner">
        <div class="row">
            <div class="col-md-12">
                <h2>Quản lý hợp âm</h2>
            </div>
        </div>
        <!-- /. ROW  -->
        <hr />
        <div class="row">
            <div class="col-md-12">
                <!-- Advanced Tables -->
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="table-responsive">
                            <div class="row">
                                <div class="col-sm-6">
                                    <a href="<%=request.getContextPath() %>/admin/chords/add" class="btn btn-success btn-md">Thêm</a>
                                </div>
                                <div class="col-sm-6" style="text-align: right;">
                                    <form method="post" action="">
                                        <input type="submit" name="search" value="Tìm kiếm" class="btn btn-warning btn-sm" style="float:right" />
                                        <input type="search" class="form-control input-sm" placeholder="Nhập tên hợp âm" style="float:right; width: 300px;" />
                                        <div style="clear:both"></div>
                                    </form><br />
                                </div>
                            </div>
							<%
								if(request.getParameter("msg")!=null){
									int msg = Integer.parseInt(request.getParameter("msg"));
									switch(msg){
										case 1: out.print("<p style='color: green; background: yellow'>Thêm thành công!</p>");
										break;
										case 2: out.print("<p style='color: green; background: yellow'>Sửa thành công!</p>");
										break;
										case 3: out.print("<p style='color: green; background: yellow'>Xóa thành công!</p>");
										break;
										case 4: out.print("<p style='color: red; background: yellow'>Xóa không thành công!</p>");
										break;
										case 0: out.print("<p style='color: red; background: yellow'>ID không tồn tại!</p>");
										break;
									}
								}
							%>
                            <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                <thead>
                                    <tr>
                                        <th>Tên hợp âm</th>
                                        <th>Hình ảnh</th>
                                        <th width="160px">Chức năng</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <%
                               	 	@SuppressWarnings("unchecked")
                                	List<Chords> listChords = (List<Chords>) request.getAttribute("listChords");
                                	if(listChords != null && listChords.size() > 0) {
                                	for(Chords objChords : listChords) {
                                			int chordsId = objChords.getId();
                                			String chordsName = objChords.getName();
                                			String picture = objChords.getPicture();
                                			String urlEdit = request.getContextPath() + "/admin/chords/edit?id=" + chordsId;
                                    		String urlDel = request.getContextPath() + "/admin/chords/del?id=" + chordsId;
                                %>
                                    <tr>
                                        <td class="center"><%= chordsName %></td>
                                        <td class="center">
                                        <%
                                        	if(!"".equals(picture)) {
                                        %>
												<img width="100px" height="100px" src="<%=GlobalConstant.URL_PICTURE %>/<%=picture %>" alt="<%=picture %>"/>
                                        <%
                                        	} else {
                                        		
                                        %>
                                        	<img width="100px" height="100px" src = "<%=GlobalConstant.URL_ADMIN %>/display/nopicture.jpg" alt = "nopicture" />
                                        	<% }%>
                                        </td>
                                        
                                        <td class="center">
                                            <a href="<%=urlEdit %>" title="Sửa" class="btn btn-primary"><i class="fa fa-edit "></i> Sửa</a>
                                            <a href="<%=urlDel %>" title="Xóa" class="btn btn-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa không?')"><i class="fa fa-pencil"></i> Xóa</a>
                                        </td>
                                        <%} } %>
                                    </tr>
                                </tbody>
                            </table>
                             <%
								int numberOfPages = (Integer) request.getAttribute("numberOfPages");
								int currentPage = (Integer) request.getAttribute("currentPage");
								if(listChords != null && listChords.size() > 0){
									ChordsDao chordsDao = new ChordsDao();
									int n = chordsDao.numberOfItems();
							%>
                            <div class="row">
                                <div class="col-sm-6">
                                </div>
                                <div class="col-sm-6" style="text-align: right;">
                                    <div class="dataTables_paginate paging_simple_numbers" id="dataTables-example_paginate">
                                        <ul class="pagination">
                                            <li class="paginate_button previous <%if(currentPage == 1) out.print("disabled"); %>" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_previous"><a href="<%if(currentPage>1) out.print(request.getContextPath() + "/admin/chords?page="+(currentPage-1)); else out.print("javascript:void(0)");%>">Trang trước</a></li>
                                            <%
												for(int i = 1; i <= numberOfPages; i++){
											%>
                                            <li class="paginate_button <%if(currentPage==i) out.print("active");%>" aria-controls="dataTables-example" tabindex="0"><a href="<%=request.getContextPath()%>/admin/chords?page=<%=i%>"><%=i%></a></li>
											<%
												}
											%>
                                            <li class="paginate_button next <%if(currentPage==numberOfPages) out.print("disabled"); %>" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_next"><a href="<%if(currentPage<numberOfPages) out.print(request.getContextPath() + "/admin/chords?page="+(currentPage+1)); else out.print("javascript:void(0)");%>">Trang tiếp</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <%} %>
                        </div>

                    </div>
                </div>
                <!--End Advanced Tables -->
            </div>
        </div>
    </div>
</div>
<script>
    document.getElementById("chords").classList.add('active-menu');
</script>
<!-- /. PAGE INNER  -->
<%@ include file="/templates/admin/inc/footer.jsp" %>