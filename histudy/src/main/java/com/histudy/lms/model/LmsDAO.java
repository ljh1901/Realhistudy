package com.histudy.lms.model;

import java.util.*;

import com.histudy.study.model.StudyApplyDTO;
import com.histudy.study.model.StudyDTO;

public interface LmsDAO {

	/** 로그인된 사용자가 개설자인지 체크 */
	public List<StudyDTO> studyCreatorCheck(int user_idx);
	
	/** 로그인된 사용자가 참여자인지 체크 */
	public List<StudyApplyDTO> studyApplyCheck(int user_idx);
	
	/** 참여자라면 어떤 스터디에 참여중인지 체크 */
	public List<StudyDTO> studyApproved(int study_idx);
	
	/** 과제 등록 */
	public int insertTask(LmsDTO dto);
	
	/** 개설자일 경우 과제 가져오기 */
	public List<LmsDTO> selectStudyCreatorTask(int user_idx); 
	
	/** 참여자일 경우 과제 가져오기 */
	public List<LmsDTO> selectStudyApprovedTask(int user_idx); 
	
	/** 과제 제출 페이지 접속 시 상단에 해당 과제 정보 */
	public LmsDTO selectTask(int a_idx);
	
	/** 대기 중인 과제 수  */
	public int waitTaskCount(int user_idx);
	
	/** 제출 완료된 과제 수 */
	public int taskSubmitOkCount(int user_idx);
	
	/** 개설자라면 본인이 개설한 스터디의 과제 갯수 가져오기*/
	public int myStudyInTaskCount(int study_idx);
	
	/** 참여자라면 본인이 참여한 스터디의 과제 갯수를 가져오기 */
	public int memberStudyInTaskCount(Map<String, Integer> map);
	
	/** 과제 등록 수정 */
	public int taskInsertUpdate(LmsDTO dto);
	
	/** 멤버 관리 페이지 이동 시 해당 스터디 정보 가져오기 */
	public StudyDTO selectStudyData(int study_idx);
	
	/** 스터디 참여자의 정보 가져오기 */
	public List<StudyApplyDTO> memberData(int study_idx);
	
	/** 스터디 가입 신청자 정보 가져오기 */
	public List<StudyApplyDTO> studyApplicationUser(int study_idx);
	
	/** 스터디 승인 시 상태와 join_date 변경 */
	public int studyApplicationApproved(Map<String, Integer> map);
	
	/** 스터디 거부 시 상태와 거부사유 변경 */
	public int studyApplicationReject(Map map);
	
	/** 멤버관리 페이지에 리더 정보를 보내기 위한 조회 */
	public StudyDTO studyCreatorData(int study_idx);
	
	/** 총 과제 수 조회 */
	public int taskTotalCount(int study_idx);
	
	/** 참여자마다 제출한 과제 수 구하기 */
	public int taskSubmitCount(Map<String, Integer> map);
	
	/** 참여중인 스터디 멤버 삭제하기 */
	public int deleteStudyMember(Map<String, Integer> map);
	
	/** 스터디 시작일과 현재 날짜 가져오기 */
	public StudyDTO studyDateCheck(int study_idx);
	
	/** 스터디 진행중 / 완료됨 처리하기 */
	public int studyStatusUpdate(Map<String, Integer> map);
	
	/** 완료된 스터디 가져오기 */
	public List<StudyDTO> finishStudy(int study_status);
	
	/** 현재멤버수, 최대멤버수 가져오기 */
	public StudyDTO selectMemberNum(int study_idx);
	
	/** 스터디 승인 or 멤버삭제시 현재 멤버 수 업데이트하기 */
	public int currentMembersUpdate(Map<String, Integer> map);
	
	public String getStudyTitle(int study_idx);
	
	/**==== LmsRestController에서 쓰는 DAO ====*/
	/** 왼쪽 내 스터디 클릭 시 리더일 경우 해당 스터디의 과제만 추출 */
	public List<LmsDTO> lmsRestLeaderSelectTask(Map<String, Integer> map);
	
	/** 왼쪽 내 스터디 클릭 시 멤버일 경우 해당 스터디의 과제만 추출 */
	public List<LmsDTO> lmsRestMemberSelectTask(Map<String, Integer> map);
	
	/** 토글에서 제출완료 클릭 시 제출이 완료된 과제 추출 */
	public List<LmsDTO> assignmentSubmitOk(int user_idx);
	
}
