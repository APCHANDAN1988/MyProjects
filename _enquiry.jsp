<%@ page import="com.mid.web.model.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page session="true"%>

<c:if test="${not empty vehicle}">
	<br />

	<div class="staff-block">
		<div class="staff-section">
			<div class="staff-name" id="vehicleId">Registration Details</div>

			<div class="staff-desc">
				<table width="1200px;" align="center" cellspacing="2"
					cellpadding="8">
					<br />
					<tr>
						<td width="1%;"></td>
						<td width="15%;"><b>Registration Number</b></td>
						<td width="15%;"><c:out value="${vehicle.regnNumber}" /></td>

						<td
							style="width: 3%; border-left: 3px solid rgba(255, 255, 255, .5)"></td>

						<td width="15%;"><b>Registration Date</b></td>
						<c:choose>
							<c:when
								test="${vehicle.regnDt eq null || empty  vehicle.regnDt }">
								<td width="15%;"><c:out value="NOT AVAILABLE" /></td>
							</c:when>
							<c:otherwise>
								<td width="15%;"><c:out value="${vehicle.regnDt}" /></td>
							</c:otherwise>
						</c:choose>

						<td
							style="width: 3%; border-left: 3px solid rgba(255, 255, 255, .5)"></td>
						<td width="15%;"><b>Purchase Date</b></td>

						<c:choose>
							<c:when
								test="${vehicle.purchaseDt eq null || empty  vehicle.purchaseDt }">
								<td width="15%;"><c:out value="NOT AVAILABLE" /></td>
							</c:when>
							<c:otherwise>
								<td width="15%;"><c:out value="${vehicle.purchaseDt}" /></td>
							</c:otherwise>
						</c:choose>
					</tr>
					<tr>
						<td width="1%;"></td>

						<td width="15%;"><b>Chassis Number</b></td>
						<td width="15%;"><c:out value="${vehicle.chasiNumber}" /></td>

						<td
							style="width: 3px; border-left: 3px solid rgba(255, 255, 255, .5)"></td>

						<td width="15%"><b>Engine Number</b></td>
						<td><c:out value="${vehicle.engNumber}" /></td>

						<td
							style="width: 3px; border-left: 3px solid rgba(255, 255, 255, .5)"></td>

						<td width="15%;"><b>Vehicle Type</b></td>
						<c:choose>
							<c:when test="${vehicle.vhClassDesc eq null }">
								<td width="15%;"><c:out value="NOT AVAILABLE" /></td>
							</c:when>
							<c:otherwise>
								<td width="15%;""><c:out value="${vehicle.vhClassDesc}" /></td>
							</c:otherwise>
						</c:choose>
					</tr>

					<tr>
						<td width="1%;"></td>

						<td width="15%;"><b>State Code</b></td>
						<td width="15%;"><c:out value="${vehicle.stateCd}" /></td>

						<td
							style="width: 3px; border-left: 3px solid rgba(255, 255, 255, .5)"></td>

						<td width="15%"><b>Rto Code</b></td>
						<td><c:out value="${vehicle.rtoCd}" /></td>

						<td
							style="width: 3px; border-left: 3px solid rgba(255, 255, 255, .5)"></td>

						<td width="15%;"><b></b></td>

					</tr>

				</table>
				<br />
			</div>


			<div class="staff-name" id="vehicleId">Vehicle Details</div>
			<div class="staff-desc">
				<table width="1200px;" align="center" cellspacing="2"
					cellpadding="8">
					<br />
					<tr>
						<td width="1%;"></td>
						<td width="15%;"><b>Make</b></td>
						<td width="15%;"><c:out value="${vehicle.makerDesc}" /></td>

						<td
							style="width: 3%; border-left: 3px solid rgba(255, 255, 255, .5)"></td>


						<td width="15%;"><b>Model</b></td>
						<c:choose>
							<c:when test="${vehicle.makerModel eq null }">
								<td width="15%;"><c:out value="NOT AVAILABLE" /></td>
							</c:when>
							<c:otherwise>
								<td width="15%;"><c:out value="${vehicle.makerModel}" /></td>
							</c:otherwise>
						</c:choose>
						<td
							style="width: 3%; border-left: 3px solid rgba(255, 255, 255, .5)"></td>
						<td width="15%;"><b>Variant</b></td>
						<c:choose>
							<c:when test="${vehicle.varDesc eq null }">
								<td width="15%;"><c:out value="NOT AVAILABLE" /></td>
							</c:when>
							<c:otherwise>
								<td><c:out value="${vehicle.varDesc}" /></td>
							</c:otherwise>
						</c:choose>

					</tr>
					<tr>
						<td width="1%;"></td>

						<td width="15%;"><b>Sub Variant</b></td>

						<c:choose>
							<c:when test="${vehicle.subVariant eq null }">
								<td width="15%;"><c:out value="NOT AVAILABLE" /></td>
							</c:when>
							<c:otherwise>
								<td><c:out value="${vehicle.subVariant}" /></td>
							</c:otherwise>
						</c:choose>

						<td
							style="width: 3px; border-left: 3px solid rgba(255, 255, 255, .5)"></td>

						<td width="15%;"><b>Fuel</b></td>
						<c:choose>
							<c:when test="${vehicle.fuelDesc eq null }">
								<td width="15;"><c:out value="NOT AVAILABLE" /></td>
							</c:when>
							<c:otherwise>
								<td><c:out value="${vehicle.fuelDesc}" /></td>
							</c:otherwise>
						</c:choose>

						<td
							style="width: 3px; border-left: 3px solid rgba(255, 255, 255, .5)"></td>

						<td width="15%;"><b>Body Type</b></td>
						<c:choose>
							<c:when test="${vehicle.bodyTypeDesc eq null }">
								<td width="15%;"><c:out value="NOT AVAILABLE" /></td>
							</c:when>
							<c:otherwise>
								<td width="15%;""><c:out value="${vehicle.bodyTypeDesc}" /></td>
							</c:otherwise>
						</c:choose>

					</tr>
					<tr>
						<td width="1%;"></td>
						<td width="15%"><b>Seat Capacity</b></td>
						<c:choose>
							<c:when test="${vehicle.seatCap eq null }">
								<td width="15%;"><c:out value="NOT AVAILABLE" /></td>
							</c:when>
							<c:otherwise>
								<td width="15%;""><c:out value="${vehicle.seatCap}" /></td>
							</c:otherwise>
						</c:choose>


						<td
							style="width: 3px; border-left: 3px solid rgba(255, 255, 255, .5)"></td>

						<td width="15%;"><b>Cubic Capacity</b></td>
						<c:choose>
							<c:when test="${vehicle.cubicCap eq null }">
								<td width="15%;"><c:out value="NOT AVAILABLE" /></td>
							</c:when>
							<c:otherwise>
								<td><c:out value="${vehicle.cubicCap}" /></td>
							</c:otherwise>
						</c:choose>
						<td
							style="width: 3px; border-left: 3px solid rgba(255, 255, 255, .5)"></td>
						<td width="15%;"><b>Color</b></td>
						<c:choose>
							<c:when test="${vehicle.color eq null }">
								<td width="15%;"><c:out value="NOT AVAILABLE" /></td>
							</c:when>
							<c:otherwise>
								<td width="15%;"><c:out value="${vehicle.color}" /></td>
							</c:otherwise>
						</c:choose>
					</tr>
				</table>
				<br />
				<!--  Vehicle End view -->

			</div>




			<div class="staff-name">Insurance Details</div>
			<c:if test="${not empty insurance && empty theft}">
				<div class="staff-desc">
					<table width="100%" align="center" cellspacing="1" cellpadding="8">
						<br />
						<tr>
							<td width="2%"></td>
							<td width="10%"><b>Insurer Name</b></td>
							<c:choose>
								<c:when test="${insurance.insurerName eq null }">
									<td><c:out value="NOT AVAILABLE" /></td>
								</c:when>
								<c:otherwise>
									<td width="15%;"><c:out value="${insurance.insurerName}" /></td>
								</c:otherwise>
							</c:choose>
							<td
								style="width: 4px; border-left: 3px solid rgba(255, 255, 255, .5)"></td>

							<td width="15%;"><b>Insurance Number </b></td>
							<c:choose>
								<c:when test="${insurance.insuranceNumber eq null }">
									<td width="15%;"><c:out value="NOT AVAILABLE" /></td>
								</c:when>
								<c:otherwise>
									<td><c:out value="${insurance.insuranceNumber}" /></td>
								</c:otherwise>
							</c:choose>
							<td
								style="width: 4px; border-left: 3px solid rgba(255, 255, 255, .5)"></td>
							<td width="15%;"><b>Insurance Type </b></td>
							<c:choose>
								<c:when test="${insurance.insType eq null }">
									<td width="15%;"><c:out value="NOT AVAILABLE" /></td>
								</c:when>
								<c:otherwise>
									<td><c:out value="${insurance.insType}" /></td>
								</c:otherwise>
							</c:choose>
						</tr>

						<tr>
							<td width="2%"></td>
							<td width="15%;"><b>Insurance Date</b></td>
							<c:choose>
								<c:when test="${insurance.insDate eq null }">
									<td><c:out value="NOT AVAILABLE" /></td>
								</c:when>
								<c:otherwise>
									<td width="15%;"><c:out value="${insurance.insDate}" /></td>
								</c:otherwise>
							</c:choose>
							<td
								style="width: 4px; border-left: 3px solid rgba(255, 255, 255, .5)"></td>

							<td width="15%;"><b>Insurance Start Date</b></td>
							<c:choose>
								<c:when test="${insurance.insStartDate eq null }">
									<td><c:out value="NOT AVAILABLE" /></td>
								</c:when>
								<c:otherwise>
									<td width="15%;"><c:out value="${insurance.insStartDate}" /></td>
								</c:otherwise>
							</c:choose>

							<td
								style="width: 4px; border-left: 3px solid rgba(255, 255, 255, .5)"></td>
							<td width="15%;"><b>Insurance End Date</b></td>
							<c:choose>
								<c:when test="${insurance.insEndDate eq null }">
									<td><c:out value="NOT AVAILABLE" /></td>
								</c:when>
								<c:otherwise>
									<td width="15%;"><c:out value="${insurance.insEndDate}" /></td>
								</c:otherwise>
							</c:choose>
						</tr>
					</table>
				</div>
			</c:if>
			<c:if test="${empty insurance &&  empty theft}">
				<div class="staff-desc">
					<p
						style="color: Red; font-size: 14px; padding-left: 475px; padding-right: 100px;">
						Not Insured on Record
					<p>
				</div>
			</c:if>



			<!--   Claim  -->
			<div class="staff-name">Claim Details</div>
			<c:if test="${not empty insurance && empty theft}">
				<div class="staff-desc">
					<table width="100%" align="center" cellspacing="1" cellpadding="8">

						<thead>
							<tr>
								<td width="12%;"><b>Insurance Number</b></td>
								<td width="12%;"><b>Insurer Name</b></td>
								<td width="12%;"><b>Claim Number</b></td>
								<td width="13%;"><b>Claim Type</b></td>
								<td width="13%;"><b>Loss Date</b></td>
								<td width="13%;"><b>Claim Date</b></td>
								<td width="13%;"><b>Claim Pay Out Date</b></td>
							</tr>
						</thead>

						<tbody>

							<c:forEach items="${claimList}" var="claim">
								<tr>

									<td><c:out value="${claim.insuranceNumber}" /></td>

									<c:choose>
										<c:when test="${claim.insurerName eq null}">

											<td style="font-size: 11px;"><c:out
													value="NOT AVAILABLE" /></td>
										</c:when>

										<c:otherwise>
											<td><c:out value="${claim.insurerName}" /></td>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${claim.claimNumber eq null}">
											<td style="font-size: 11px;"><c:out
													value="NOT AVAILABLE" /></td>

										</c:when>

										<c:otherwise>
											<td width="15%"><c:out value="${claim.claimNumber}" /></td>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${claim.claimType eq null}">
											<td style="font-size: 11px;"><c:out
													value="NOT AVAILABLE" /></td>
										</c:when>

										<c:otherwise>
											<td><c:out value="${claim.claimType}" /></td>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${claim.dateOfLloss eq null}">

											<td style="font-size: 11px;"><c:out
													value="NOT AVAILABLE" /></td>
										</c:when>

										<c:otherwise>
											<td><c:out value="${claim.dateOfLloss}" /></td>
										</c:otherwise>
									</c:choose>

									<c:choose>
										<c:when test="${claim.claimDate eq null}">

											<td style="font-size: 11px;"><c:out
													value="NOT AVAILABLE" /></td>
										</c:when>

										<c:otherwise>
											<td><c:out value="${claim.claimDate}" /></td>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${claim.payOutDate eq null}">

											<td style="font-size: 11px;"><c:out
													value="NOT AVAILABLE" /></td>
										</c:when>

										<c:otherwise>
											<td><c:out value="${claim.payOutDate}" /></td>
										</c:otherwise>
									</c:choose>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>

			</c:if>


			<!--   Pre-Inspection -->
			<div class="staff-name">PreInspection Details</div>
			<c:if test="${not empty insurance && empty theft}">
				<div class="staff-desc">
					<table width="100%" align="center" cellspacing="1" cellpadding="8">


					</table>
				</div>
			</c:if>





		</div>
	</div>
