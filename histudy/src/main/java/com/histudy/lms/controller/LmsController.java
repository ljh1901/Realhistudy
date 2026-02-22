package com.histudy.lms.controller;

import java.util.*;
import java.text.SimpleDateFormat;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.histudy.lms.model.LmsDTO;
import com.histudy.lms.model.LmsSubmitDTO;
import com.histudy.lms.service.LmsService;
import com.histudy.lms.service.LmsSubmitService;
import com.histudy.notifications.model.NotificationsDTO;
import com.histudy.notifications.service.NotificationsServiceImple;
import com.histudy.study.model.StudyApplyDTO;
import com.histudy.study.model.StudyDTO;

@Controller
public class LmsController {

	@Autowired
	private LmsService ls;

	@Autowired
	private LmsSubmitService lss;
	
	@Autowired
	private NotificationsServiceImple ns;

	/**
	 * LMS 페이지 접속 관련 메서드
	 * - 로그인 여부 확인 
	 * - 개설자/참여자 여부 확인 
	 * - 스터디 정보, 과제, 진행률, 완료/진행 상태 계산
	 * - 대기 과제 및 완료된 과제 정보 추가
	 */
	@GetMapping("/lms.do")
	public ModelAndView lmsPage(HttpSession session) {

		ModelAndView mav = new ModelAndView();
		Integer user_idx = (Integer) session.getAttribute("user_idx");

		// 로그인 검증
		if (user_idx == null || user_idx == 0) {
			mav.addObject("msg", "로그인 후 접속 가능합니다.");
			mav.addObject("goPage", "index.do");
			mav.setViewName("lms/lmsMsg");
			return mav;
		} else {
			/** 1. 로그인된 사용자가 개설자인지 체크 */
			List<StudyDTO> s_list = ls.studyCreatorCheck(user_idx);

			// 개설자일 경우, 각 스터디의 과제 수와 진행률 계산
			StudyDTO dto = new StudyDTO();
			for (int i = 0; i < s_list.size(); i++) {

				int study_idx = s_list.get(i).getStudy_idx();

				// 개설자가 등록한 과제 수 조회
				dto.setTaskCount(ls.myStudyInTaskCount(study_idx));
				s_list.get(i).setTaskCount(dto.getTaskCount());

				// 스터디 진행 주차 및 진행률 계산
				try {
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					Date study_begin_date = sdf.parse(s_list.get(i).getStudy_begin_date().substring(0, 10));
					Date today = new Date();

					long days = (today.getTime() - study_begin_date.getTime()) / (1000 * 60 * 60 * 24);
					int currentWeek = (int) (days / 7) + 1;
					if (currentWeek < 1) {
						currentWeek = 1;
					}
					
					// totalWeek 이상 못 올라가게 제한
					int totalWeek = s_list.get(i).getStudy_total_weeks();
					if(currentWeek > totalWeek) {
					    currentWeek = totalWeek;
					}
					
					// 진행률 계산 시 100% 초과 방지
					double progressDouble = ((double) currentWeek / totalWeek) * 100;
					if(progressDouble > 100) {
					    progressDouble = 100;
					}
					int progressInt = (int) progressDouble;
					s_list.get(i).setStudyProgress(progressInt);

					// 스터디 진행 상태 업데이트
					if (days >= 0 && currentWeek <= s_list.get(i).getStudy_total_weeks()
							&& s_list.get(i).getStudy_status() == 0) {

						Map<String, Integer> map = new HashMap<>();
						map.put("study_idx", study_idx);
						map.put("study_status", 1);

						ls.studyStatusUpdate(map);
						s_list.get(i).setStudy_status(1);
					}

					// 스터디 완료 처리 - 모집중: 0 / 진행중: 1 / 완료됨: 2
					if (currentWeek > s_list.get(i).getStudy_total_weeks() && s_list.get(i).getStudy_status() != 2) {
						currentWeek = s_list.get(i).getStudy_total_weeks();
						Map<String, Integer> map = new HashMap<String, Integer>();
						map.put("study_idx", study_idx);
						map.put("study_status", 2);
						ls.studyStatusUpdate(map);
					}

					s_list.get(i).setStudy_current_weeks(currentWeek);
				} catch (Exception e) {
					e.printStackTrace();
				}

			}

			// [개설자] 관련 데이터 JSP 전달
			if (!s_list.isEmpty()) {

				List<LmsDTO> C_task_list = ls.selectStudyCreatorTask(user_idx); // 개설자라면 자신이 등록한 과제 받아오기

				if (!C_task_list.isEmpty()) {
					mav.addObject("C_task_list", C_task_list); // 등록한 과제 리스트
				}

				mav.addObject("s_list", s_list); // 개설 스터디 리스트
				mav.setViewName("lms/lms");
			}

			/** 2. 로그인된 사용자가 참여자인지 체크 */
			List<StudyApplyDTO> sa_list = ls.studyApplyCheck(user_idx);
			if (!sa_list.isEmpty()) {
				List<StudyDTO> approved_list = new ArrayList<>();
				for (int i = 0; i < sa_list.size(); i++) {

					int study_idx = sa_list.get(i).getStudy_idx();
					List<StudyDTO> temp = ls.studyApproved(study_idx);
					approved_list.addAll(temp);

				}

				// 참여자 스터디 과제 수 조회
				Map<String, Integer> map = new HashMap<String, Integer>();
				map.put("user_idx", user_idx);
				StudyDTO dto2 = new StudyDTO();
				for (int i = 0; i < approved_list.size(); i++) {
					map.put("study_idx", approved_list.get(i).getStudy_idx());
					dto2.setTaskCount2(ls.memberStudyInTaskCount(map));
					approved_list.get(i).setTaskCount2(dto2.getTaskCount2());

					// 진행 주차 및 진행률 계산
					try {
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						Date study_begin_date = sdf.parse(approved_list.get(i).getStudy_begin_date().substring(0, 10));
						Date today = new Date();

						long days = (today.getTime() - study_begin_date.getTime()) / (1000 * 60 * 60 * 24);
						int currentWeek = (int) (days / 7) + 1;
						if (currentWeek < 1)
							currentWeek = 1;
						
						int totalWeek = approved_list.get(i).getStudy_total_weeks();
						// totalWeek 이상 못 올라가게 제한
						if(currentWeek > totalWeek) {
						    currentWeek = totalWeek;
						}
						
						// 진행률 계산 시 100% 초과 방지
						double progressDouble = ((double) currentWeek / totalWeek) * 100;
						if(progressDouble > 100) {
						    progressDouble = 100;
						}
						int progressInt = (int) progressDouble;
						approved_list.get(i).setStudyProgress(progressInt);
						approved_list.get(i).setStudy_current_weeks(currentWeek);

						// 스터디 상태 업데이트
						if (days >= 0 && currentWeek <= totalWeek && approved_list.get(i).getStudy_status() == 0) {
							Map<String, Integer> statusMap = new HashMap<>();
							statusMap.put("study_idx", approved_list.get(i).getStudy_idx());
							statusMap.put("study_status", 1);
							ls.studyStatusUpdate(statusMap);
							approved_list.get(i).setStudy_status(1);
						}
						if (currentWeek > totalWeek && approved_list.get(i).getStudy_status() != 2) {
							Map<String, Integer> statusMap = new HashMap<>();
							statusMap.put("study_idx", approved_list.get(i).getStudy_idx());
							statusMap.put("study_status", 2);
							ls.studyStatusUpdate(statusMap);
							approved_list.get(i).setStudy_status(2);
							currentWeek = totalWeek;
							approved_list.get(i).setStudy_current_weeks(currentWeek);
						}
					} catch (Exception e) {
						e.printStackTrace();
					}

					List<LmsDTO> A_task_list = ls.selectStudyApprovedTask(user_idx);
					if (!A_task_list.isEmpty()) {
						mav.addObject("A_task_list", A_task_list); // 참여자 과제 리스트
					}

				}
				mav.addObject("approved_List", approved_list); // 참여 스터디 리스트
			}
			// 개설자도 아니고 참여자도 아닌 경우 안내
			if (s_list.isEmpty() && sa_list.isEmpty()) {
				mav.addObject("msg", "스터디에 참여해보세요!");
				mav.setViewName("study/studyMsg");
				return mav;
			}

			// 로그인한 사용자가 참여중인 총 스터디 갯수
			mav.addObject("studyCount", s_list.size() + sa_list.size());

			// 대기 중인 과제 수
			int waitTaskCount = ls.waitTaskCount(user_idx);
			mav.addObject("waitTaskCount", waitTaskCount);

			// 제출 완료된 과제 수
			int taskSubmitOkCount = ls.taskSubmitOkCount(user_idx);
			mav.addObject("taskSubmitOkCount", taskSubmitOkCount);

			// 완료된 스터디 리스트
			List<StudyDTO> finishStudyList = ls.finishStudy(user_idx);
			mav.addObject("finishStudyList", finishStudyList);
			mav.addObject("finishStudyCount", finishStudyList.size());
			mav.setViewName("lms/lms");
		}

		return mav;
	}

