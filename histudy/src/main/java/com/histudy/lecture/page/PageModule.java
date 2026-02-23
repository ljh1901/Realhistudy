package com.histudy.lecture.page;

public class PageModule {
	public static String makePage(String pagename,int totalCnt,int listSize,int pageSize, int cp) {
		StringBuffer sb =new StringBuffer();

		//총페이지
		int totalPage=(totalCnt/listSize+1);
		
		if(totalCnt%listSize==0)totalPage--;
		int userGroup=cp/pageSize;
		if(cp%pageSize==0)userGroup--;
		
		//왼쪽으로화살표그려지는 시점
		if(userGroup!=0){
			sb.append("<a href='");
			sb.append(pagename);
			sb.append("?cp=");
			int temp=(userGroup-1)*pageSize+pageSize;
			sb.append(temp);
			sb.append("'>");
			sb.append("<img src='");
			sb.append("/histudy/main-img/prev.png'>");
			sb.append("</a>");
		}
		
		for(int i=userGroup*pageSize+1; i<=userGroup*pageSize+pageSize; i++){
			sb.append("&nbsp;&nbsp;<a href='");
			sb.append(pagename);
			sb.append("?cp=");
			sb.append(i);
			sb.append("'>");
			sb.append(i);
			sb.append("</a>&nbsp;&nbsp;");
			
			if(i==totalPage){
				break;
			}
		}
		//오른쪽으로가는화살표
		if(userGroup!=(totalPage/pageSize)-(totalPage%pageSize==0?1:0)){
			sb.append("<a href='");
			sb.append(pagename);
			sb.append("?cp=");
			int temp=(userGroup+1)*pageSize+1;
			sb.append(temp);
			sb.append("'>");
			sb.append("<img src='");
			sb.append("/histudy/main-img/next.png'>");
			sb.append("</a>");
		}
		return sb.toString();
	}
}