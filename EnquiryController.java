package com.mid.web.controller;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mid.web.form.Policy;
import com.mid.web.form.Search;
import com.mid.web.model.AuditLog;
import com.mid.web.model.Claim;
import com.mid.web.model.Insurance;
import com.mid.web.model.Theft;
import com.mid.web.model.User;
import com.mid.web.model.Vehicle;
import com.mid.web.service.AuditManager;
import com.mid.web.service.PolicyManager;
import com.mid.web.service.UserManager;
import com.mid.web.util.StringUtil;

@Controller
public class EnquiryController {

	@Autowired
	PolicyManager policyManager;

	@Autowired
	UserManager userManager;

	@Autowired
	AuditManager auditManager;

	private static final Logger logger = Logger
			.getLogger(EnquiryController.class);

	@RequestMapping(value = { "/dashboard", "/admin/dashboard" }, method = RequestMethod.GET)
	public String dashBoard(Model model, Principal principal) {

		return "dashboard";
	}

	@RequestMapping(value = { "/enquiry" }, method = RequestMethod.GET)
	public String search(Model model, Search search) {
		model.addAttribute("search", search);
		return "enquiry";
	}

	@RequestMapping(value = "/enquiry/search", method = RequestMethod.POST)
	public String searchMethod(@ModelAttribute Search search, Model model,
			HttpServletRequest request) {
		Vehicle vehicle = null;
		Theft theft = null;
		Insurance insurance = null;
		List<Claim> claimList = null;

		String msg = "";
		int status = 0;
		AuditLog auditLog = new AuditLog();

		User loggedInUser = (User) request.getSession().getAttribute(
				"USER_SESSION");

		// Set values to maintain log table

		search.setRegnNumber(StringUtil.cleanString(search.getRegnNumber()));
		search.setChasisNumber(StringUtil.cleanString(search.getChasisNumber()));

		auditLog.setRegnNumber(search.getRegnNumber());
		auditLog.setChasisNumber(search.getChasisNumber());

		// try {
		System.out.println(loggedInUser.getUsername());
		auditLog.setUsername(loggedInUser.getUsername());
		/*
		 * } catch (NullPointerException ex) { ex.getStackTrace(); }
		 */

		if (StringUtil.isNullOrBlank(search.getRegnNumber())
				&& StringUtil.isNullOrBlank(search.getChasisNumber())) {
			msg = "Input field not provided";
			status = 101;
		}

		if (!StringUtil.isNullOrBlank(search.getRegnNumber())
				&& (search.getRegnNumber().length() < 6 || search
						.getRegnNumber().length() > 12)
				&& !search.getRegnNumber().matches("^[A-Z].*?\\d$")) {

			msg = "Invalid input registration number";
			status = 102;
		}

		if (!StringUtil.isNullOrBlank(search.getChasisNumber())
				&& (search.getChasisNumber().length() < 5 || search
						.getChasisNumber().length() > 20)) {
			msg = "Invalid input chassis number";
			status = 103;

		}

		if (!StringUtil.isNullOrBlank(search.getRegnNumber())
				|| !StringUtil.isNullOrBlank(search.getChasisNumber())) {
			status = 100;
			// try {
			// Search vehicle
			vehicle = policyManager.searchVehicle(search);

			if (vehicle == null) {
				status = 104;
				auditLog.setRegnNumber(search.getRegnNumber());
				msg = "Record not Found into our Database";
			} else {
				search.setRegnNumber(vehicle.getRegnNumber());
				// Search Theft
				/*
				 * if (theft == null) { // Search Policy insurance =
				 * policyManager.searchInsurance(search); if (insurance != null)
				 * { claimList = policyManager.searchClaim(search); }
				 * 
				 * } else { msg = "Vehicle is showing is Theft status"; }
				 */
				insurance = policyManager.searchInsurance(search);
				claimList = policyManager.searchClaim(search);
				theft = policyManager.searchTheft(search);
				System.out.println("calim called");
			}
		}

		auditLog.setStatus(status);
		auditManager.saveLog(auditLog);

		model.addAttribute("vehicle", vehicle);
		model.addAttribute("theft", theft);
		model.addAttribute("insurance", insurance);
		model.addAttribute("claimList", claimList);
		model.addAttribute("errorMsg", msg);
		return "_enquiry";

	}

	@RequestMapping(value = { "/welcome" }, method = RequestMethod.GET)
	public String searchPublicUser(Model model) {

		model.addAttribute("search", new Search());
		return "public";
	}