	/** 과제 등록 페이지 접속 관련 메서드 */
	@GetMapping("/taskInsertForm.do")
	public ModelAndView taskInsertForm(HttpSession session) {

		Integer user_idx = (Integer) session.getAttribute("user_idx");

		// 과제 등록 페이지에서 내가 개설한 스터디의 목록을 보내서 스터디를 선택하고 과제 등록을 할 수 있게 하기 위함.
		List<StudyDTO> lists = ls.studyCreatorCheck(user_idx);

		ModelAndView mav = new ModelAndView();
		mav.addObject("studyList", lists);
		mav.setViewName("lms/taskInsert");
		return mav;
	}

	/** 과제 등록 관련 메서드 */
	@PostMapping("/taskInsert.do")
	public ModelAndView taskInsertSubmit(LmsDTO dto, MultipartFile prve_a_fname, HttpSession session) {

		String msg = ls.insertTaskProcess(dto, prve_a_fname, session);

		ModelAndView mav = new ModelAndView();

		mav.addObject("msg", msg);
		mav.addObject("goPage", "lms.do");
		mav.setViewName("lms/lmsMsg");
		return mav;
	}

	/** 과제 제출 페이지 접속 관련 메서드 */
	@GetMapping("/taskSubmit.do")
	public ModelAndView goTaskSubmitPage(@RequestParam(value = "a_idx", defaultValue = "0") int a_idx,
			@RequestParam(value = "study_title", defaultValue = "0") String study_title, HttpSession session) {

		ModelAndView mav = new ModelAndView();

		LmsDTO dto = ls.selectTask(a_idx);

		mav.addObject("taskData", dto);
		mav.addObject("study_title", study_title);
		mav.setViewName("lms/taskSubmit");
		return mav;
	}

