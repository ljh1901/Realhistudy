package com.histudy.lms.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.histudy.study.model.StudyApplyDTO;
import com.histudy.study.model.StudyDTO;

public class LmsDAOImple implements LmsDAO {
	
	private SqlSessionTemplate sqlSession;
	
	public LmsDAOImple(SqlSessionTemplate sqlSession) {
		super();
		this.sqlSession = sqlSession;
	}

	/** 로그인된 사용자가 개설자인지 체크 */
	@Override
	public List<StudyDTO> studyCreatorCheck(int user_idx) {
		List<StudyDTO> lists = sqlSession.selectList("studyCreatorCheck", user_idx);
		return lists;
	}
	
	/** 로그인된 사용자가 참여자인지 체크 */
	@Override
	public List<StudyApplyDTO> studyApplyCheck(int user_idx) {
		List<StudyApplyDTO> lists = sqlSession.selectList("studyApplyCheck", user_idx);
		return lists;
	}
	
	/** 참여자라면 어떤 스터디에 참여중인지 체크 */
	@Override
	public List<StudyDTO> studyApproved(int study_idx) {
		List<StudyDTO> lists = sqlSession.selectList("studyApproved", study_idx);
		return lists;
	}
	
	/** 과제 등록 */
	@Override
	public int insertTask(LmsDTO dto) {
		int count = sqlSession.insert("insertTask", dto);
		return count;
	}
	
	/** 개설자일 경우 과제 가져오기 */
	@Override
	public List<LmsDTO> selectStudyCreatorTask(int user_idx) {
		List<LmsDTO> lists = sqlSession.selectList("selectStudyCreatorTask", user_idx);
		return lists;
	}
	
	/** 참여자일 경우 과제 가져오기 */
	@Override
	public List<LmsDTO> selectStudyApprovedTask(int user_idx) {
		List<LmsDTO> lists = sqlSession.selectList("selectStudyApprovedTask", user_idx);
		return lists;
	}
	
	/** 과제 제출 페이지 접속 시 상단에 해당 과제 정보 */
	@Override
	public LmsDTO selectTask(int a_idx) {
		LmsDTO dto = sqlSession.selectOne("selectTask", a_idx);
		return dto;
	}
	
	/** 대기 중인 과제 수  */
	@Override
	public int waitTaskCount(int user_idx) {
		int waitTaskCount = sqlSession.selectOne("waitTaskCount", user_idx);
		return waitTaskCount;
	}
	
	/** 제출 완료된 과제 수 */
	@Override
	public int taskSubmitOkCount(int user_idx) {
		int taskSubmitOkCount =sqlSession.selectOne("taskSubmitOkCount", user_idx);
		return taskSubmitOkCount;
	}
	
	/** 개설자라면 본인이 개설한 스터디의 과제 갯수 가져오기*/
	@Override
	public int myStudyInTaskCount(int study_idx) {
		int myStudyInTaskCount = sqlSession.selectOne("myStudyInTaskCount", study_idx);
		return myStudyInTaskCount;
	}
	
	/** 참여자라면 본인이 참여한 스터디의 과제 갯수를 가져오기 */
	@Override
	public int memberStudyInTaskCount(Map<String, Integer> map) {
		int memberStudyInTaskCount = sqlSession.selectOne("memberStudyInTaskCount", map);
		return memberStudyInTaskCount;
	}
	
	/** 과제 등록 수정 */
	@Override
	public int taskInsertUpdate(LmsDTO dto) {
		int count = sqlSession.update("taskInsertUpdate", dto);
		return count;
	}
	
	/** 멤버 관리 페이지 이동 시 해당 스터디 정보 가져오기 */
	@Override
	public StudyDTO selectStudyData(int study_idx) {
		StudyDTO dto = sqlSession.selectOne("selectStudyData", study_idx);
		return dto;
	}

	/** 스터디 참여자의 정보 가져오기 */
	@Override
	public List<StudyApplyDTO> memberData(int study_idx) {
		List<StudyApplyDTO> list = sqlSession.selectList("memberData", study_idx);
		return list;
	}
	
