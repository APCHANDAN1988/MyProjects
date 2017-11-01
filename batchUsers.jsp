<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page session="true"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page buffer="16kb"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Motor Insurance Database- Batch</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/style.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/boot.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/tables.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/boot.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/chosen.css"
	type="text/css">
<script
	src="${pageContext.request.contextPath}/resources/js/jquery-1.11.3.min.js"></script>

<style>
.item>.dxm-popOut {
	display: none;
}
</style>
</head>
<body>
	<jsp:include page="header_mid.jsp" />
	<jsp:include page="message.jsp" />


	<div class='fileupload'
		style="padding: 10px; background-color: white; text-align: center">
		<form method="POST" enctype="multipart/form-data"
			action="${id}?${_csrf.parameterName}=${_csrf.token}" id="uploadForm">
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />
			<table>
				<tr style="padding: 5px; background-color: white";>

					<td width="100%" align="left">
						<div class="Table">
							<div class="Row">
								<sec:authorize access="hasRole('ADMIN')">
									<div class="Cell">

										<!-- <input type="radio" name="filter" id="flt_search" /> Search  -->

										<input type="radio" name="filter" id="flt_upload" checked />
										<strong style="font-size: 14px;">Upload <c:out
												value="${batchType} batch" />
										</strong>

									</div>
								</sec:authorize>
								<sec:authorize access="hasRole('ADMIN')">
									<div class="Cell">

										<span class="plain-select"> <select id="client_record"
											class="inp" name="clientName">

												<option value="0">Select Client</option>
												<c:forEach var="clientList" items="${clientList}">
													<option value="${clientList.clientId}"
														id="client_${clientList.clientId}">${clientList.clientName}</option>
												</c:forEach>
										</select>
										</span>
									</div>
								</sec:authorize>

								<div class="Cell msg_user">
									<span class="plain-select item" style="width: 115px;"> <select
										id="user_record" name="userId">
											<option value="0">Select User</option>
											<c:forEach var="userList" items="${userList}">
												<option
													class="user_clinet_id_${userList.getClientId()} user_option"
													style="display: none" value="${userList.getUserId()}">${userList.getUsername()}</option>
											</c:forEach>
									</select> <sec:authorize access="hasRole('CLUB')">
											<select id="user_record" name="userId">
												<option value="0">Select User</option>
												<c:forEach var="userList" items="${userList}">
													<option
														class="user_clinet_id_${userList.getClientId()} user_option"
														value="${userList.getUserId()}">${userList.getUsername()}</option>
												</c:forEach>
											</select>
										</sec:authorize></span> &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;<strong
										style="font-size: 14px;">File to upload:
										&nbsp;&nbsp;&nbsp;</strong> <input class="" type="file" name="file"
										accept=".csv, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel" />
								</div>
								<input id="uploadbtn" type="submit" value="Upload">
								<div id="ajax_loader"></div>
							</div>
						</div>
					</td>
				</tr>
			</table>
		</form>
	</div>



	<div id="dvData"
		style="padding: 2px; margin-right: 30px; margin-left: 15px; text-align: center">
		<c:if test="${not empty allFileRecord && batchType ne null}">
			<display:table id="reportdata" name="allFileRecord"
				requestURI="${userData.user_id()}" pagesize="10" export="false">
				<%-- <display:setProperty name="export.excel.filename"
					value="userlist.xlsx" />
				<display:setProperty name="export.pdf.filename" value="userlist.pdf" />
 --%>
				<display:column property="username" title="User Name"
					sortable="false" />
				<display:column property="name" title="File Name" sortable="false" />
				<display:column property="fileSize" title="File Size ( MB )"
					sortable="false" />
				<display:column property="uploadedTime" title="File Upload Date"
					sortable="false" />

				<c:if test="${reportdata.status == '0'}">
					<display:column title="File Status" sortable="false"
						style="background-color: #f3e3e3; color:#d24067; ">In Process	</display:column>
				</c:if>
				<c:if test="${reportdata.status == '1'}">

					<display:column title="File Status" sortable="false"
						style=" background-color: #FEEFB3; color: #9F6000; ">Failed	</display:column>
				</c:if>
				<c:if test="${reportdata.status == '2'}">

					<display:column title="File Status" sortable="false"
						style=" background-color: #d7f5f1; color:#4F8A10; ">Completed</display:column>
				</c:if>


				<display:column title="Download Status" sortable="false"
					media="html">
					<a
						href="${pageContext.request.contextPath}/${batchType}/batch/download/${reportdata.id}">
						<img title="download"
						src="${pageContext.request.contextPath}/resources/images/download.jpg" />
					</a>
				</display:column>

				<display:column title="Action" sortable="false" media="html">
					<sec:authorize access="hasRole('ADMIN')">
						<a
							href="${pageContext.request.contextPath}/admin/${batchType}/editbatchuser/${reportdata.id}"><img
							title="edit Status"
							src="${pageContext.request.contextPath}/resources/images/edit.png" /></a> &nbsp;&nbsp;&nbsp;

						<a
							href="${pageContext.request.contextPath}/admin/${batchType}/deletebatch/${reportdata.id}"><img
							title="Delete File"
							onclick="return confirm('Do you want to delete it.?')"
							src="${pageContext.request.contextPath}/resources/images/delete.jfif" /></a>

					</sec:authorize>
				</display:column>

			</display:table>
		</c:if>
	</div>


	<script type="text/javascript">
		$('input[type=file]').change(function(e) {
			$("#uploadbtn").css({
				display : "block"
			})
		});

		$(document)
				.ready(
						function() {
							$("#uploadbtn").prop('disabled', false);
							$("#uploadForm")
									.submit(
											function(e) {
												var client_val = $(
														"#client_record").val();
												var user_val = $("#user_record")
														.val();
												if (client_val == '0'
														|| client_val == '') {
													alert("Please select client.")
													return false;
												} else if (user_val == '0'
														|| user_val == '') {
													alert("Please select user.")
													return false;
												} else {
													$("#ajax_loader")
															.html(
																	"<div style=\"padding: 5px;\"><img src=\"${pageContext.request.contextPath}/resources/images/loading.gif\"></div>");
													$("#uploadbtn").prop(
															"disabled", true);
												}
											});
						});

		$(document)
				.ready(
						function() {
							$('#flt_upload').attr('checked', 'checked')
							/* 	$("#client_record").chosen(); */
							$("#client_record")
									.change(
											function() {
												if ($('#flt_search').is(
														':checked')) {
													var client_id = $(this)
															.val();
													var l = window.location;
													var base_url = l.protocol
															+ "//"
															+ l.host
															+ "/"
															+ l.pathname
																	.split('/')[1]
															+ "/"
															+ l.pathname
																	.split('/')[2]
															+ "/"
															+ l.pathname
																	.split('/')[3]
															+ "/" + client_id;
													window.location.href = base_url;
												} else {
													var numItems = 0;
													var client_id = $(this)
															.val();
													$(".user_option")
															.removeClass(
																	'show_id');
													$("#user_record").hide();
													$("#user_record").val("0");
													$(".user_option").hide();

													$(
															".user_clinet_id_"
																	+ client_id)
															.addClass('show_id');
													numItems = $('.show_id').length;
													if (numItems > 0) {
														$("#user_record")
																.show();
													} else {
														$("#user_record")
																.hide();
														alert("Please add the user first to upload the file.");
													}
													$(
															".user_clinet_id_"
																	+ client_id)
															.show();
												}
											})
						});
	</script>
</body>
</html>