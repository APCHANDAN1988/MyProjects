/**
 * 
 */
package com.mid.web.service.impl;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

import org.w3c.dom.Element;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.w3c.dom.CharacterData;

import javax.xml.bind.DatatypeConverter;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.codec.Base64;
import org.springframework.stereotype.Service;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import com.mid.web.dao.AuditLogDao;
import com.mid.web.dao.PolicyDao;
import com.mid.web.dao.UserDao;
import com.mid.web.form.Policy;
import com.mid.web.form.Search;
import com.mid.web.model.AuditLog;
import com.mid.web.model.Claim;
import com.mid.web.model.Insurance;
import com.mid.web.model.Theft;
import com.mid.web.model.User;
import com.mid.web.model.Vehicle;
import com.mid.web.model.api.ClientUrl;
import com.mid.web.model.api.Response;
import com.mid.web.model.api.Result;
import com.mid.web.model.api.SearchInsurance;
import com.mid.web.service.PolicyManager;
import com.mid.web.util.StringUtil;

@Service(value = "policyManager")
public class PolicyManagerImpl implements PolicyManager {

	@Autowired
	PolicyDao policyDao;

	@Autowired
	UserDao userDao;

	@Autowired
	AuditLogDao auditLogDao;

	@Secured({ "ROLE_ADMIN", "ROLE_USER", "ROLE_INSURER", "ROLE_POLICE",
			"ROLE_LAWYER", "ROLE_SURYEOR" })
	@Override
	public Vehicle searchVehicle(Search search) {

		Vehicle vehicle = null;

		vehicle = policyDao.searchVehicle(search);

		if (vehicle == null) {
			if (search.getRegnNumber().matches(
					"^[A-Za-z]{2}[1-9]{1}[a-zA-Z]{1,2}\\w*$")) {
				StringBuilder strRegn = new StringBuilder(
						search.getRegnNumber());
				strRegn.insert(2, "0");
				search.setRegnNumber(strRegn.toString());
				vehicle = policyDao.searchVehicle(search);

			} else if (search.getRegnNumber()
					.matches("^[A-Za-z]{2}[0]{1}\\w*$")) {
				StringBuilder strRegn = new StringBuilder(
						search.getRegnNumber());
				strRegn.deleteCharAt(2);
				search.setRegnNumber(strRegn.toString());
				vehicle = policyDao.searchVehicle(search);
			}
		}
		return vehicle;
	}

	@Override
	public Theft searchTheft(Search search) {
		return policyDao.searchTheft(search);
	}

	@Override
	public List<Claim> searchClaim(Search search) {
		return policyDao.searchClaim(search);

	}

	@Override
	public void saveClaimDetails(Claim claim) {
		policyDao.saveClaimDetails(claim);
	}

	@Override
	public List<Vehicle> autoPopulateVehicleInfo(Search search) {

		List<Vehicle> list = null;

		list = policyDao.autoPopulateVehicleInfo(search);

		if (list == null || list.size() == 0) {
			if (search.getRegnNumber().matches(
					"^[A-Za-z]{2}[1-9]{1}[a-zA-Z]{1,2}\\w*$")) {
				StringBuilder strRegn = new StringBuilder(
						search.getRegnNumber());
				strRegn.insert(2, "0");
				search.setRegnNumber(strRegn.toString());
				list = policyDao.autoPopulateVehicleInfo(search);

			} else if (search.getRegnNumber()
					.matches("^[A-Za-z]{2}[0]{1}\\w*$")) {
				StringBuilder strRegn = new StringBuilder(
						search.getRegnNumber());
				strRegn.deleteCharAt(2);
				search.setRegnNumber(strRegn.toString());

				list = policyDao.autoPopulateVehicleInfo(search);

			}
		}
		return list;

	}

	@Override
	public void savePolicyDetails(Policy savePolicy) {
		policyDao.savePolicyDetails(savePolicy);
	}

	@Override
	public List<Search> filterBy(Search search) {

		return policyDao.filterBy(search);

	}