</c:if>

<c:if test="${empty insurance && not empty theft}">
	<div class="staff-desc">
		<p
			style="color: Red; font-size: 14px; padding-left: 475px; padding-right: 100px;">
			Record found in Theft
		<p>
	</div>
</c:if>


<c:if test="${empty vehicle &&  empty errorMsg}">
	<c:if test="${insurance.regnNumber == null}">
		<div align="center" style="padding: 30px; color: Red;">
			<h2>Sorry, This Vehicle is not insured on record.</h2>
		</div>
	</c:if>

</c:if>
<c:if test="${empty vehicle && not empty errorMsg}">
	<div align="center" style="padding: 30px; color: Red;">
		<h2>${errorMsg}</h2>

	</div>
</c:if>
<script language="javascript">
	//<![CDATA[

	$('.staff-name').hover(function() {
		$(this).toggleClass('hover');
	});
	var lastItem;
	$('.staff-name').click(function(currentItem) {
		var currentItem = $(this);
		if ($(this).next().height() == 0) {
			$(lastItem).css({
				'font-weight' : 'normal'
			});
			$(lastItem).next().animate({
				height : '0px'
			}, 200, 'swing');
			$(this).css({
				'font-weight' : 'bold'
			});
			$(this).next().animate({
				height : '130px',
				opacity : 1
			}, 200, 'swing');
		} else {
			$(this).css({
				'font-weight' : 'normal'
			});
			$(this).next().animate({
				height : '0px',
				opacity : 1
			}, 400, 'swing');
		}
		lastItem = $(this);
	});
	//]]>
</script>
<script>
	function PrintElem(elem) {
		Popup(jQuery(elem).html());
	}

	function Popup(data) {

		var mywindow = window.open('', 'my div', 'height=400,width=600');
		mywindow.document.write('<html><head><title></title>');

		mywindow.document
				.write('<style type="text/css">.test { color:red; } </style></head><body>');

		mywindow.document.write(data);
		mywindow.document.write('</body></html>');
		mywindow.document.close();
		mywindow.print();

	}
</script>