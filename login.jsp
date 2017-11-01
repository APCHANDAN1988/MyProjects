
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/style_u.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/style.css"
	type="text/css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-1.11.3.min.js"></script>
<title>FLA - MID</title>
</head>

<header class="site-header">
<div class="top-header">
	<div class="container" style="width: 100%;">
		<a href="" id="branding"> <img
			src="${pageContext.request.contextPath}/resources/images/logo1.png"
			alt="Company Name" class="logo">
		</a>
	</div>
	<!-- .container -->
</div>
<div class="bottom-header1"></div>

</header>
<body>
	<form name='loginForm'
		action="<c:url value='j_spring_security_check' />" method='POST'>
		<!-- <h3 style="color:red; ">Make Your Insurance search</h3> -->
		<div id="login-box">

			<div class="left">
				<!-- <h1>Private User</h1> -->
				<span class="loginwith1">Registered Users<br /></span> <br /> <br />
				<br /> <br /> <br /> <br /> <input type="text" name="username"
					placeholder="Username" /> <input type="password" name="password"
					placeholder="Password" /> <input type="submit" name="submit"
					value="Submit" /> <input type="hidden"
					name="${_csrf.parameterName}" value="${_csrf.token}" />
			</div>

			<div class="right">
				<span class="loginwith">Public Users<br /></span> <br />
				<button class="social-signin login" style="margin-top: 15px;">

					<a style="color: white;"
						href="${pageContext.request.contextPath}/welcome"> Check Your
						Vehicle On MID</a>
				</button>
			</div>
			<div class="or">OR</div>
		</div>

	</form>
</body>
</html>
