package com.histudy.lms.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

import com.histudy.lms.model.LmsDAO;
import com.histudy.lms.model.LmsDTO;
import com.histudy.study.model.StudyApplyDTO;
import com.histudy.study.model.StudyDTO;


public class LmsServiceImple implements LmsService {

	private LmsDAO l_dao;
	
	
	public LmsServiceImple(LmsDAO l_dao) {
		super();
		this.l_dao = l_dao;
	}

	/** ===== LMSController에서 사용 ===== */
	@Override
	public List<StudyDTO> studyCreatorCheck(int user_idx) {
		List<StudyDTO> lists = l_dao.studyCreatorCheck(user_idx);
		return lists;
	}
	
	@Override
	public List<StudyApplyDTO> studyApplyCheck(int user_idx) {
		List<StudyApplyDTO> lists = l_dao.studyApplyCheck(user_idx);
		return lists;
	}

	@Override
	public List<StudyDTO> studyApproved(int study_idx) {
		List<StudyDTO> lists = l_dao.studyApproved(study_idx);
		return lists;
	}
	
	@Override
	public int insertTask(LmsDTO dto) {
		int count = l_dao.insertTask(dto);
		return count;
	}
	
	@Override
	public List<LmsDTO> selectStudyCreatorTask(int user_idx) {
		List<LmsDTO> lists = l_dao.selectStudyCreatorTask(user_idx);
		return lists;
	}
	
	@Override
	public List<LmsDTO> selectStudyApprovedTask(int user_idx) {
		List<LmsDTO> lists = l_dao.selectStudyApprovedTask(user_idx);
		return lists;
	}
	
	@Override
	public LmsDTO selectTask(int a_idx) {
		LmsDTO dto = l_dao.selectTask(a_idx);
		return dto;
	}
	
	@Override
	public int waitTaskCount(int user_idx) {
		int result = l_dao.waitTaskCount(user_idx);
		return result;
	}
	
	@Override
	public int taskSubmitOkCount(int user_idx) {
		int result = l_dao.taskSubmitOkCount(user_idx);
		return result;
	}
	
	@Override
	public int myStudyInTaskCount(int study_idx) {
		int result = l_dao.myStudyInTaskCount(study_idx);
		return result;
	}
	
	@Override
	public int memberStudyInTaskCount(Map<String, Integer> map) {
		int result = l_dao.memberStudyInTaskCount(map);
		return result;
	}
	
	@Override
	public List<LmsDTO> lmsRestLeaderSelectTask(Map<String, Integer> map) {
		List<LmsDTO> lists = l_dao.lmsRestLeaderSelectTask(map);
		return lists;
	}
	
	@Override
	public List<LmsDTO> lmsRestMemberSelectTask(Map<String, Integer> map) {
		List<LmsDTO> lists = l_dao.lmsRestMemberSelectTask(map);
		return lists;
	}
	
	
	@Override
	public List<LmsDTO> assignmentSubmitOk(int user_idx) {
		List<LmsDTO> lists = l_dao.assignmentSubmitOk(user_idx);
		return lists;
	}
	
	@Override
	public int taskInsertUpdate(LmsDTO dto) {
		int result = l_dao.taskInsertUpdate(dto);
		return result;
	}
	@Override
	public StudyDTO selectStudyData(int study_idx) {
		StudyDTO dto = l_dao.selectStudyData(study_idx);
		return dto;
	}
	
	
	@Override
	public List<StudyApplyDTO> studyApplicationUser(int study_idx) {
		List<StudyApplyDTO> lists = l_dao.studyApplicationUser(study_idx);
		return lists;
	}
	
	
	@Override
	public StudyDTO studyCreatorData(int study_idx) {
		StudyDTO dto = l_dao.studyCreatorData(study_idx);
		return dto;
	}
	
	@Override
	public int taskTotalCount(int study_idx) {
		int result = l_dao.taskTotalCount(study_idx);
		return result;
	}
	
	@Override
	public int taskSubmitCount(Map<String, Integer> map) {
		int result = l_dao.taskSubmitCount(map);
		return result;
	}

 	
 	@Override
 	public StudyDTO studyDateCheck(int study_idx) {
 		StudyDTO dto = l_dao.studyDateCheck(study_idx);
 		return dto;
 	}
 	
 	@Override
 	public int studyStatusUpdate(Map<String, Integer> map) {
 		int result = l_dao.studyStatusUpdate(map);
 		return result;
 	}
 	
 	@Override
 	public List<StudyDTO> finishStudy(int study_status) {
 		List<StudyDTO> lists = l_dao.finishStudy(study_status);
 		return lists;
 	}
 	
 	@Override
 	public StudyDTO selectMemberNum(int study_idx) {
 		StudyDTO dto = l_dao.selectMemberNum(study_idx);
 		return dto;
 	}
 	
 	@Override
 	public String getStudyTitle(int study_idx) {
 		String studyTitle=l_dao.getStudyTitle(study_idx);
 		return studyTitle;
 	}
 	