	@RequestMapping(value = "/welcome/search", method = RequestMethod.POST)
	public String searchPublicUser(@ModelAttribute Search search, Model model,
			HttpServletRequest request) {

		Vehicle vehicle = null;
		String msg = "";

		search.setRegnNumber(StringUtil.cleanString(search.getRegnNumber()));
		search.setChasisNumber(StringUtil.cleanString(search.getChasisNumber()));

		if (StringUtil.isNullOrBlank(search.getRegnNumber())
				&& StringUtil.isNullOrBlank(search.getChasisNumber())) {
			msg = "Please provide input fields";
		}

		if (!StringUtil.isNullOrBlank(search.getRegnNumber())
				&& (search.getRegnNumber().length() < 6 || search
						.getRegnNumber().length() > 12)
				&& (!search.getRegnNumber().matches("^[A-Z].*?\\d$"))) {
			msg = "Invalid input registration number";
		}

		if (!StringUtil.isNullOrBlank(search.getChasisNumber())
				&& (search.getChasisNumber().length() < 5 || search
						.getChasisNumber().length() > 20)) {
			msg = "Invalid input chassis number";

		}

		if ((!StringUtil.isNullOrBlank(search.getRegnNumber()) || !StringUtil
				.isNullOrBlank(search.getChasisNumber()))) {

			vehicle = policyManager.searchVehicle(search);
		}
		search.setCaptcha("");
		model.addAttribute("policy", vehicle);
		model.addAttribute("errorMsg", msg);
		return "_enquiry";

	}

	/*
	 * @RequestMapping(value = "/enquiry/search", method = RequestMethod.POST)
	 * public String searchMethod(@ModelAttribute Search search, Model model,
	 * HttpServletRequest request) {
	 * 
	 * Policy policy = null; List<Claim> claimList = null; String msg = ""; int
	 * status = 0; AuditLog auditLog = new AuditLog();
	 * 
	 * User loggedInUser = (User) request.getSession().getAttribute(
	 * "USER_SESSION");
	 * 
	 * // Set values to maintain log table
	 * 
	 * search.setRegnNumber(StringUtil.cleanString(search.getRegnNumber()));
	 * search.setChasisNumber(StringUtil.cleanString(search.getChasisNumber()));
	 * auditLog.setRegnNumber(search.getRegnNumber());
	 * auditLog.setChasisNumber(search.getChasisNumber()); try {
	 * auditLog.setUsername(StringUtil.cleanString(loggedInUser
	 * .getUsername())); } catch (NullPointerException ex) { ex.getStackTrace();
	 * }
	 * 
	 * if (StringUtil.isNullOrBlank(search.getRegnNumber()) &&
	 * StringUtil.isNullOrBlank(search.getChasisNumber())) { msg =
	 * "Input field not provided"; status = 101; }
	 * 
	 * if (!StringUtil.isNullOrBlank(search.getRegnNumber()) &&
	 * (search.getRegnNumber().length() < 6 || search .getRegnNumber().length()
	 * > 12) && !search.getRegnNumber().matches("^[A-Z].*?\\d$")) {
	 * 
	 * msg = "Invalid input registration number"; status = 102; }
	 * 
	 * if (!StringUtil.isNullOrBlank(search.getChasisNumber()) &&
	 * (search.getChasisNumber().length() < 5 || search
	 * .getChasisNumber().length() > 20)) { msg =
	 * "Invalid input chassis number"; status = 103;
	 * 
	 * }
	 * 
	 * if (!StringUtil.isNullOrBlank(search.getRegnNumber()) ||
	 * !StringUtil.isNullOrBlank(search.getChasisNumber())) {
	 * 
	 * try { status = 100;
	 * 
	 * policy = policyManager.singlePolicySearch(search); if
	 * (policy.getRegnNumber() != null) {
	 * search.setRegnNumber(policy.getRegnNumber()); claimList =
	 * claimManager.claimSearch(search); System.out.println("calim called"); } }
	 * catch (NullPointerException ex) { ex.getStackTrace(); }
	 * 
	 * }
	 * 
	 * try { auditLog.setStatus(status); auditManager.saveLog(auditLog); } catch
	 * (Exception ex) { ex.getStackTrace(); } model.addAttribute("policy",
	 * policy); model.addAttribute("claimList", claimList);
	 * model.addAttribute("User", loggedInUser); model.addAttribute("errorMsg",
	 * msg); return "_enquiry";
	 * 
	 * }
	 */

