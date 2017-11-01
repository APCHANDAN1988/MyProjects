/**
 * 
 */
package com.mid.web.service;

import java.util.List;

import com.mid.web.form.Policy;
import com.mid.web.form.Search;
import com.mid.web.model.Claim;
import com.mid.web.model.Insurance;
import com.mid.web.model.Theft;
import com.mid.web.model.User;
import com.mid.web.model.Vehicle;
import com.mid.web.model.api.ClientUrl;
import com.mid.web.model.api.Response;
import com.mid.web.model.api.SearchInsurance;

public interface PolicyManager {

	public Vehicle searchVehicle(Search search);

	public Insurance searchInsurance(Search search);

	public void savePolicyDetails(Policy savePolicy);

	public List<Policy> searchHistory(Search search);

	public List<Search> filterBy(Search search);

	public List<Vehicle> autoPopulateVehicleInfo(Search search);

	public List<Claim> searchClaim(Search search);

	public void saveClaimDetails(Claim claim);

	public Theft searchTheft(Search search);

	public List<Insurance> getInsuranceByUser(User user, Integer roleId);

	public Insurance insuranceByFilter(Search search);

	public SearchInsurance search(Search search);

	public List<ClientUrl> getAllURL();

	public Response searchRecord(Search search);

	
}