	@Override
	public List<Policy> searchHistory(Search search) {

		return policyDao.searchHistory(search);
	}

	@Override
	public Insurance searchInsurance(Search search) {

		return policyDao.searchInsurance(search);
	}

	@Override
	public List<Insurance> getInsuranceByUser(User user, Integer roleId) {
		return policyDao.getInsuranceByUser(user, roleId);
	}

	@Override
	public Insurance insuranceByFilter(Search search) {
		return policyDao.insuranceByFilter(search);
	}

	/*
	 * MID API Methods
	 */
	@Override
	public SearchInsurance search(Search search) {

		SearchInsurance searchIns = new SearchInsurance();

		User user = userDao.getUserByUsername(this.getCurrentUsername());

		if (StringUtil.isNullOrBlank(search.getRegnNumber())
				&& StringUtil.isNullOrBlank(search.getChasisNumber())
				&& StringUtil.isNullOrBlank(search.getEngineNumber())) {
			searchIns.setStatus(103);
			searchIns.setDescription("Required input not provided");
			return searchIns;
		}

		if (!StringUtil.isNullOrBlank(search.getRegnNumber())
				&& (search.getRegnNumber().length() < 6
						|| search.getRegnNumber().length() > 12 || !search
						.getRegnNumber().matches("^[A-Z].*?\\d$"))) {
			searchIns.setStatus(102);
			searchIns.setError_code(1);
			searchIns.setDescription("Invalid input regn_no");
			return searchIns;
		}

		if (!StringUtil.isNullOrBlank(search.getChasisNumber())
				&& (search.getChasisNumber().length() < 5 || search
						.getChasisNumber().length() > 20)) {
			searchIns.setStatus(102);
			searchIns.setError_code(2);
			searchIns.setDescription("Invalid input chasi_no");
			return searchIns;
		}

		if (!StringUtil.isNullOrBlank(search.getEngineNumber())
				&& (search.getEngineNumber().length() < 5 || search
						.getEngineNumber().length() > 20)) {
			searchIns.setStatus(102);
			searchIns.setError_code(3);
			searchIns.setDescription("Invalid input eng_no");
			return searchIns;
		}

		// List<Result> resultList = policyDao.search(search);

		List<ClientUrl> urlList = this.getAllURL();

		Response response = new Response();
		if (!urlList.isEmpty() && urlList.size() > 0) {

			List<com.mid.web.model.api.Policy> policyList = new ArrayList<com.mid.web.model.api.Policy>();

			String whereClause = "";
			if (!StringUtil.isNullOrBlank(search.getRegnNumber())) {
				whereClause += "regn_no='" + search.getRegnNumber() + "'";
			}
			if (!StringUtil.isNullOrBlank(search.getChasisNumber())) {

				whereClause += "&chasi_no='" + search.getChasisNumber() + "'";

			}
			if (!StringUtil.isNullOrBlank(search.getEngineNumber())) {

				whereClause += "&eng_no='" + search.getEngineNumber() + "'";

			}
			for (ClientUrl clientURL : urlList) {
				String domain = clientURL.getDomain() + "?" + whereClause;
				System.out.println("domain " + domain);

				clientURL.setDomain(domain);

				/* ########################################### */
				/* ########################################### */
				response = forwardRequest(clientURL, search);
				policyList.add(response.getPolicy());
			}

			searchIns.setDescription("Request execute successfully");
			searchIns.setStatus(100);
			searchIns.setSearch_by(search.getSearchOption());
			searchIns.setRequestTime(search.getRequestTime());
			searchIns.setRequest_id(search.getRequestID());
			searchIns.setPolicy_list(policyList);

		} else {
			// System.out.println("Request not proceed");
		}

		return searchIns;
	}

