<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@page session="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Motor Insurance Database-Client</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/style.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/tables.css"
	type="text/css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-1.11.3.min.js"></script>
</head>
<body>
	<jsp:include page="header_mid.jsp" />

	<div style="padding: 10px; text-align: RIGHT">
		<sec:authorize access="hasRole('ADMIN')">
			<span style="clear: both"> <a
				href="${pageContext.request.contextPath}/admin/addClient"><input
					type="button" value="Add Client"></a></span>
		</sec:authorize>
		<sec:authorize access="hasRole('REPORT')">
			<span style="clear: both"> <a
				href="${pageContext.request.contextPath}/admin/addClient"><input
					type="button" value="Add Client"></a></span>
		</sec:authorize>

		<jsp:include page="message.jsp" />


		<table class="paginated" id="data_table" width="100%" cellspacing="1"
			cellpadding="2" border="0" style="border: 1px solid #C3E0E4;">
			<thead>
				<tr>
					<th>S.No</th>
					<th>Client Name</th>
					<th>Prefix</th>
					<th>Status</th>
					<th>Action</th>

				</tr>
			</thead>
			<%
				int i = 1;
			%>
			<tbody>
				<c:forEach items="${clntList}" var="clntList">
					<tr>
						<td><%=i++%>. <span><span></span></span></td>
						<td>${clntList.getClientName()}</td>
						<td>${clntList.getPrefix()}</td>
						<td><c:if test="${clntList.getStatus() == '1'}">
								<span style="color: #00CC33">Active</span>
							</c:if> <c:if test="${clntList.getStatus() == '0'}">
								<span style="color: red">In Active</span>
							</c:if></td>
						<td><sec:authorize access="hasRole('ADMIN')">						
								   <a
									href="${pageContext.request.contextPath}/admin/addClient">
										<a
										href="${pageContext.request.contextPath}/admin/editClient/${clntList.getClientId()}"><img
											title="edit"
											src="${pageContext.request.contextPath}/resources/images/edit.png" /></a>
										<a class="delete"
										href="${pageContext.request.contextPath}/admin/deleteClient/${clntList.getClientId()}"><img
											title="delete"
											src="${pageContext.request.contextPath}/resources/images/delete.png" /></a>

										<a
										href="${pageContext.request.contextPath}/admin/editClientKyc/${clntList.getClientId()}">Edit
											KYC</a>
							</sec:authorize>
							
							<sec:authorize access="hasRole('REPORT')">					
								  
											<a
										href="${pageContext.request.contextPath}/report/editClientKyc/${clntList.getClientId()}">Edit
											KYC</a>
							</sec:authorize>
							</td>


					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<script>
		$('table.paginated')
				.each(
						function() {
							var currentPage = 0;
							var numPerPage = 10;
							var $table = $(this);
							$table.bind('repaginate', function() {
								$table.find('tbody tr').hide().slice(
										currentPage * numPerPage,
										(currentPage + 1) * numPerPage).show();
							});
							$table.trigger('repaginate');
							var numRows = $table.find('tbody tr').length;
							var numPages = Math.ceil(numRows / numPerPage);
							var $pager = $('<div class="pager"></div>');
							for (var page = 0; page < numPages; page++) {
								$('<span class="page-number"></span>')
										.text(page + 1)
										.bind(
												'click',
												{
													newPage : page
												},
												function(event) {
													currentPage = event.data['newPage'];
													$table
															.trigger('repaginate');
													$(this).addClass('active')
															.siblings()
															.removeClass(
																	'active');
												}).appendTo($pager).addClass(
												'clickable');
							}
							$pager.insertAfter($table).find(
									'span.page-number:first')
									.addClass('active');
						});

		$(document).ready(
			function() {
				$(".delete").click(
					function(e) {
						if (confirm("Do you want to delete?")) {
							$(this).parent().parent().css('background-color', '#ffff66');
							var url = $(this).attr('href');
							var params = {"${_csrf.parameterName}" : "${_csrf.token}"};
							$.ajax({
								url : url,
								type : "POST",
								data : params,
								success : function(res) {
									if (res == 1) {
										window.location.href = $(location).attr('href');
									} else {
										$(this).parent().parent().css('background-color', 'red')
										alert(" Something went wrong. ")
									}
								},
								error : function(jqXHR, textStatus, errorThrown) {
									if(jqXHR.status == 500) {
										alert("Oops, there is some internal error. Please contact support.");
									} else {
										//window.location.href = "${pageContext.request.contextPath}/welcome";
									}
								}
							});
						}
						e.preventDefault();
					});
				});
	</script>
</body>
</html>