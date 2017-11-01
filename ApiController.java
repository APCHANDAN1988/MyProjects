/**
 * 
 */
package com.mid.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.mid.web.form.Search;
import com.mid.web.model.api.Response;
import com.mid.web.model.api.SearchInsurance;
import com.mid.web.service.AuditManager;
import com.mid.web.service.PolicyManager;

import com.mid.web.util.StringUtil;

@RestController
@RequestMapping("/api/v1")
public class ApiController {

	@Autowired
	PolicyManager policyManager;

	@Autowired
	AuditManager auditManager;

	@RequestMapping(value = "/vehicle/insurance", method = RequestMethod.GET)
	public com.mid.web.model.api.SearchInsurance Policy(
			@ModelAttribute Search search,
			@RequestParam(value = "regn_no", defaultValue = "") String regnNum,
			@RequestParam(value = "chasi_no", defaultValue = "") String chasiNum,
			@RequestParam(value = "eng_no", defaultValue = "") String engNum) {

		search.setRegnNumber(StringUtil.cleanString(regnNum));
		search.setChasisNumber(StringUtil.cleanString(chasiNum));
		search.setEngineNumber(StringUtil.cleanString(engNum));

		/*
		 * String requestId = dateStr.replaceAll("-", "").replaceAll(":", "")
		 * .replaceAll("\\s+", "");
		 */

		search.setRequestTime(StringUtil.getDateTime());

		Long requestId = StringUtil.generateUniqueId();
		search.setRequestID(String.valueOf(requestId));

		SearchInsurance searchIns = policyManager.search(search);

		search.setResposneTime(StringUtil.getDateTime());
		auditManager.populateLog(search, searchIns);

		return searchIns;
	}

	@RequestMapping(value = "/vehicle/insurance1", method = RequestMethod.GET)
	public Response Insurance1(
			@ModelAttribute Search search,
			@RequestParam(value = "regn_no", defaultValue = "") String regnNum,
			@RequestParam(value = "chasi_no", defaultValue = "") String chasiNum,
			@RequestParam(value = "eng_no", defaultValue = "") String engNum) {

		search.setRegnNumber(StringUtil.cleanString(regnNum));
		search.setChasisNumber(StringUtil.cleanString(chasiNum));
		search.setEngineNumber(StringUtil.cleanString(engNum));

		Response response = policyManager.searchRecord(search);

		return response;
	}

	@RequestMapping(value = "/vehicle/insurance2", method = RequestMethod.GET)
	public Response Insurance2(
			@ModelAttribute Search search,
			@RequestParam(value = "regn_no", defaultValue = "") String regnNum,
			@RequestParam(value = "chasi_no", defaultValue = "") String chasiNum,
			@RequestParam(value = "eng_no", defaultValue = "") String engNum) {

		search.setRegnNumber(StringUtil.cleanString(regnNum));
		search.setChasisNumber(StringUtil.cleanString(chasiNum));
		search.setEngineNumber(StringUtil.cleanString(engNum));
		System.out.println("API called");

		Response response = policyManager.searchRecord(search);

		return response;
	}

	@RequestMapping(value = "/vehicle/insurance3", method = RequestMethod.GET)
	public Response Insurance3(
			@ModelAttribute Search search,
			@RequestParam(value = "regn_no", defaultValue = "") String regnNum,
			@RequestParam(value = "chasi_no", defaultValue = "") String chasiNum,
			@RequestParam(value = "eng_no", defaultValue = "") String engNum) {

		search.setRegnNumber(StringUtil.cleanString(regnNum));
		search.setChasisNumber(StringUtil.cleanString(chasiNum));
		search.setEngineNumber(StringUtil.cleanString(engNum));

		Response response = policyManager.searchRecord(search);

		return response;
	}

}
