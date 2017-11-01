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
<title>Motor Insurance Database- Dashboard</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/boot.css"
	type="text/css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/boot.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/chosen.css"
	type="text/css">
<script
	src="${pageContext.request.contextPath}/resources/js/jquery-1.11.3.min.js"></script>

</head>

<style>
.home { /* LIST CONTAINER */
	border: 1px solid black;
	display: flex;
	flex-direction: column;
	border-radius: 10px;
	margin-left: 5%;
	color: white;
	font-family: 'heebo';
	font-size: 20px;
	text-align: center;
	width: 200px;
	height: 100px;
	background-color: green;
	display: flex;
	background-color: green;
}

.home ul { /* LIST O' LINKS */
	width: 100%;
	display: flex;
	flex-direction: column;
}

.homeW { /* 'WRITINGS' LINK */
	text-decoration: none;
	opacity: 0;
	color: blue;
	text-decoration: underline;
	font-size: 15px;
	transition: opacity 1s ease-in-out;
	-moz-transition: opacity 1s ease-in-out;
	-webkit-transition: opacity 1s ease-in-out;
}

.homeH { /* 'HOME' LINK */
	text-decoration: none;
}

.homeM { /* 'MUSIC' LINK */
	text-decoration: none;
	font-size: 15px;
	opacity: 0;
	color: blue;
	text-decoration: underline;
	transition: opacity 1s ease-in-out;
	-moz-transition: opacity 1s ease-in-out;
	-webkit-transition: opacity 1s ease-in-out;
}

.homeH:hover .homeW { /* ON 'HOME' HOVER, 'WRITINGS' APPEARS */
	opacity: 1.0;
	font-size: 15px;
	transition: opacity .55s ease-in-out;
	-moz-transition: opacity .55s ease-in-out;
	-webkit-transition: opacity .55s ease-in-out;
}

.homeH:hover .homeM { /* ...AND SO DOES 'MUSIC' */
	opacity: 1.0;
	font-size: 15px;
	transition: opacity .55s ease-in-out;
	-moz-transition: opacity .55s ease-in-out;
	-webkit-transition: opacity .55s ease-in-out;
}

.home ul:hover li a {
	opacity: 1.0 !important;
}
</style>

</head>

<body>
	<div id="site-content">

		<jsp:include page="header_mid.jsp" />
	</div>



	<%-- <sec:authorize access=" hasRole('INSURER') || hasRole('ADMIN')">


				<div class="fullwidth-block" data-bg-color="#f1f1f1">

					<h3 class="section-title">
						<b>Motor Insurance Database(MID)</b>
					</h3>


					<a href="${pageContext.request.contextPath}/enquiry"><button
							class="button button2">Enquiry</button></a> <a
						href="${pageContext.request.contextPath}/dashboard/addpolicy"><button
							class="button button2">Add Policy</button></a> <a
						href="${pageContext.request.contextPath}/dashboard/claim"><button
							class="button button2">Add Claim</button></a> <a
						href="${pageContext.request.contextPath}/dashboard/history"><button
							class="button button2">History</button> </a>
				</div>
			</sec:authorize> --%>
	<sec:authorize access=" hasRole('INSURER') || hasRole('ADMIN')">
		<div style="margin-top: 70px;">
			<h3 class="section-title">
				<b>Motor Insurance Database(MID)</b>
			</h3>
		</div>
		<table style="width: 80%; margin-top: 80px; margin-left: 160px;">
			<tr>
				<td><div class="home">
						<ul>
							<li style="list-style: none;"><a class="homeW"
								href="${pageContext.request.contextPath}/enquiry">Single
									Enquiry</a></li>
							<li
								style="margin-top: 12px; margin-down: 212px; list-style: none;"><a
								class="" style="color: white;">Enquiry</a></li>

							<li style="list-style: none;"><sec:authorize
									access="hasAnyRole('ADMIN')">
									<a class="homeM"
										href="${pageContext.request.contextPath}/admin/enquiry/batchusers/0">Upload
										Enquiry Batch</a>
								</sec:authorize></li>
							<li style="list-style: none;"><sec:authorize
									access="hasAnyRole('INSURER')">
									<a class="homeM"
										href="${pageContext.request.contextPath}/enquiry/batch/upload">Upload
										Enquiry Batch</a>
								</sec:authorize></li>

						</ul>
					</div></td>
				<td><div class="home">
						<ul>
							<li style="list-style: none;"><a class="homeW"
								href="${pageContext.request.contextPath}/dashboard/addpolicy">Add
									Policy</a></li>
							<li style="margin-top: 8px; list-style: none;"><a class=""
								style="color: white;">Policy</a></li>


							<li style="list-style: none;"><sec:authorize
									access="hasAnyRole('ADMIN')">
									<a class="homeM"
										href="${pageContext.request.contextPath}/admin/policy/batchusers/0">Upload
										Policy Batch</a>
								</sec:authorize></li>
							<li style="list-style: none;"><sec:authorize
									access="hasAnyRole('INSURER')">
									<a class="homeM"
										href="${pageContext.request.contextPath}/policy/batch/upload">Upload
										Policy Batch</a>
								</sec:authorize></li>
						</ul>
					</div></td>
				<td><div class="home">
						<ul>
							<li style="list-style: none;"><a class="homeW"
								href="${pageContext.request.contextPath}/dashboard/claim">Add
									Claim</a></li>
							<li style="margin-top: 8px; list-style: none;"><a class=""
								style="color: white;">Claim</a></li>


							<li style="list-style: none;"><sec:authorize
									access="hasAnyRole('ADMIN')">
									<a class="homeM"
										href="${pageContext.request.contextPath}/admin/claim/batchusers/0">Upload
										Claim Batch</a>
								</sec:authorize></li>
							<li style="list-style: none;"><sec:authorize
									access="hasAnyRole('INSURER')">
									<a class="homeM"
										href="${pageContext.request.contextPath}/claim/batch/upload">Upload
										Claim Batch</a>
								</sec:authorize></li>
						</ul>
					</div></td>
				<td><div class="home">
						<ul>
							<li style="list-style: none;"><a class="" href=""></a></li>
							<li style="margin-top: 28px; list-style: none;"><a class=""
								style="color: white;"
								href="${pageContext.request.contextPath}/dashboard/history">History</a></li>
							<li style="list-style: none;"><a class="" href=""> </a></li>
						</ul>
					</div></td>
			</tr>
		</table>
	</sec:authorize>

	<div style="margin-top: 130px">
		<jsp:include page="footer_mid.jsp" /></div>
</body>

</html>