 	/** ===== Controller에서 호출하는 로직 처리 메서드 ===== */
 	/** 과제 등록 처리 */
 	@Override
 	public String insertTaskProcess(LmsDTO dto, MultipartFile prve_a_fname, HttpSession session) {
 		int study_idx = dto.getStudy_idx();
		
		StudyDTO datecheck = l_dao.studyDateCheck(study_idx);
		
		String begin = datecheck.getStudy_begin_date();
		String sysdate = datecheck.getSysdate();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		try {
			Date beginDate = sdf.parse(begin);
			Date sysDate = sdf.parse(sysdate);
			
			if(beginDate.getTime()>sysDate.getTime()) {
				 return "스터디 시작 전에 과제를 등록하실 수 없습니다. 스터디 시작일은 " + begin.substring(0,10) + "일 입니다.";
			}
		}catch(Exception e) {
			e.printStackTrace();
			return "과제 등록 중 오류가 발생했습니다.";
		}
		
		 // 2. 종료일 + 시간 합치기
		String a_end_date = dto.getA_end_date();
		String end_time = dto.getA_end_time();
		String end_time_m = dto.getA_end_time_m();
				
		String temp = a_end_date+" "+end_time+":"+end_time_m;
		dto.setA_end_date(temp);
		
		 // 3. 파일 처리
		if(prve_a_fname.isEmpty() || prve_a_fname == null || prve_a_fname.getOriginalFilename()=="") {
			dto.setA_fname("");
		}else {
			fileCopy(prve_a_fname, "C:/histudy/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/histudy/taskfile/");
			dto.setA_fname(prve_a_fname.getOriginalFilename());
		}
		
		dto.setUser_idx((Integer)session.getAttribute("user_idx"));
		
		int result = l_dao.insertTask(dto);
		String msg = result>0?"과제 등록 완료":"과제 등록 실패";
		
		return msg;
 	}
 	
	/** 등록된 과제 수정 처리 */
 	@Override
 	public String updateTaskProcess(LmsDTO dto, MultipartFile prve_a_fname) {

 	    // 1. 종료일 + 시간 합치기
 	    String temp = dto.getA_end_date() + " " + dto.getA_end_time() + ":" + dto.getA_end_time_m();
 	    dto.setA_end_date(temp);

 	    // 2. 파일 처리
 	    if (prve_a_fname != null && !prve_a_fname.isEmpty() && !prve_a_fname.getOriginalFilename().isEmpty()) {
 	    	fileCopy(prve_a_fname, "C:/histudy/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/histudy/taskfile/");
 	        dto.setA_fname(prve_a_fname.getOriginalFilename());
 	    } else {
 	        dto.setA_fname("");
 	    }

 	    // 3. DB 수정
 	    int result = l_dao.taskInsertUpdate(dto);

 	    return result > 0 ? "과제 수정 완료" : "과제 수정 실패";
 	}
 	
 	/** 스터디 종료일 계산 */
 	@Override
 	public String calculateStudyFinishDate(String study_begin_date, int study_total_weeks) {
 		
 		int week = 7; // 일주일
		int totalWeek = study_total_weeks * week; // 사용자가 선택한 주차 * 일주일
		
		int study_begin_year = Integer.parseInt(study_begin_date.substring(0,4));
		int study_begin_month = Integer.parseInt(study_begin_date.substring(5,7));
		int study_begin_day = Integer.parseInt(study_begin_date.substring(8));
		int maxDay = 0;
		// 홀수 월: 31일 
		// 짝수 월: 30일
		// 2월: 28일
		for(int i=1; i<totalWeek; i++) {
			
			if(study_begin_month == 1 || study_begin_month == 3 || study_begin_month == 5 ||
			   study_begin_month == 7 || study_begin_month == 9 || study_begin_month == 11) {
						
						maxDay = 31;
						
			}else if(study_begin_month == 4  || study_begin_month == 6 || study_begin_month == 8 ||
					 study_begin_month == 10 || study_begin_month == 12) {
						
						maxDay = 30;
						
			}else if(study_begin_month == 2) {
						
						maxDay = 28;
						
			}
			study_begin_day++;
			if(study_begin_day==maxDay) {
				study_begin_day=1;
				study_begin_month++;
				
				if(study_begin_month >= 12) {
					study_begin_month = 1;
					study_begin_year++;
				}
			}

		}
		String study_finish_date = null;
		
		if(study_begin_month < 10) {
			String study_begin_month_s = "0"+study_begin_month;
			study_finish_date = ""+study_begin_year+"-"+study_begin_month_s+"-"+study_begin_day;
		}

		if(study_begin_day < 10) {
			String study_begin_day_s = "0"+study_begin_day;
			study_finish_date = ""+study_begin_year+"-"+study_begin_month+"-"+study_begin_day_s;
		}
		
		if(study_begin_month < 10 && study_begin_day < 10) {
			String study_begin_month_s = "0"+study_begin_month;
			String study_begin_day_s = "0"+study_begin_day;
			
			study_finish_date = ""+study_begin_year+"-"+study_begin_month_s+"-"+study_begin_day_s;
		}
		
		return study_finish_date;
 	}
 	
