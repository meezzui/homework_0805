<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@page import="com.koreait.board.BoardDTO"%>
<%@page import="com.koreait.board.BoardDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>


<jsp:useBean id="board" class="com.koreait.board.BoardDTO"/>
<jsp:useBean id="dao" class="com.koreait.board.BoardDAO"/>
<jsp:useBean id="reply" class="com.koreait.reply.ReplyDTO"/>  
<jsp:useBean id="Replydao" class="com.koreait.reply.ReplyDAO"/>

<%
	request.setCharacterEncoding("UTF-8");
	
	Date nowTime = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd"); //형식을 바꿔주는 함수 SimpleDateFormat();
	
	
	
  
   String sql = "";
   int totalCount = 0;
   int pagePerCount = 10; //페이지당 글 개수 10개씩 보여줌
   int start =0; //시작 글 번호
   
   totalCount = dao.totalCount(); //totalCOunt는 이걸로 끝
   
   String pageNum = request.getParameter("pageNum"); //페이지 번호를 받음
   if(pageNum != null && !pageNum.equals("")){//페이지번호(값이)가 있으면
	   start = (Integer.parseInt(pageNum)-1)*pagePerCount;
   }else{ //페이지 번호가 없으면 0부터 10개씩 가져와라
	   pageNum = "1";
	   start = 0;
   }
   
  
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리스트</title>
</head>
<body>
   <h2>리스트</h2>
   <p>게시글 : <%=totalCount%>개</p>
   
   <table border="1" width="800">
      <tr>
         <th width="50">번호</th>
         <th width="300">제목</th>
         <th width="100">글쓴이</th>
         <th width="75">조회수</th>
         <th  width="200">날짜</th>
         <th  width="75">좋아요</th>
      </tr>
<%  

	List<BoardDTO> list = dao.pageNum(start, pagePerCount);
  	for(BoardDTO lists : list){
  	
      int idx= lists.getIdx();
      String replycnt_str ="";
 
  
         if(Replydao.replyNum(idx) > 0){
            replycnt_str = "["+Replydao.replyNum(idx)+"]";
         
      }
        
      
      
%>
      <tr>
         <td><%=lists.getIdx()%></td>
         <td><a href="./view.jsp?b_idx=<%=lists.getIdx()%>"><%=lists.getTitle()%></a><%=replycnt_str %>
<%
		if(lists.getRegdate().equals(sf.format(nowTime))){
%>
			<img width="20" height="15" src="new.png">
<% 			
		}
%>
          </td>
         <td><%=lists.getUserid()%></td>
         <td><%=lists.getHit()%></td>
         <td><%=lists.getRegdate()%></td>
         <td><%=lists.getLike()%></td>
      </tr>
<%
  	
  	}


	int pageNums = 0;
	if(totalCount % pagePerCount ==0){ //나눌때 나머지가 없으면
		pageNums = (totalCount / pagePerCount); 
	}else{//나머지가 있으면
		pageNums = (totalCount / pagePerCount) +1;
	}

%>
	<tr>
		<td colspan="6" align="center">
		<%
			for(int i=1; i<=pageNums; i++){
				out.print("<a href='list.jsp?pageNum="+i+"'>["+i+"]</a>");
			}
		%>
		</td>
	</tr>
   </table>
   
   
   <p><input type="button" value="글쓰기" onclick="location.href='write.jsp'"> <input type="button" value="메인" onclick="location.href='../login.jsp'"></p>
</body>
</html>






