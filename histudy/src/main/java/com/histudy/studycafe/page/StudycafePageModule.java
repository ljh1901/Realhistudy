package com.histudy.studycafe.page;

public class StudycafePageModule {
	public static String studycafePageAlgorithm(int totalCount, int currentPage, int listSize, int pageSize, String url, String region) {
		StringBuilder sb = new StringBuilder();
		int totalPage = (int) Math.ceil((double)totalCount/listSize); // 전체 페이지 구하기
		int userGroup = currentPage/listSize; // 유저 그룹 구하기
		if(currentPage % listSize == 0) {
			userGroup--;
		}
		// userGroup = 0
		if(userGroup !=0) {
			sb.append("<a href='");
			sb.append(url);
			sb.append("?currentPage=");
			sb.append((userGroup-1)*pageSize+pageSize);
			sb.append("'>");
			sb.append("<img src='");
			sb.append("/histudy/main-img/prev.png'>");
			sb.append("</a>");
		}
		for(int i=1; i <=totalPage; i++) {
			if(i > totalPage) {
				break;
			}
			sb.append("<a href='");
			sb.append(url);
			sb.append("?currentPage=");
			sb.append(i);
			sb.append("&region=");
			sb.append(region);
			sb.append("'>");
			sb.append(i);
			sb.append("</a>");
		}
		if(userGroup != totalPage/listSize - (totalPage%listSize == 0? 1:0)) {
			sb.append("<a href='");
			sb.append(url);
			sb.append("?currentPage=");
			sb.append((userGroup+1)*pageSize+pageSize+1);
			sb.append("'>");
			sb.append("<img src='");
			sb.append("/histudy/main-img/next.png'>");
			sb.append("</a>");
		}
		return sb.toString();
	}
}
