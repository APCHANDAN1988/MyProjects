<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page session="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Motor Insurance Database- Enquiry</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/style.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/boot.css"
	type="text/css">
<link
	href="${pageContext.request.contextPath}/resources/fonts/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jQuery.print.js"></script>

<style>
a:link {
	color: red;
}
</style>

</head>
<body>
	<jsp:include page="header_mid.jsp" />
	<br />
	<div class="ui-grid-col-12 center-position">
		<h1 class="header-main">Search Insurance details</h1>
	</div>

	<div style="margin-top: 20px;">
		<div class="container">
			<div class="row">
				<div class="filter-panel collapse in " id="filter-panel">
					<div class="panel panel-default">
						<center>
							<div class="panel-body">
								<form role="form" action="" method="post" id="searchForm"
									class="form-inline">

									<div class="form-group">
										<label>Regn_no &nbsp;&nbsp; </label> <input name="regnNumber"
											id="regnNumber" value="${search.regnNumber}" type="text"
											size="22" maxlength="12"
											placeholder="Enter registration number">
									</div>

									<div class="form-group">
										<label for="pref-orderby" style="margin-right: 0;" class="">
											&nbsp; &nbsp; OR &nbsp;&nbsp; Chassis_no&nbsp;&nbsp; </label> <input
											type="text" name="chasisNumber" id="chasisNumber"
											value="${search.chasisNumber}" size="20" maxlength="25"
											placeholder="Enter chassis number">

									</div>

									<div class="form-group">
										<input type="hidden" type="hidden"
											name="${_csrf.parameterName}" value="${_csrf.token}" />
									</div>
									&nbsp;&nbsp;
									<div class="form-group">
										<button class="applyBtn btn btn-sm btn-success" type="submit"
											value="Submit" id="submitButton">Search</button>
									</div>
								</form>
							</div>
						</center>
					</div>
				</div>
			</div>
		</div>
	</div>

	<center>
		<div class="page printable_page" id="result_div">
			<div id="ajax_loader"></div>
		</div>
	</center>



	<script>
		$(document)
				.ready(
						function() {
							$("#searchForm")
									.submit(
											function(e) {
												$("#ajax_loader")
														.html(
																"<div style=\"padding: 5px;\"><img src=\"${pageContext.request.contextPath}/resources/images/loading.gif\"></div>");
												$("#submitButton").prop(
														"disabled", true);
												var params = $("#searchForm")
														.serialize();
												$
														.ajax({
															url : "enquiry/search",
															type : "POST",
															data : params,
															success : function(
																	res) {
																$("#result_div")
																		.html(
																				res);
																$(
																		"#submitButton")
																		.prop(
																				"disabled",
																				false);
																$(
																		"#ajax_loader")
																		.html(
																				"");

																$('#vehicleId')
																		.click();
															},
															error : function(
																	jqXHR,
																	textStatus,
																	errorThrown) {
																$(
																		"#submitButton")
																		.prop(
																				"disabled",
																				false);
																$(
																		"#ajax_loader")
																		.html(
																				"");
																if (jqXHR.status == 500) {
																	$(
																			"#result_div")
																			.html(
																					"<div style=\"padding: 5px;\">Oops, there is some internal error. Please contact support.</div>");
																} else {
																	window.location.href = "${pageContext.request.contextPath}/enquiry";
																}
															}
														});
												e.preventDefault();
											});
						});
	</script>

</body>
</html>