 	/** 멤버별 활동 상태 + 진도율 계산 */
 	@Override
 	public List<StudyApplyDTO> getMemberProgress(int study_idx, int taskTotalCnt) {

		List<StudyApplyDTO> memberLists = l_dao.memberData(study_idx);
		int activeCount = 0;
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("study_idx", study_idx);
		int taskSubmitCount = 0;
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		LocalDateTime now = LocalDateTime.now();
		
			for(int i=0; i<memberLists.size(); i++){
				
				/** 참여자마다 제출한 과제 수 구하는 로직 */
				map.put("user_idx", memberLists.get(i).getUser_idx());
				taskSubmitCount = l_dao.taskSubmitCount(map);
				memberLists.get(i).setTaskSubmitCount(taskSubmitCount);
				
				/** 진도율 로직 */
				double progressDouble = ((double)taskSubmitCount/taskTotalCnt)*100;
				int progressInt = (int)progressDouble;
				
				memberLists.get(i).setProgress(progressInt);
				
				  String login = memberLists.get(i).getLogin_time();
				  String logout = memberLists.get(i).getLogout_time();
				  	// 승인됐지만 아직 접속하지 않은 멤버
				  	if (login == null && logout == null) {
					    memberLists.get(i).setActiveStatus("활동 대기중");
					    continue;
					}
			        // 현재 접속중	
			        if(login != null && logout == null){
			            memberLists.get(i).setActiveStatus("현재 활동중");
			            activeCount++;
			            continue;
			        }

			        // 마지막 활동 시간 계산
			        LocalDateTime logoutTime = LocalDateTime.parse(logout, formatter);
			        Duration duration = Duration.between(logoutTime, now);

			        long minutes = duration.toMinutes();

			        if(minutes < 60){
			            memberLists.get(i).setActiveStatus(minutes + "분 전 활동");
			        }else if(minutes < 1440){
			            memberLists.get(i).setActiveStatus((minutes / 60) + "시간 전 활동");
			        }else{
			            memberLists.get(i).setActiveStatus((minutes / 1440) + "일 전 활동");
			        }
			}
			if(!memberLists.isEmpty()){
			    memberLists.get(0).setActiveCount(activeCount);
			}
			
			return memberLists;
 	}
 	
 	/** 스터디 승인 */
 	@Override
 	public String studyApplyJoinProcess(int study_idx, int user_idx) {

 	    StudyDTO dto = l_dao.selectMemberNum(study_idx);

 	    int max = dto.getStudy_max_members();
 	    int current = dto.getStudy_current_members();

 	    if(current >= max) {
 	        return "현재 스터디 정원이 모두 찼습니다. 더 이상 가입이 불가능합니다.";
 	    }

 	    // 현재 인원 +1
 	    Map<String, Integer> map = new HashMap<>();
 	    map.put("study_current_members", current + 1);
 	    map.put("study_idx", study_idx);

 	    int memberResult = l_dao.currentMembersUpdate(map);

 	    // 신청 승인
 	    Map<String, Integer> map2 = new HashMap<>();
 	    map2.put("study_idx", study_idx);
 	    map2.put("user_idx", user_idx);

 	    int result = l_dao.studyApplicationApproved(map2);
 	    String msg = (result > 0 && memberResult > 0) ? "승인 완료" : "승인 실패";
 	    return msg;
 	}
 	
 	/** 스터디 거부 */
 	@Override
 	public String rejectStudyMember(int study_idx, int user_idx, String sa_reason) {
		Map map = new HashMap<>();
		map.put("study_idx", study_idx);
		map.put("user_idx", user_idx);
		map.put("sa_reason", sa_reason);
		
		int result = l_dao.studyApplicationReject(map);
		String msg = result > 0 ? "거절 완료" : "거절 실패";
		return msg;
 	}

 	/** 스터디 멤버 삭제 */
 	@Override
 	public String deleteStudyMemberProcess(int study_idx, int user_idx) {
 		
 		StudyDTO dto = l_dao.selectMemberNum(study_idx);
 		int current = dto.getStudy_current_members();
 		
		// 현재 인원수 다운
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("study_current_members", current - 1);
		map.put("study_idx", study_idx);
		int memberResult = l_dao.currentMembersUpdate(map);
		
		// 멤버 삭제
		Map<String, Integer> map2 = new HashMap<String, Integer>();
		map2.put("study_idx", study_idx);
		map2.put("user_idx", user_idx);
		int result = l_dao.deleteStudyMember(map2);
		
		String msg = (result > 0 && memberResult >0) ? "멤버 삭제 완료" : "멤버 삭제 실패";
 		
		return msg;
 	}
 	
 	/** 파일 업로드 관련 메서드 */
	public void fileCopy(MultipartFile upload, String path) {
		 try {
		      byte bytes[] = upload.getBytes();
		         
		      File f = new File(path+upload.getOriginalFilename());
		         
		      FileOutputStream fos = new FileOutputStream(f);
		         
		      fos.write(bytes);
		         
		      fos.close();
		 }catch(IOException e) {
		      e.printStackTrace();
		 }
	}
 
}