	/** 스터디 가입 신청자 정보 가져오기 */
	@Override
	public List<StudyApplyDTO> studyApplicationUser(int study_idx) {
		 List<StudyApplyDTO> lists = sqlSession.selectList("studyApplicationUser", study_idx);
		 return lists;
	}
	
	/** 스터디 승인 시 상태와 join_date 변경 */
	@Override
	public int studyApplicationApproved(Map<String, Integer> map) {
		int count = sqlSession.update("studyApplicationApproved", map);
		return count;
	}
	
	/** 스터디 거부 시 상태와 거부사유 변경 */
	@Override
	public int studyApplicationReject(Map map) {
		int count = sqlSession.update("studyApplicationReject", map);
		return count;
	}
	
	/** 멤버관리 페이지에 리더 정보를 보내기 위한 조회 */
	@Override
	public StudyDTO studyCreatorData(int study_idx) {
		StudyDTO dto = sqlSession.selectOne("studyCreatorData", study_idx);
		return dto;
	}
	
	/** 총 과제 수 조회 */
	@Override
	public int taskTotalCount(int study_idx) {
		int count = sqlSession.selectOne("taskTotalCount",study_idx);
		return count;
	}
	
	/** 참여자마다 제출한 과제 수 구하기 */
	@Override
	public int taskSubmitCount(Map<String, Integer> map) {
		int count = sqlSession.selectOne("taskSubmitCount", map);
		return count;
	}
	
	/** 참여중인 스터디 멤버 삭제하기 */
	@Override
	public int deleteStudyMember(Map<String, Integer> map) {
		int count = sqlSession.delete("deleteStudyMember", map);
		return count;
	}
	
	/** 스터디 시작일과 현재 날짜 가져오기 */
	@Override
	public StudyDTO studyDateCheck(int study_idx) {
		StudyDTO dto = sqlSession.selectOne("studyDateCheck", study_idx);
		return dto;
		
	}
	
	/** 스터디 진행중 / 완료됨 처리하기 */
	@Override
	public int studyStatusUpdate(Map<String, Integer> map) {
		int count = sqlSession.update("studyStatusUpdate", map);
		return count;
	}
	
	/** 완료된 스터디 가져오기 */
	@Override
	public List<StudyDTO> finishStudy(int study_status) {
		List<StudyDTO> lists = sqlSession.selectList("finishStudy", study_status);
		return lists;
	}
	
	/** 현재멤버수, 최대멤버수 가져오기 */
	@Override
	public StudyDTO selectMemberNum(int study_idx) {
		StudyDTO dto = sqlSession.selectOne("selectMemberNum", study_idx);
		return dto;
	}
	
	/** 스터디 승인 or 멤버삭제시 현재 멤버 수 업데이트하기 */
	@Override
	public int currentMembersUpdate(Map<String, Integer> map) {
		int count = sqlSession.update("currentMembersUpdate", map);
		return count;
	}
	
	@Override
	public String getStudyTitle(int study_idx) {
	    String studyTitle=sqlSession.selectOne("getStudyTitle", study_idx);
	    return studyTitle;
	}
	
	/**==== LmsRestController에서 쓰는 DAO ====*/
	/** 왼쪽 내 스터디 클릭 시 리더일 경우 해당 스터디의 과제만 추출 */
	@Override
	public List<LmsDTO> lmsRestLeaderSelectTask(Map<String, Integer> map) {
		List<LmsDTO> lists = sqlSession.selectList("lmsRestLeaderSelectTask", map);
		return lists;
	}
	
	/** 왼쪽 내 스터디 클릭 시 멤버일 경우 해당 스터디의 과제만 추출 */
	@Override
	public List<LmsDTO> lmsRestMemberSelectTask(Map<String, Integer> map) {
		List<LmsDTO> lists = sqlSession.selectList("lmsRestMemberSelectTask", map);
		return lists;
	}
	
	/** 토글에서 제출완료 클릭 시 제출이 완료된 과제 추출 */
	@Override
	public List<LmsDTO> assignmentSubmitOk(int user_idx) {
		List<LmsDTO> lists = sqlSession.selectList("assignmentSubmitOk", user_idx);
		return lists;
	}

}
