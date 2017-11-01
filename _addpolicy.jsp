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
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/boot.css"
	type="text/css">
<link
	href="${pageContext.request.contextPath}/resources/fonts/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath}/resources/fonts/lineo-icon/style.css"
	rel="stylesheet" type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/style.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>

<%-- <c:if test="${search.status == 100}"> --%>
<c:if test="${not empty policy}">
	<div style="margin-top: -10px;">
		<div class="container" id="Form-div">

			<div class="filter-panel collapse in " id="filter-panel"
				style="height: auto;">
				<div class="panel panel-default">

					<div class="panel-body">
						<form role="form" action="" method="post" id="searchForm"
							name="policyForm2" class="form-inline"
							onsubmit="return validateform2()">
							<c:forEach items="${policy}" var="varPolicy">
								<div class="theft-title registration_mod" id="vehicle_mod">
									Vehicle details</div>
								<br />

								<table width="90%" align="center" cellspacing="1"
									cellpadding="8">

									<tr>

										<!--  function call of Ajax with Registration -->

										<td width="200px;"><b>Registration Number <span
												style="color: red;"> *</span></b></td>
										<td><input type="text" name="regnNumber" id="regnNumber"
											value="${search.regnNumber}" size="21" minlength="7"
											maxlength="20" class="cssInput" placeholder="Enter regn_no"
											required autofocus></td>

										<td width="200px;"><b>Chassis Number<span
												style="color: red;"> *</span></b></td>
										<td><input type="text" name="chasisNumber"
											id="chasisNumber" value="${varPolicy.chasisNumber}" size="21"
											minlength="7" maxlength="20" required autofocus></td>

										<td width="200px;"><b>Engine Number<span
												style="color: red;"> *</span></b></td>
										<td><input type="text" name="engineNumber"
											id="engineNumber" value="${varPolicy.engineNumber}" size="21"
											minlength="7" maxlength="20" required autofocus></td>
									</tr>
									<tr>

										<td><b>Registration Date<span style="color: red;">
													*</span></b></td>
										<td><input type="text" name="regnDt" id="regnDt"
											value="${varPolicy.regnDt}" size="21" maxlength="20" required
											autofocus></td>

										<td><b>Purchase Date</b></td>
										<td><input type="text" name="purchaseDt" id="purchaseDt"
											value="${varPolicy.purchaseDt}" size="21" maxlength="20"
											placeholder="Please select date"></td>
										<td><b>Year Of Manufacture</b></td>
										<td><input type="text" name="manfYr" id="manfYr"
											value="${varPolicy.manfYr}" size="21" maxlength="20"></td>
									</tr>
									<tr>

										<td><b>Make<span style="color: red;"> *</span></b></td>
										<td><input type="text" name="make" id="make"
											value="${varPolicy.make}" size="21" maxlength="20" required
											autofocus></td>

										<td><b>Model<span style="color: red;"> *</span></b></td>
										<td><input type="text" name="model" id="model"
											value="${varPolicy.model}" size="21" maxlength="20" required
											autofocus></td>

										<td><b>Variant<span style="color: red;"> *</span></b></td>
										<td><input type="text" name="variant" id="variant"
											value="${varPolicy.variant}" size="21" maxlength="20"
											required autofocus></td>

									</tr>
									<tr>

										<td><b>Vehicle Type<span style="color: red;">
													*</span></b></td>
										<td><input type="text" name="vhType" id="vhType"
											value="${varPolicy.vhType}" size="21" maxlength="20" required
											autofocus></td>

										<td><b>Body Type<span style="color: red;"> *</span></b></td>
										<td><input type="text" name="bodyType" id="bodyType"
											value="${varPolicy.bodyType}" size="21" maxlength="20"></td>

										<td><b>Seat Capacity<span style="color: red;">
													*</span></b></td>
										<td><input type="text" name="seatCap" id="seatCap"
											value="${varPolicy.seatCap}" size="21" maxlength="20"
											required autofocus></td>


									</tr>
									<tr>

										<td><b>Fuel<span style="color: red;"> *</span></b></td>
										<td><input type="text" name="fuel" id="fuel"
											value="${varPolicy.fuel}" size="21" maxlength="20" required
											autofocus></td>

										<td><b>Cubic Capacity<span style="color: red;">
													*</span></b></td>
										<td><input type="text" name="cubicCap" id="cubicCap"
											value="${varPolicy.cubicCap}" size="21" maxlength="20"
											required autofocus></td>

										<td><b>Gross Vehicle Weight </b></td>
										<td><input type="text" name="grossVhcWt" id="grossVhcWt"
											value="${varPolicy.grossVhcWt}" size="21" maxlength="20"></td>

									</tr>

								</table>
								<br />

								<div class="theft-title registration_mod">Insurance
									Details</div>
								<br />

								<table width="90%" align="center" cellspacing="1"
									cellpadding="8">
									<tr>
										<td width="208px";><b>Policy Number<span
												style="color: red;"> *</span></b></td>
										<td><input type="text" name="policyNo" id="policyNo"
											value="" size="21" maxlength="20" required autofocus></td>

										<td width="210px";><b>Insurance Company <span
												style="color: red;"> *</span>
										</b></td>
										<td><input type="text" name="companyName" id="companyID"
											value="" size="21" maxlength="20" required autofocus></td>

										<td width="220px";><b>Policy Type<span
												style="color: red;"> *</span></b></td>
										<td><span class="plain-select"> <select required
												name="policyType">
													<option value="">Select Option</option>
													<option value="COMPREHENSIVE">COMPREHENSIVE</option>
													<option value="THIRD PARTY">THIRD PARTY</option>
													<option value="OTHERS">OTHERS</option>

											</select>
										</span></td>
									</tr>
									<tr>
										<td><b>Policy Date</b></td>
										<td><input id="policyDt2" name="policyDate" size="21"
											maxlength="20" placeholder="Please select date" /></td>

										<td><b>Policy Start Date<span style="color: red;">
													*</span></b></td>

										<td><input id="insStartDt2" name="insStartDt" size="21"
											maxlength="20" class="cssInput"
											placeholder="Please select date" required="true"
											autofoucs="true" /></td>


										<td><b>Policy End Date<span style="color: red;">
													*</span></b></td>
										<td><input type="text" id="insEndDt2" size="21"
											name="insEndDt" maxlength="20"
											placeholder="Please select date" required="true"
											autofoucs="true"></td>
									</tr>
									<tr>


										<td><b>NCB Discount</b></td>
										<td><span class="plain-select"> <select
												name="ncbDiscount">
													<option value="">Select option</option>
													<option value="0">0 %</option>
													<option value="20">20 %</option>
													<option value="25">25 %</option>
													<option value="35">35 %</option>
													<option value="40">40 %</option>
													<option value="50">50 %</option>

											</select>
										</span></td>

										<td><b>Insured Declared Value(IDV)</b></td>
										<td><input type="text" name="idv" size="21"
											maxlength="20"></td>
									</tr>

								</table>
							</c:forEach>
							<br /> &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
							<div class="form-group">

								<button class="applyBtn btn btn-sm btn-success" type="submit"
									value="Submit" id="submitButton">
									<span class=""></span> Submit
								</button>
							</div>
							&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
							<div class="form-group">

								<button class="applyBtn btn  btn-sm " type="reset" value="Reset"
									onClick="refreshPage()">
									<span class=""></span> Reset
								</button>
							</div>
							<div class="form-group">
								<input type="hidden" type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" class="form-control input-sm" />
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</c:if>

