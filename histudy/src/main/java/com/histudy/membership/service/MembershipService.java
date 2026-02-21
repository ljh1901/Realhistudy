package com.histudy.membership.service;

import java.util.List;
import java.util.Map;

import com.histudy.membership.model.MembershipPaymentDTO;

public interface MembershipService {
	int insertPrimium(MembershipPaymentDTO paymentDTO);
	int insertBasic(int user_idx);
	String membershipGrade(int user_idx);
	public List<Map<String, Object>> getPayment(Map<String,Object> map);
	public int getPaymentTotalCnt(int user_idx);

}