	public Response forwardRequest(ClientUrl clientURL, Search search) {

		Response response = new Response();
		String webURL = null;
		String returnString = "";
		Result result = new Result();
		com.mid.web.model.api.Policy policy = new com.mid.web.model.api.Policy();

		try {
			webURL = clientURL.getDomain();
			String name = clientURL.getLoginname();
			String password = clientURL.getPassword();

			String authString = name + ":" + password;
			String authEncBytes = DatatypeConverter
					.printBase64Binary(authString.getBytes());
			String authStringEnc = new String(authEncBytes);

			URL url = new URL(webURL);
			HttpURLConnection urlConnection = (HttpURLConnection) url
					.openConnection();
			urlConnection.setRequestProperty("Authorization", "Basic "
					+ authStringEnc);

			int httpStatus = urlConnection.getResponseCode();

			// System.out.println("httpStatus " + httpStatus);
			if (httpStatus == 200) {

				DocumentBuilder builder = null;
				Document doc = null;
				InputSource src = new InputSource();
				InputStream ipstream = urlConnection.getInputStream();
				if (ipstream != null) {
					BufferedReader bfreader = new BufferedReader(
							new InputStreamReader(ipstream));
					returnString = bfreader.readLine();
					try {
						builder = DocumentBuilderFactory.newInstance()
								.newDocumentBuilder();
					} catch (ParserConfigurationException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}

					src.setCharacterStream(new StringReader(returnString));

					try {
						doc = builder.parse(src);
					} catch (SAXException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}

					int foundStatus = Integer.parseInt(doc
							.getElementsByTagName("status").item(0)
							.getTextContent());
					System.out.println("foundStatus " + foundStatus);

					String description = doc
							.getElementsByTagName("description").item(0)
							.getTextContent();
					String search_by = doc.getElementsByTagName("search_by")
							.item(0).getTextContent();

					System.out.println("returnString " + returnString);

					if (foundStatus == 100) {

						String regn_no = doc.getElementsByTagName("regn_no")
								.item(0).getTextContent();
						String chasi_no = doc.getElementsByTagName("chasi_no")
								.item(0).getTextContent();
						String eng_no = doc.getElementsByTagName("eng_no")
								.item(0).getTextContent();

						String makerDesc = doc
								.getElementsByTagName("makerDesc").item(0)
								.getTextContent();
						String maker_model = doc
								.getElementsByTagName("maker_model").item(0)
								.getTextContent();
						String fuel_type = doc
								.getElementsByTagName("fuel_type").item(0)
								.getTextContent();
						String manuYr = doc.getElementsByTagName("manuYr")
								.item(0).getTextContent();
						String vh_class_desc = doc
								.getElementsByTagName("vh_class_desc").item(0)
								.getTextContent();

						com.mid.web.model.api.Registration registration = new com.mid.web.model.api.Registration();
						com.mid.web.model.api.Vehicle vehicle = new com.mid.web.model.api.Vehicle();
						com.mid.web.model.api.Insurance insurance = new com.mid.web.model.api.Insurance();

						registration.setRegnNumber(regn_no);
						registration.setChasiNumber(chasi_no);
						registration.setEngNumber(eng_no);

						vehicle.setMakerDesc(makerDesc);
						vehicle.setMakerModel(maker_model);
						vehicle.setFuelDesc(fuel_type);
						vehicle.setVhClassDesc(vh_class_desc);
						vehicle.setManuYr(manuYr);

						insurance.setInsurerName(doc
								.getElementsByTagName("vh_class_desc").item(0)
								.getTextContent());
						insurance.setInsuranceNumber(doc
								.getElementsByTagName("insurance_no").item(0)
								.getTextContent());
						insurance.setInsType(doc
								.getElementsByTagName("ins_type").item(0)
								.getTextContent());
						insurance.setInsStartDate(doc
								.getElementsByTagName("ins_start_dt").item(0)
								.getTextContent());
						insurance.setInsEndDate(doc
								.getElementsByTagName("ins_end_dt").item(0)
								.getTextContent());

						result.setRegistration(registration);
						result.setVehicle(vehicle);
						result.setInsurance(insurance);

						policy.setResult(result);

						response.setSearch_by(search_by);
						response.setDescription(description);
						response.setStatus(foundStatus);
						response.setRequestTime(search.getRequestTime());
						policy.setClient_id(clientURL.getClientId());
						policy.setClient_name(clientURL.getClientName());
						policy.setStatus(String.valueOf(foundStatus));
						policy.setDescription(response.getDescription());
						policy.setInsurance_flg("YES");
						System.out.println("if method called");

					} else {

						System.out.println("else method called");
						response.setSearch_by(search.getSearchOption());
						response.setDescription(description);
						response.setRequestTime(search.getRequestTime());

						policy.setClient_id(clientURL.getClientId());
						policy.setClient_name(clientURL.getClientName());
						policy.setStatus("101");
						policy.setDescription(response.getDescription());
						policy.setInsurance_flg("NO");

						// System.out.println("policy  else  info foundStatus"
						// + foundStatus);

					}

				}

			} else {

				System.out.println("else out of loop method called");

				policy.setClient_name(clientURL.getClientName());
				policy.setClient_id(clientURL.getClientId());
				policy.setStatus(String.valueOf(httpStatus));
				response.setStatus(httpStatus);

				if (httpStatus == 401) {
					policy.setDescription("Bad Credentail");
				}
				if (httpStatus == 404) {
					policy.setDescription("Bad Requested URL");
				}
				policy.setInsurance_flg("NO");

			}

			search.setDomainID(clientURL.getDomainId());

			auditLogDao.insertResponseLog(result, response, policy, search);

			response.setPolicy(policy);

		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return response;
	}

	public static String getCharacterDataFromElement(Element e) {
		Node child = e.getFirstChild();
		if (child instanceof CharacterData) {
			CharacterData cd = (CharacterData) child;
			return cd.getData();
		}
		return "";
	}

	@Override
	public List<ClientUrl> getAllURL() {
		return policyDao.getAllURL();

	}

	public String getCurrentUsername() {
		String username = null;
		Object principal = SecurityContextHolder.getContext()
				.getAuthentication().getPrincipal();
		if (principal instanceof UserDetails) {
			username = ((UserDetails) principal).getUsername();
		} else {
			username = principal.toString();
		}

		return username;
	}

	@Override
	public Response searchRecord(Search search) {

		Response respone = new Response();

		if (search.getRegnNumber() != null) {
			search.setSearchOption("Regn_no");
		} else if (search.getChasisNumber() != null) {
			search.setSearchOption("Chasi_no");
		} else
			search.setSearchOption("Eng_no");

		respone.setSearch_by(search.getSearchOption());

		List<Result> returnList = policyDao.search(search);
		if (returnList == null || returnList.size() == 0) {

			if (search.getRegnNumber().matches(
					"^[A-Za-z]{2}[1-9]{1}[a-zA-Z]{1,2}\\w*$")) {
				StringBuilder strRegn = new StringBuilder(
						search.getRegnNumber());
				strRegn.insert(2, "0");
				search.setRegnNumber(strRegn.toString());
				returnList = policyDao.search(search);
			} else if (search.getRegnNumber()
					.matches("^[A-Za-z]{2}[0]{1}\\w*$")) {
				StringBuilder strRegn = new StringBuilder(
						search.getRegnNumber());
				strRegn.deleteCharAt(2);
				search.setRegnNumber(strRegn.toString());
				returnList = policyDao.search(search);
			}
		}

		if (returnList == null) {
			respone.setStatus(101);
			respone.setDescription("Record not found");
		}

		else {
			respone.setStatus(100);
			respone.setDescription("Record found successfully");
			respone.setResult(returnList);
		}
		return respone;
	}

	class CallableTask implements Callable<Response> {
		ClientUrl clientUrl;
		Search search;

		public CallableTask(ClientUrl clientUrl, Search search) {
			this.clientUrl = clientUrl;
			this.search = search;
		}

		@Override
		public Response call() throws Exception {
			// TODO Auto-generated method stub

			System.out.println("calllable ");
			return forwardRequest(clientUrl, search);
		}

	}

}