	/*
	 * @RequestMapping(value = { "/welcome" }, method = RequestMethod.GET)
	 * public String searchPublicUser(Model model, HttpServletRequest request) {
	 * 
	 * HttpSession session = request.getSession(); model.addAttribute("search",
	 * new Search()); String captchaTxt =
	 * StringUtil.generateCaptchaTextMethod2(6);
	 * 
	 * session.setAttribute("CAPTCHA_KEY", captchaTxt);
	 * model.addAttribute("captchaTxt", captchaTxt); return "public"; }
	 * 
	 * @RequestMapping(value = "/welcome/search", method = RequestMethod.POST)
	 * public String searchPublicUser(@ModelAttribute Search search, Model
	 * model, HttpServletRequest request) {
	 * 
	 * Policy policy = null; String msg = "";
	 * 
	 * HttpSession session = request.getSession(false); String captcha =
	 * (String) session.getAttribute("CAPTCHA_KEY") .toString().trim();
	 * 
	 * search.setRegnNumber(StringUtil.cleanString(search.getRegnNumber()));
	 * search.setChasisNumber(StringUtil.cleanString(search.getChasisNumber()));
	 * 
	 * if (StringUtil.isNullOrBlank(search.getRegnNumber()) &&
	 * StringUtil.isNullOrBlank(search.getChasisNumber())) { msg =
	 * "Please provide input fields"; }
	 * 
	 * if (!StringUtil.isNullOrBlank(search.getRegnNumber()) &&
	 * (search.getRegnNumber().length() < 6 || search .getRegnNumber().length()
	 * > 12) && (!search.getRegnNumber().matches("^[A-Z].*?\\d$"))) { msg =
	 * "Invalid input registration number"; }
	 * 
	 * if (!StringUtil.isNullOrBlank(search.getChasisNumber()) &&
	 * (search.getChasisNumber().length() < 5 || search
	 * .getChasisNumber().length() > 20)) { msg =
	 * "Invalid input chassis number";
	 * 
	 * }
	 * 
	 * if (!StringUtil.isNullOrBlank(search.getRegnNumber()) &&
	 * (search.getCaptcha() == null || search.getCaptcha().equals( ""))) { msg =
	 * "Please Enter captch text"; } if
	 * (!StringUtil.isNullOrBlank(search.getRegnNumber()) &&
	 * (!StringUtil.isNullOrBlank(search.getCaptcha()) && !search
	 * .getCaptcha().equalsIgnoreCase(captcha))) {
	 * 
	 * msg = "Captcha does not match"; }
	 * 
	 * if ((!StringUtil.isNullOrBlank(search.getRegnNumber()) || !StringUtil
	 * .isNullOrBlank(search.getChasisNumber())) && captcha != null &&
	 * search.getCaptcha().equalsIgnoreCase(captcha)) {
	 * search.setRegnNumber(StringUtil.cleanString(search.getRegnNumber()));
	 * search.setChasisNumber(StringUtil.cleanString(search
	 * .getChasisNumber())); policy = policyManager.singlePolicySearch(search);
	 * } search.setCaptcha(""); model.addAttribute("policy", policy);
	 * model.addAttribute("errorMsg", msg); return "_enquiry";
	 * 
	 * }
	 */

	@RequestMapping(value = "/dashboard/history", method = RequestMethod.GET)
	public String searchHistory(Model model) {
		model.addAttribute("search", new Search());
		String message = "Welcome";
		model.addAttribute("message", message);
		return "history";
	}

	@RequestMapping(value = "/dashboard/history", method = RequestMethod.POST)
	public String SearchHisotry(@ModelAttribute Search search, Model model) {
		List<Policy> policyHistList = null;
		String msg = "";

		search.setRegnNumber(StringUtil.cleanString(search.getRegnNumber()));

		if (StringUtil.isNullOrBlank(search.getRegnNumber())) {
			msg = "Input field not provided";
		}

		if (!StringUtil.isNullOrBlank(search.getRegnNumber())
				&& (search.getRegnNumber().length() < 6 || search
						.getRegnNumber().length() > 12)
				&& (!search.getRegnNumber().matches("^[A-Z].*?\\d$"))) {

			msg = "Invalid input registration number";

		}

		try {
			if (!StringUtil.isNullOrBlank(search.getRegnNumber())) {
				search.setRegnNumber(StringUtil.cleanString(search
						.getRegnNumber()));

				policyHistList = policyManager.searchHistory(search);

			}
		} catch (Exception ex) {
			logger.error("Error : " + ex);
		}

		model.addAttribute("policyHistList", policyHistList);
		model.addAttribute("search", search);
		model.addAttribute("errorMsg", msg);
		return "history";

	}

	@RequestMapping(value = "/enquiry/filter", method = RequestMethod.GET)
	public String searchByFilter(Model model) {
		return "filter";
	}

	@RequestMapping(value = "/enquiry/filter", method = RequestMethod.POST)
	public String searchByFilter(@ModelAttribute Search search, Model model) {

		List<Search> filterList = null;
		String searchOption = null;

		try {
			if (!StringUtil.isNullOrBlank(search.getSearchOption())) {
				search.setSearchOption(StringUtil.cleanString(search
						.getSearchOption()));
				searchOption = search.getSearchOption();

				filterList = policyManager.filterBy(search);

			}
		} catch (Exception ex) {
			logger.error("Error : " + ex);
		}
		model.addAttribute("filterList", filterList);
		model.addAttribute("searchOption", searchOption);

		return "filter";

	}

}