<c:if test="${empty policy}">
	<div style="margin-top: -34px;">
		<!-- form start -->
		<div class="container" id="Form-div">
			<div class="row">
				<div class="filter-panel collapse in " id="filter-panel"
					style="height: auto;">
					<div class="panel panel-default">
						<center>
							<div class="panel-body">
								<div>
									<form role="form" action="" method="post" id="searchForm2"
										name="policyForm2" class="form-inline"
										onsubmit="return validateform()">

										<div class="theft-title registration_mod" id="vehicle_mod">
											Vehicle details</div>
										<br />

										<table width="90%" align="center" cellspacing="1"
											cellpadding="8">
											<tr>

												<td width="200px"><b>Registration Number <span
														style="color: red;"> *</span></b></td>
												<td><input type="text" name="regnNumber"
													id="regnNumber" value="${search.regnNumber}" size="21"
													minlength="7" maxlength="12" required="true"
													autofocus="true"></td>


												<td width="200px"><b>Chassis Number<span
														style="color: red;"> *</span></b></td>
												<td><input type="text" name="chasisNumber"
													id="chasisNumber" value="" size="21" maxlength="20"
													minlength="7" required="true" autofocus="true"></td>

												<td width="200px"><b>Engine Number<span
														style="color: red;"> *</span></b></td>
												<td><input type="text" name="engineNumber"
													id="engineNumber" value="" size="21" maxlength="20"
													minlength="7" required="true" autofocus="true"></td>
											</tr>

											<tr>

												<td><b>Registration Date<span style="color: red;">
															*</span></b></td>
												<td><input type="text" name="regnDt" id="regnDt"
													value="" size="21" maxlength="20" required="true"
													autofocus="true"></td>

												<td><b>Purchase Date</b></td>
												<td><input type="text" name="purchaseDt"
													id="purchaseDt" value="" size="21" maxlength="20"
													placeholder="Please select date"></td>
												<td><b>Year Of Manufacture</b></td>
												<td><input type="text" name="manfYr" id="manfYr"
													value="" size="21" minlength="4" maxlength="4"></td>

											</tr>

											<tr>

												<td><b>Make<span style="color: red;"> *</span></b></td>
												<td><input type="text" name="make" id="make" value=""
													size="21" maxlength="20" required="true" autofocus="true"></td>

												<td><b>Model<span style="color: red;"> *</span></b></td>
												<td><input type="text" name="model" id="model" value=""
													size="21" maxlength="20" required="true" autofocus="true"></td>

												<td><b>Variant<span style="color: red;"> *</span></b></td>
												<td><input type="text" name="variant" id="variant"
													value="" size="21" maxlength="20" required="true"
													autofocus="true"></td>

											</tr>
											<tr>

												<td><b>Vehicle Type<span style="color: red;">
															*</span></b></td>

												<td id="vhType"><span class="plain-select"> <select
														required name="vhType">
															<option value="">Select option</option>
															<option value="2W">2W</option>
															<option value="LMV">LMV</option>
															<option value="3W">3W</option>
															<option value="LCV">LCV</option>
															<option value="HCV">HCV</option>
															<option value="TRACTOR">TRACTOR</option>
															<option value="BUS">BUS</option>
															<option value="AGRICULTURE">AGRICULTURE</option>
															<option value="CONSTRUCTION">CONSTRUCTION</option>
															<option value="MIS">MIS</option>

													</select>
												</span></td>


												<td><b>Body Type<span style="color: red;"> *</span></b></td>
												<td><input type="text" name="bodyType" id="bodyType"
													value="" size="21" maxlength="20" required="true"
													autofocus="true"></td>

												<td><b>Seat Capacity<span style="color: red;">
															*</span></b></td>
												<td><input type="text" name="seatCap" id="seatCap"
													value="" size="21" minlength="1" maxlength="3"
													required="true" autofocus="true"></td>

											</tr>
											<tr>

												<td><b>Fuel<span style="color: red;"> *</span></b></td>
												<td id="fuel"><span class="plain-select"> <select
														required name="fuel">
															<option value="">Select option</option>
															<option value="DIESEL">DIESEL</option>
															<option value="PETROL">PETROL</option>
															<option value="ELECTRIC">ELECTRIC</option>
															<option value="HYBRID">HYBRID</option>
															<option value="CNG/PETROL">CNG/PETROL</option>
															<option value="LPG/PETROL">LPG/PETROL</option>
													</select>
												</span></td>

												<td><b>Cubic Capacity<span style="color: red;">
															*</span></b></td>
												<td><input type="text" name="cubicCap" size="21"
													maxlength="20" required="true" autofocus="true"></td>

												<td><b>Gross Vehicle Weight<span
														style="color: red;"> *</span></b></td>
												<td><input type="text" name="grossVhcWt"
													id="grossVhcWt" size="21" maxlength="20"></td>

											</tr>
										</table>
										<div class="theft-title registration_mod">Insurance
											details</div>
										<br />

										<table width="90%" align="center" cellspacing="1"
											cellpadding="8">

											<tr>
												<td width="208px";><b>Policy Number<span
														style="color: red;"> *</span></b></td>
												<td><input type="text" name="policyNo" id="policyNo"
													size="21" maxlength="20" required="true" autofocus="true"></td>

												<td width="208px";><b>Insurance Company <span
														style="color: red;"> *</span></b></td>

												<td><span class="plain-select" width="28px;"> <select
														required id="companyName" name="companyName">
															<option value="">Select option</option>
															<option value="Agriculture Insurance">
																Agriculture Insurance</option>
															<option value="Apollo Munich Health Insurance">
																Apollo Munich Health Insurance</option>
															<option value="Cholamandalam MS General Insurance">
																Cholamandalam MS General Insurance</option>
															<option value=" Bajaj Allianz General Insurance">
																Bajaj Allianz General Insurance</option>
															<option value="Bharti AXA General Insurance">
																Bharti AXA General Insurance</option>
															<option value="Export Credit Guarantee ">Export
																Credit Guarantee</option>
															<option value="HDFC ERGO General Insurance">
																HDFC ERGO General Insurance</option>
															<option value="L&T General Insurance">L&T
																General Insurance</option>
															<option value="Liberty Videocon General Insurance">
																Liberty Videocon General Insurance</option>
															<option value="National Insurance ">National
																Insurance</option>
															<option value="National Insurance ">National
																Insurance</option>
															<option value="The Oriental Insurance ">The
																Oriental Insurance</option>
															<option value="Reliance General Insurance">
																Reliance General Insurance</option>
															<option value="Star Health and Allied Insurance">
																Star Health and Allied Insurance</option>
															<option value="United India Insurance">United
																India Insurance</option>
															<option value="Universal Sompo General Insurance ">
																Universal Sompo General Insurance</option>
															<option value="Cigna TTK Health Insurance">
																Cigna TTK Health Insurance</option>
															<option value="Future Generali India Insurance">
																Future Generali India Insurance</option>
															<option value="ICICI Lombard General Insurance">
																ICICI Lombard General Insurance</option>
															<option value="IFFCO Tokio General Insurance">
																IFFCO Tokio General Insurance</option>
															<option value="L&T General Insurance">L&T
																General Insurance</option>
															<option value="Magma HDI General Insurance">
																Magma HDI General Insurance</option>
															<option value="Max Bupa Health Insurance">Max
																Bupa Health Insurance</option>
															<option value="Raheja QBE General Insurance">
																Raheja QBE General Insurance</option>
															<option value="Religare Health Insurance">
																Religare Health Insurance</option>
															<option value="Royal Sundaram Alliance Insurance">
																Royal Sundaram Alliance Insurance</option>
															<option value="SBI General Insurance">SBI
																General Insurance</option>
															<option value="Shriram General Insurance">
																Shriram General Insurance</option>
															<option value="Tata AIG General Insurance">Tata
																AIG General Insurance</option>
															<option value="Kotak Mahindra General Insurance">
																Kotak Mahindra</option>
													</select>
												</span></td>

												<td width="208px";><b>Policy Type <span
														style="color: red;"> *</span></b></td>
												<td><span class="plain-select"> <select required
														name="policyType">
															<option value="">Select Option</option>
															<option value="COMPREHENSIVE">COMPREHENSIVE</option>
															<option value="THIRD PARTY">THIRD PARTY</option>
															<option value="OTHERS">OTHERS</option>

													</select>
												</span></td>
											</tr>
											<tr>
												<td><b>Policy Date</b></td>
												<td><input placeholder="Please select date"
													id="policyDt" name="policDate" size="21" maxlength="20" /></td>

												<td><b>Policy Start Date <span style="color: red;">
															*</span></b></td>

												<td><input placeholder="Please select date"
													id="insStartDt" name="insStartDt" size="21" maxlength="20"
													class="cssInput" required /></td>


												<td><b>Policy End Date<span style="color: red;">
															*</span></b></td>
												<td><input placeholder="Please select date"
													id="insEndDt" name="insEndDt" size="21" maxlength="20"
													class="cssInput" required /></td>
											</tr>
											<tr>

												<td><b>NCB Discount</b></td>
												<td><span class="plain-select"> <select
														name="ncbDiscount">
															<option value="">Select Option</option>
															<option value="0">0 %</option>
															<option value="20">20 %</option>
															<option value="25">25 %</option>
															<option value="35">35 %</option>
															<option value="40">40 %</option>
															<option value="50">50 %</option>

													</select>
												</span></td>

												<td><b>Insured Declared Value(IDV)</b></td>
												<td><input type="text" name="idv" size="21"
													maxlength="20"></td>
											</tr>

										</table>
										<br />

										<div class="form-group">
											<input type="hidden" type="hidden"
												name="${_csrf.parameterName}" value="${_csrf.token}"
												class="form-control input-sm" />
										</div>

										&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
										<div class="form-group">
											<button class="applyBtn btn btn-sm btn-success" type="submit"
												value="Submit" id="submitButton">
												<span class=""></span> Submit
											</button>
										</div>
										&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;

										<div class="form-group">
											<button class="applyBtn btn  btn-sm btn-danger" type="reset"
												value="Reset" onClick="refreshPage()">
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
</c:if>