	/** 과제 제출 관련 메서드 */
	@PostMapping("/taskSubmitOk.do")
	public ModelAndView taskSubmitOk(LmsSubmitDTO dto, MultipartFile prve_as_fname, HttpSession session) {

		ModelAndView mav = new ModelAndView();

		int user_idx = (Integer) session.getAttribute("user_idx");
		dto.setUser_idx(user_idx);

		// 서비스 호출
		String msg = lss.submitTaskProcess(dto, prve_as_fname);

		mav.addObject("msg", msg);
		mav.addObject("goPage", "lms.do");
		mav.setViewName("lms/lmsMsg");
		return mav;
	}

	/** 등록한 과제 수정 페이지 이동 관련 메서드 */
	@GetMapping("/taskInsertUpdate.do")
	public ModelAndView taskInsertUpdate(@RequestParam(value = "a_idx") int a_idx,
			@RequestParam(value = "study_title") String study_title) {

		LmsDTO dto = ls.selectTask(a_idx);

		dto.setA_idx(a_idx); // 과제 수정 처리 관련 메서드에서 dto에 매핑이 되야댐

		ModelAndView mav = new ModelAndView();
		mav.addObject("study_title", study_title);
		mav.addObject("dto", dto);
		mav.setViewName("lms/taskInsertUpdate");
		return mav;

	}

