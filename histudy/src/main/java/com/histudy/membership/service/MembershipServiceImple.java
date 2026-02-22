package com.histudy.membership.service;

import java.util.List;
import java.util.Map;

import com.histudy.membership.model.MembershipDAO;
import com.histudy.membership.model.MembershipPaymentDTO;

public class MembershipServiceImple implements MembershipService {
	private MembershipDAO membershipDao;

	public MembershipServiceImple(MembershipDAO membershipDao) {
		this.membershipDao=membershipDao;
	}
	@Override
	public String membershipGrade(int user_idx) {
		return membershipDao.membershipGrade(user_idx);
	}
	@Override
	public int insertBasic(int user_idx) {
		// TODO Auto-generated method stub
		return membershipDao.insertBasic(user_idx);
	}
	@Override
	public int insertPrimium(MembershipPaymentDTO paymentDTO) {
		// TODO Auto-generated method stub
		return membershipDao.insertPrimium(paymentDTO);
	}
	@Override
	public List<Map<String, Object>> getPayment(Map<String,Object> map){
		return membershipDao.getPayment(map);
	}
	@Override
	public Integer getPaymentTotalCnt(int user_idx) {
		// TODO Auto-generated method stub
		return membershipDao.getPaymentTotalCnt(user_idx);
	}
}
