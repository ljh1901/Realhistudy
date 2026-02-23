package com.histudy.studycafe.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.histudy.studycafe.model.StudycafeReplyDAO;
import com.histudy.studycafe.model.StudycafeReplyDTO;
import com.histudy.studycafe.model.StudycafeReplyFileDTO;
import com.histudy.studycafe.model.StudycafeReplyJoinStudycafeReplyFileDTO;

public class StudycafeReplyServiceImple implements StudycafeReplyService {
	private StudycafeReplyDAO studycafeReplyDAO;

	public StudycafeReplyServiceImple(StudycafeReplyDAO studycafeReplyDAO) {
		super();
		this.studycafeReplyDAO = studycafeReplyDAO;
	}

	@Override
	public Map<String, Object> writeStudycafeReply(MultipartFile[] reviewFiles, String studycafe_reply,
			double studycafe_rating, int user_idx, int studycafe_idx) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>(); // JSON 객체
		System.out.println("댓글 내용:" + studycafe_reply);
		System.out.println("평점 후기: "+studycafe_rating);
		System.out.println("회원번호: "+user_idx);
		System.out.println("스터디 카페 번호: "+ studycafe_idx);
		map.put("user_idx", user_idx);
		map.put("studycafe_idx", studycafe_idx);
		map.put("studycafe_rating", studycafe_rating);
		if (studycafe_reply != null && !(studycafe_reply.equals(""))) {
			map.put("studycafe_reply", studycafe_reply);
		}
	
		
		List<StudycafeReplyFileDTO> replyFileLists = new ArrayList<StudycafeReplyFileDTO>();
		File f = new File("C:/Realhistudy/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/histudy/studycafe-reviewimg/");
		if (reviewFiles != null) {
			for (int i = 0; i < reviewFiles.length; i++) {
				copyFile(reviewFiles[i]); // 파일 복사
			}
		}
		if (f.isDirectory() && reviewFiles != null) {
			File[] files = f.listFiles();
			for (File temp : files) {
				for (int i = 0; i < reviewFiles.length; i++) {
					if (!reviewFiles[i].isEmpty()) {
						if (temp.isFile()) {
							System.out.println("실제 디렉터리에 있는 파일: " + temp.getName());
							System.out.println("업로드 된 파일: " + reviewFiles[i].getOriginalFilename());
							if (reviewFiles[i].getOriginalFilename().equals(temp.getName())) {
								String file_type = reviewFiles[i].getContentType();
								String file_path = temp.toString().substring(temp.toString().lastIndexOf("studycafe-reviewimg"));
								StudycafeReplyFileDTO fileList = new StudycafeReplyFileDTO(0, 0, file_path, file_type, i, null);
								replyFileLists.add(fileList);
								map.put("replyFileList", replyFileLists);
							}
						}
					}
				}
			}
		}
		int result=studycafeReplyDAO.writeStudycafeReply(map);
		if(result > 0) {
			return map;
		}else {
			throw new RuntimeException("리뷰 쓰기 실패");
		}
	}

	public void copyFile(MultipartFile reviewFiles) {
		String directoryReview = "C:/Realhistudy/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/histudy/studycafe-reviewimg/";
		try {
			// 복사 용지 선택
			byte[] bytes = reviewFiles.getBytes();
			// 1. 빈 복사 용지 만들기
			File file = new File(directoryReview + reviewFiles.getOriginalFilename());
			// 2. 복사기 생성
			FileOutputStream fos = new FileOutputStream(file);

			// FileUtils.copyFile(file, fos);
			// reviewFiles.transferTo(file);

			// 3. 복사하기
			fos.write(bytes);

			// 4. 복사기 종료
			fos.close();

		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	@Override
	public List<StudycafeReplyDTO> replyList(int studycafe_idx) {

	    List<StudycafeReplyJoinStudycafeReplyFileDTO> joinList = studycafeReplyDAO.replyList(studycafe_idx);

	    Map<Integer, StudycafeReplyDTO> replyMap = new HashMap<>();
	    for (StudycafeReplyJoinStudycafeReplyFileDTO row : joinList) {

	        int reviewIdx = row.getReview_idx();

	        if (!replyMap.containsKey(reviewIdx)) {
	            StudycafeReplyDTO replyDto = new StudycafeReplyDTO(
	            		row.getUser_name(),
	                    reviewIdx,
	                    row.getUser_idx(),
	                    row.getStudycafe_idx(),
	                    row.getStudycafe_reply(),
	                    row.getStudycafe_rating(),
	                    row.getCreated_at(),
	                    new ArrayList<>()
	            );

	            replyMap.put(reviewIdx, replyDto);
	        }

	        if (row.getReview_file_idx() != 0) {
	            StudycafeReplyFileDTO fileDto = new StudycafeReplyFileDTO(
	                    row.getReview_file_idx(),
	                    reviewIdx,
	                    row.getFile_path(),
	                    row.getFile_type(),
	                    row.getFile_order(),
	                    row.getCreated_at()
	            );
	            replyMap.get(reviewIdx).getFileList().add(fileDto);
	        }
	    }

	    return new ArrayList<>(replyMap.values());
	}
	@Override
	public double studycafeAvgRating(int studycafe_idx) {
		double avgRating = studycafeReplyDAO.studycafeAvgRating(studycafe_idx);
		return avgRating;
	}
	
	@Override
	public int studycafeReviewDelete(int studycafe_idx, int review_idx, int user_idx) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("studycafe_idx", studycafe_idx);
		map.put("review_idx", review_idx);
		map.put("user_idx", user_idx);
		int result = studycafeReplyDAO.studycafeReviewDelete(map);
		return result;
	}
	@Override
	public int studycafeReplyValid(int user_idx) {
		int result = studycafeReplyDAO.studycafeReplyValid(user_idx);
		return result;
	}
	@Override
	public int studycafeReplyWritten(int user_idx) {
		int result = studycafeReplyDAO.studycafeReplyWritten(user_idx);
		return result;
	}

}
