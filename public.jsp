<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page session="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Motor Insurance Database - Public Enquiry</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/style.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/boot.css"
	type="text/css">
<link
	href="${pageContext.request.contextPath}/resources/fonts/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/reset.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/font-awesome.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jQuery.print.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/demo.css">

</head>
<body>
	<header class="site-header">
	<div class="top-header">
		<div class="container" style="width: 100%;">
			<a href="${pageContext.request.contextPath}" id="branding"> <img
				src="${pageContext.request.contextPath}/resources/images/logo1.png"
				alt="Company Name" class="logo">
			</a>
		</div>

	</div>
	</header>
	<div class="menu-wrap">
		<nav class="menu">
		<ul class="clearfix">
			<li><a href="${pageContext.request.contextPath}/welcome">
					Enquiry</a></li>
		</ul>
		</nav>
	</div>
	<br />
	<div class="ui-grid-col-12 center-position">
		<h1 class="header-main">Search Insurance details</h1>
	</div>
	<br />
	<div style="margin-top: 0px;">
		<div class="container">
			<div class="panel panel-default">
				<center>
					<div class="panel-body">
						<form role="form" action="" method="post" id="searchForm"
							class="form-inline">
							<div class="form-group">
								<label>Regn_no &nbsp; &nbsp;&nbsp;</label> <input
									name="regnNumber" id="regnNumber" value="${search.regnNumber}"
									type="text" size="20" maxlength="12"
									placeholder="Enter registration number">
							</div>

							<div class="form-group">
								<label> &nbsp; &nbsp; &nbsp; OR &nbsp; &nbsp; &nbsp;
									Chassis_no &nbsp; &nbsp;&nbsp;</label> <input type="text"
									name="chasisNumber" id="chasisNumber"
									value="${search.chasisNumber}" size="20" maxlength="25"
									placeholder="Enter chassis number">
							</div>
							&nbsp;&nbsp;

							<div class="form-group">
								<input type="hidden" type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" class="form-control input-sm" />
							</div>

							<div class="form-group">
								<button class="applyBtn btn btn-sm btn-success" type="submit"
									value="Submit" id="submitButton">Search</button>
							</div>
							&nbsp;&nbsp;

							<div class="button_back">
								&nbsp;&nbsp;&nbsp;<a style="color: white;"
									href="${pageContext.request.contextPath}/login"> Back To
									Home&nbsp;&nbsp;</a>

							</div>

						</form>
					</div>
				</center>
			</div>
		</div>
	</div>


	<center>
		<div class="" id="result_div">
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
															url : "welcome/search",
															type : "POST",
															data : params,
															success : function(
																	res) {
																$("#result_div")
																		.html(
																				res);
																$(".print-link")
																		.css(
																				"display",
																				"inline")
																$(
																		"#submitButton")
																		.prop(
																				"disabled",
																				false);
																$(
																		"#ajax_loader")
																		.html(
																				"");
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

		function changeMe() {
			document.getElementById("input").style.backgroundColor = "yellow";
		}

		$('#regnNumber').on(function(e) {
			var regex = new RegExp("^[a-zA-Z0-9]+$");
			var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
			if (regex.test(str)) {
				return true;
			}
			e.preventDefault();
			return false;
		});
	</script>

</body>
</html>


