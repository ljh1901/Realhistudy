package com.histudy.study.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.histudy.study.model.StudyDTO;
import com.histudy.user.model.UserDTO;

public interface StudyService {
   
	
	/** 스터디 리스트 조회 */
	public List<StudyDTO> getStudyList(Map<String, Integer> map);
	
	/** 스터디 총 갯수 (페이징 시 필요) */
	public int studyTotalCnt(Integer sc_idx);
	
	/** 스터디 개설 페이지 이동 시 로그인된 사용자 정보 조회 */
	public UserDTO getStudyCreateUser(int user_idx);
	
	/** 스터디 내용 페이지 입장 시 필요한 데이터 조회 */
	public StudyDTO getStudyContent(int study_idx);
	
	/** 스터디 검색 시 디비에 저장되어 있는 모든 스터디 제목 조회 */
	public List<StudyDTO> findStudyTitle();
	
	/** 검색 결과가 몇개인지 총 갯수 조회 */
	public int studyTitleSearchTotalCnt(String searchTitle);

	/** 스터디 개설 처리 */
	public String createStudyProcess(StudyDTO dto, MultipartFile uploadFile, int user_idx);

}