	/** 등록한 과제 수정 처리 관련 메서드 */
	@PostMapping("/taskInsertUpdateSubmit.do")
	public ModelAndView taskInsertUpdateSubmit(LmsDTO dto, MultipartFile prve_a_fname, HttpSession session) {

		ModelAndView mav = new ModelAndView();

		int user_idx = (Integer) session.getAttribute("user_idx");
		dto.setUser_idx(user_idx);

		// 서비스 호출
		String msg = ls.updateTaskProcess(dto, prve_a_fname);

		mav.addObject("msg", msg);
		mav.addObject("goPage", "lms.do");
		mav.setViewName("lms/lmsMsg");

		return mav;

	}

	/** 제출한 과제 수정 페이지 이동 관련 메서드 */
	@GetMapping("/taskSubmitUpdate.do")
	public ModelAndView taskSubmitUpdate(@RequestParam(value = "a_idx") int a_idx,
			@RequestParam(value = "study_title") String study_title) {

		LmsDTO lmsDto = ls.selectTask(a_idx);
		LmsSubmitDTO lmsSubmitDto = lss.selectAssignmentSubmit(a_idx);

		ModelAndView mav = new ModelAndView();
		mav.addObject("study_title", study_title);
		mav.addObject("lmsDto", lmsDto);
		mav.addObject("lmsSubmitDto", lmsSubmitDto);
		mav.setViewName("lms/taskSubmitUpdate");
		return mav;
	}

	/** 제출한 과제 수정 처리 관련 메서드 */
	@PostMapping("/taskSubmitUpdateOk.do")
	public ModelAndView taskSubmitUpdateOk(LmsSubmitDTO dto, MultipartFile prve_as_fname, HttpSession session) {
		ModelAndView mav = new ModelAndView();

		// 서비스 호출
		String msg = lss.updateTaskSubmitProcess(dto, prve_as_fname);

		mav.addObject("msg", msg);
		mav.addObject("goPage", "lms.do");
		mav.setViewName("lms/lmsMsg");
		return mav;
	}

	/** 멤버 관리 페이지 이동 관련 메서드 */
	@GetMapping("/memberManagement.do")
	public ModelAndView memberManagement(@RequestParam(value = "study_idx", defaultValue = "0") int study_idx) {

		ModelAndView mav = new ModelAndView();

		StudyDTO studyDto = ls.selectStudyData(study_idx);
		String study_begin_date = studyDto.getStudy_begin_date().substring(0, 10); // 스터디 시작일
		int study_total_weeks = studyDto.getStudy_total_weeks(); // 스터디 진행 주차

		/** 스터디 종료일 계산 */
		String study_finish_date = ls.calculateStudyFinishDate(study_begin_date, study_total_weeks);

		/** 총 과제수 */
		int taskTotalCnt = ls.taskTotalCount(study_idx);

		/** 멤버별 활동 상태 + 진도율 계산 */ // 다시
		List<StudyApplyDTO> memberLists = ls.getMemberProgress(study_idx, taskTotalCnt);

		// 가입 대기 수
		List<StudyApplyDTO> list = ls.studyApplicationUser(study_idx);

		// 리더 정보 보내기
		StudyDTO creatorData = ls.studyCreatorData(study_idx);

		// 현재 인원 수
		StudyDTO memberCount = ls.selectMemberNum(study_idx);

		mav.addObject("taskTotalCnt", taskTotalCnt);
		mav.addObject("creatorData", creatorData);
		mav.addObject("pendingCount", list.size());
		mav.addObject("studyIdx", study_idx);
		mav.addObject("memberLists", memberLists);
		mav.addObject("memberCount", memberCount.getStudy_current_members());
		mav.addObject("study_finish_date", study_finish_date);
		mav.addObject("studyDto", studyDto);
		mav.setViewName("lms/memberManagement");
		return mav;
	}

