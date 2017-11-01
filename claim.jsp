<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page session="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Motor Insurance Database- Add Claim</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/boot.css"
	type="text/css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jQuery.print.js"></script>
<link
	href="${pageContext.request.contextPath}/resources/fonts/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath}/resources/fonts/lineo-icon/style.css"
	rel="stylesheet" type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css">
</head>
<body>
	<div id="site-content">
		<jsp:include page="header_mid.jsp" />
		<br />
	</div>
	<div style="margin-top: 25px;">

		<div class="container" id="Form-div">
			<div class="row">
				<div class="filter-panel collapse in " id="filter-panel">
					<div class="panel panel-default">
						<center>
							<div class="panel-body">
								<br />
								<div>
									<form action="" method="post" name="claimForm" id="claimForm"
										class="form-inline" onsubmit="return validateform();">

										<div class="theft-title registration_mod" id="vehicle_mod">
											Add Claim details</div>

										<table width="94%" align="center" border:1px"	cellspacing="1"
											cellpadding="8">

											<tr>
												<td><span style="color: red; font: normal; float: left">
														<c:out value="( * ) Mandatory fields"></c:out>
												</span></td>
											</tr>


											<tr>
												<td><b>Registration Number <span
														style="color: red;">*</span>
												</b></td>
												<td><input type="text" name="regnNumber"
													id="regnNumber" value="" size="20" minlength="7"
													maxlength="12" required="true" autofocus="true"
													onChange="checkInput(this)"></td>

												<td><b>Policy Number<span style="color: red;">
															*</span></b></td>
												<td><input type="text" name="policyNumber"
													id="policyNumber" value="" size="20" maxlength="20"
													required="true" autofocus="true"></td>

												<td><b>Claim Number <span style="color: red;">*</span></b></td>
												<td><input type="text" name="claimNumber"
													id="claimNumber" value="" size="20" maxlength="20"
													required="true" autofocus="true"></td>


											</tr>

											<tr>
												<td><b>Insurance Company<span style="color: red;">
															*</span></b></td>
												<td><input type="text" name="insurerName"
													id="insurerName" value="" size="20" maxlength="25"></td>

												<td><b>Claim Date <span style="color: red;">
															*</span></b></td>
												<td style="z-index: -53px;"><input id="claimDate"
													size="20" name="claimDate" placeholder="Please select date"
													required="true" autofocus="true" /></td>

												<td><b>Claim Pay Out Date <span style="color: red;">*</span></b>
												<td><input id="payoutDate" name="payoutDate" size="20"
													placeholder="Please select date" required="true"
													autofocus="true" /></td>


											</tr>

											<tr>
												<td><b>Repairer Name</b></td>
												<td><input id="repairerName" name="repairerName"
													size="20" /></td>


												<td><b>Claim Type<span style="color: red;">
															*</span></b></td>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
												<td id="claimType" width="90px;" required="true"
													autofocus="true"><span class="plain-select"> <select required
														name="claimType">
															<option value="0">Select Option</option>
															<option value="ACCIDENT">Accident</option>
															<option value="THEFT">Theft</option>
															<option value="FIRE">Fire</option>
															<option value="FLOOD">Flood</option>
															<option value="SALVAGE">Net Of Salvage</option>
															<option value="TOTAL LOSS">Total Loss</option>
															<option value="OTHERS">Others</option>

													</select>
												</span></td>

												<td><b>Previous Claim No.</b></td>
												<td><input type="text" id="previousClaimsNo"
													name="previousClaimsNo" size="20" maxlength="20"></td>
											</tr>

											<tr>
												<td><b>Policy Type<span style="color: red;">
															*</span></b></td>
												<td width="25px;"><span class="plain-select"> <select
														type="text" id="policyType" name="policyType">
															<option value="">Select Option</option>
															<option value="COMPREHENSIVE">COMPREHENSIVE</option>
															<option value="THIRD PARTY">THIRD PARTY</option>
															<option value="OTHERS">OTHERS</option>

													</select>
												</span></td>
												<td><b>Driver Name</b></td>
												<td><input id="driveName" name="driveName" size="20" /></td>
												<td><b>Driver Licence No.</b></td>
												<td><input id="driverLicense"
													name="driverLicenseNumber" size="20" /></td>
											</tr>

										</table>
										<br /> <br /> <input type="hidden"
											name="${_csrf.parameterName}" value="${_csrf.token}" />
										<div class="form-group">
											<button class="applyBtn btn btn-sm btn-success" type="submit"
												value="Submit" id="submitButton">
												<span class=""></span> Submit
											</button>
										</div>

										&nbsp; &nbsp; &nbsp;

										<div class="form-group">
											<button class="applyBtn btn  btn-sm btn-danger" type="reset"
												value="Reset">
												<span class=""></span> Reset
											</button>
										</div>
									</form>
								</div>
							</div>
						</center>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
		$(document).ready(function() {

			$("#claimDate").click(function() {
				$(this).datepicker().datepicker("show")
			});

			$("#payoutDate").click(function() {
				$(this).datepicker().datepicker("show")
			});

		});
	</script>

	<script>
		function validateform() {
			var regnNumber = document.claimForm.regnNumber.value;
			var claimDate = document.claimForm.claimDate.value;
			var payoutDate = document.claimForm.payoutDate.value;
			if (regnNumber == null || regnNumber == "") {
				alert("Registration Number can't be blank");
				return false;
			} else if (regnNumber != null && regnNumber != ""
					&& regnNumber.length < 7) {
				alert("Registration length should be greater than 7 digits ");
				return false;
			}

			else if (claimDate == null || claimDate == "") {
				alert("Claim Date can't be blank");
				return false;
			} else if (payoutDate == null || payoutDate == "") {
				alert(" Claim PayOut Date can't be blank");
				return false;
			} else if (claimDate > payoutDate) {
				alert("Please ensure Claim PayOut Date must be greater than Claim Date");
				return false;
			} else {
				alert(" Form Submitted successfully");
				return true;
			}
		}

		function checkInput(ob) {
			var invalidChars = /[^a-z0-9]/gi
			if (invalidChars.test(ob.value)) {
				ob.value = ob.value.replace(invalidChars, "");
			}
		};
	</script>




	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>


</body>
</html>



