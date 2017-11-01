<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="currentUrl" value="${pageContext.request.requestURI}" />
<c:set var="splitUrl" value="${fn:split(currentUrl, '/')}" />
<c:set var="pageName" value="${splitUrl[fn:length(splitUrl)-1]}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type"
	content="text/html; charset=windows-1252">
<title>FLA - MID</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/reset.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/font-awesome.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/boot.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/demo.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/style.css"
	type="text/css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/boot.js"></script>
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
		<!-- .container -->
	</div>
	</header>
	<div class="menu-wrap">
		<nav class="navbar navbar-inverse">
		<div class="container-fluid">

			<ul class="nav navbar-nav">
				<sec:authorize access="hasAnyRole('ADMIN','INSURER')">
					<li
						<c:choose>
						<c:when test="${pageName == 'dashboard.jsp'}">class="active"</c:when>						
					</c:choose>
						class="active"><a
						href="${pageContext.request.contextPath}/dashboard">
							MyActivity</a></li>


					<li class="dropdown"><a class="dropdown-toggle"
						data-toggle="dropdown" href="#">Enquiry<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="${pageContext.request.contextPath}/enquiry">Single
									Enquiry</a></li>

							<li><sec:authorize access="hasAnyRole('ADMIN')">
									<a
										href="${pageContext.request.contextPath}/admin/enquiry/batchusers/0">Upload
										Batch</a>
								</sec:authorize></li>
							<li><sec:authorize access="hasAnyRole('INSURER')">
									<a
										href="${pageContext.request.contextPath}/enquiry/batch/upload">Upload
										Batch</a>
								</sec:authorize></li>

							<li><sec:authorize access="hasAnyRole('ADMIN')">
									<a href="${pageContext.request.contextPath}/enquiry/filter">Apply
										Filter </a>
								</sec:authorize></li>
						</ul>
					<li class="dropdown"><a class="dropdown-toggle"
						data-toggle="dropdown" href="#">Policy<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a
								href="${pageContext.request.contextPath}/dashboard/addpolicy">Add
									Policy</a></li>

							<li><a
								href="${pageContext.request.contextPath}/dashboard/viewpolicy">View
									Policy</a></li>

							<li><sec:authorize access="hasAnyRole('ADMIN')">
									<a
										href="${pageContext.request.contextPath}/admin/policy/batchusers/0">Upload
										Batch</a>
								</sec:authorize></li>

							<li><sec:authorize access="hasAnyRole('INSURER')">
									<a
										href="${pageContext.request.contextPath}/policy/batch/upload">Upload
										Batch</a>
								</sec:authorize></li>
						</ul></li>

					<li class="dropdown"><a class="dropdown-toggle"
						data-toggle="dropdown" href="#">Claim<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a
								href="${pageContext.request.contextPath}/dashboard/claim">Add
									Claim</a></li>
							<li><sec:authorize access="hasAnyRole('ADMIN')">
									<a
										href="${pageContext.request.contextPath}/admin/claim/batchusers/0">Upload
										Batch</a>
								</sec:authorize></li>
							<li><sec:authorize access="hasAnyRole('INSURER')">
									<a href="${pageContext.request.contextPath}/claim/batch/upload">Upload
										Batch</a>
								</sec:authorize></li>
						</ul></li>
					<li
						<c:choose>
						<c:when test="${pageName == 'history.jsp'}">class="active"</c:when>					
					</c:choose>><a
						href="${pageContext.request.contextPath}/dashboard/history">
							History </a></li>
					<li class="dropdown"><a class="dropdown-toggle"
						data-toggle="dropdown" href="#">Setting<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a
								href="${pageContext.request.contextPath}/setting/addPi">Add
									PI agency</a></li>
							<li><sec:authorize access="hasAnyRole('ADMIN')">
									<a
										href="${pageContext.request.contextPath}/admin/claim/batchusers/0">Upload
										Batch</a>
								</sec:authorize></li>
							<li><sec:authorize access="hasAnyRole('INSURER')">
									<a href="${pageContext.request.contextPath}/claim/batch/upload">Upload
										Batch</a>
								</sec:authorize></li>
						</ul></li>

				</sec:authorize>
			</ul>
			<c:if test="${pageContext.request.userPrincipal.name != null}">
				<c:url value="/j_spring_security_logout" var="logoutUrl" />
				<ul class="nav navbar-nav navbar-right">

					<li><a href=""><span class="glyphicon glyphicon-user"></span>
							Welcome : ${pageContext.request.userPrincipal.name} </a></li>

					<li><a href="javascript:formLogout()"><span
							class="glyphicon glyphicon-log-out"></span> Log Out </a></li>


				</ul>
			</c:if>
		</div>
		</nav>
	</div>

	<form action="${logoutUrl}" method="post" id="logoutForm">
		<input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}" />
	</form>


	<script>
		/* $(function() {
			var url = window.location.href;
			$("#menu a").each(
					function() {
						if (url == (this.href)) {
							$(this).closest(".menuHeader").children("a")
									.addClass("active_menu");
							$(this).closest("li").addClass("active_menu");
							$(this).closest("li a").css("color", "#000");
						}
					});
		}); */

		function formLogout() {
			document.getElementById("logoutForm").submit();
		}
	</script>