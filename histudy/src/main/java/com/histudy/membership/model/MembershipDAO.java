package com.histudy.membership.model;

import java.util.List;
import java.util.Map;

public interface MembershipDAO {
	int insertPrimium(MembershipPaymentDTO paymentDTO);
	int insertBasic(int user_idx);
	String membershipGrade(int user_idx);
	public List<Map<String, Object>> getPayment(Map<String,Object> map);
	public int getPaymentTotalCnt(int user_idx);

}