	/** 스터디 승인 */
	@GetMapping("/studyApplyJoin.do")
	public ModelAndView studyApplyJoin(@RequestParam(value = "study_idx", defaultValue = "0") int study_idx,
			@RequestParam(value = "user_idx", defaultValue = "0") int user_idx) {

		ModelAndView mav = new ModelAndView();

		String msg = ls.studyApplyJoinProcess(study_idx, user_idx);

		mav.addObject("msg", msg);
		mav.addObject("goPage", "memberManagement.do?study_idx=" + study_idx);
		mav.setViewName("lms/lmsMsg");

		return mav;

	}

	/** 스터디 거부 */
	@GetMapping("/studyApplyReject.do")
	public ModelAndView studyApplyReject(@RequestParam(value = "study_idx", defaultValue = "0") int study_idx,
			@RequestParam(value = "user_idx", defaultValue = "0") int user_idx,
			@RequestParam(value = "sa_reason", defaultValue = "0") String sa_reason) {

		String msg = ls.rejectStudyMember(study_idx, user_idx, sa_reason);

		ModelAndView mav = new ModelAndView();
		mav.addObject("msg", msg);
		mav.addObject("goPage", "memberManagement.do?study_idx=" + study_idx);
		mav.setViewName("lms/lmsMsg");
		return mav;

	}

	/** 스터디 멤버 삭제 */
	@GetMapping("/studyMemberDelete.do")
	public ModelAndView deleteStudyMember(@RequestParam(value = "study_idx", defaultValue = "0") int study_idx,
			@RequestParam(value = "user_idx", defaultValue = "0") int user_idx) {

		String msg = ls.deleteStudyMemberProcess(study_idx, user_idx);

		ModelAndView mav = new ModelAndView();
		mav.addObject("msg", msg);
		mav.addObject("goPage", "memberManagement.do?study_idx=" + study_idx);
		mav.setViewName("lms/lmsMsg");
		return mav;
	}
	
	/** 스터디 리더가 멤버에게 알림 전송 */
	@GetMapping("/sendNotice.do")
	public ModelAndView sendNotice(
			@RequestParam(value="member_idx", defaultValue = "0")int member_idx,
			@RequestParam(value="study_idx", defaultValue = "0")int study_idx,
			@RequestParam(value="noticeContent", defaultValue = "0")String noticeContent,
			@RequestParam(value="study_title", defaultValue = "0")String study_title,
			HttpSession session) {
		
		int senderIdx = (Integer)session.getAttribute("user_idx");
		
		NotificationsDTO n_dto = new NotificationsDTO();
		
		n_dto.setN_type("leaderMsg");
		n_dto.setN_content(noticeContent);
		n_dto.setN_sender_idx(senderIdx);
		n_dto.setN_title("["+study_title+"]");	
		n_dto.setN_read("안읽음");
		n_dto.setUser_idx(member_idx);
		
		int result = ns.sendNotice(n_dto);
		String msg = result>0?"알림 전송 완료":"알림 전송 중 에러발생";
		ModelAndView mav = new ModelAndView();
		mav.addObject("msg", msg);
		mav.addObject("goPage", "memberManagement.do?study_idx="+study_idx);
		mav.setViewName("lms/lmsMsg");
		return mav;
		
	}
}