<center>
	<div class="page printable_page" id="result_div">
		<div id="ajax_loader"></div>

	</div>
</center>

<script>
	function validateform() {
		var regnNumber = document.policyForm2.regnNumber.value;
		var StartDt = document.policyForm2.insStartDt.value;
		var EndDt = document.policyForm2.insEndDt.value;
		if (regnNumber == null || regnNumber == "") {
			alert("Registration Number can't be blank");
			return false;
		} else if (regnNumber != null && regnNumber != ""
				&& regnNumber.length < 7) {
			alert("Registration length should be greater than 7 digits ");
			return false;
		}

		else if (StartDt == null || StartDt == "") {
			alert("Polic Start Date can't be blank");
			return false;
		} else if (EndDt == null || EndDt == "") {
			alert(" Policy  End Date can't be blank");
			return false;
		} else if (StartDt > EndDt) {
			alert(" Policy End Date Must be greater than Policy Strat Date");
			return false;
		} else {
			alert(" Form Submitted successfully");
			return true;
		}
	}

	function validateform2() {
		var regnNumber = document.policyForm2.regnNumber.value;
		var StartDt = document.policyForm2.insStartDt2.value;
		var EndDt = document.policyForm2.insEndDt2.value;
		if (regnNumber == null || regnNumber == "") {
			alert("Registration Number can't be blank");
			return false;
		} else if (regnNumber != null && regnNumber != ""
				&& regnNumber.length < 7) {
			alert("Registration length should be greater than 7 digits ");
			return false;
		}

		else if (StartDt == null || StartDt == "") {
			alert("Polic Start Date can't be blank");
			return false;
		} else if (EndDt == null || EndDt == "") {
			alert(" Policy  End Date can't be blank");
			return false;
		} else if (StartDt > EndDt) {
			alert(" Policy End Date Must be greater than Policy Strat Date");
			return false;
		} else {
			alert(" Form Submitted successfully");
			return true;
		}
	}
	function DateCheck() {
		var StartDate = document.getElementById('insStartDt').value;
		var EndDate = document.getElementById('insEndDt').value;
		var eDate = new Date(EndDate);
		var sDate = new Date(StartDate);
		if (StartDate != '' && EndDate != '' && sDate > eDate) {
			alert("Please ensure that the Policy End Date is greater than Policy Start Date.");
			return false;
		}

	}

	$('input[name="number"]').keyup(function(e) {
		if (/\D/g.test(this.value)) {
			// Filter non-digits from input value.
			this.value = this.value.replace(/\D/g, '');
		}
	});
</script>


<script>
	$(function() {
		$("#regnDt").datepicker();
	});
	$(function() {
		$("#purchaseDt").datepicker();
	});

	$(function() {
		$("#policyDt2").datepicker();
	});

	$(function() {
		$("#insStartDt2").datepicker();
	});

	$(function() {
		$("#insEndDt2").datepicker();
	});

	$(function() {
		$("#policyDt").datepicker();
	});

	$(function() {
		$("#insStartDt").datepicker();
	});

	$(function() {
		$("#insEndDt").datepicker();
	});
</script>
<!-- <script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script> -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
</body>
</html>



