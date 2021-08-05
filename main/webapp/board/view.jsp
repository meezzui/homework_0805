<%@page import="com.koreait.reply.ReplyDTO"%>
<%@page import="com.koreait.board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="reply" class="com.koreait.reply.ReplyDTO"/>  
<!--com.koreait.board 패키지 안에  ReplyDTO 클래스를 사용하는 reply객체를 생성(id는 replyDTO) -->
<jsp:useBean id="Replydao" class="com.koreait.reply.ReplyDAO"/>
<!-- com.koreait.board 패키지 안에 ReplyDAO 클래스를 사용하는 dao객체를 생성(id는 dao) -->
<jsp:useBean id="board" class="com.koreait.board.BoardDTO"/>
<jsp:useBean id="dao" class="com.koreait.board.BoardDAO"/>

<%
	board.setIdx(Integer.parseInt(String.valueOf(request.getParameter("b_idx")))); 
	//request.getParameter: 사용자가 작성한 idx값을 가져옴(바로 직전인 것에서만 받아올 수 있음)
	//String.valueOf : 문자열로 바꿔주는 건데 초기값이 null로 되어있어서 자동으로 값이 없으면 null이 들어감.
	//b_idx는 리스트의 <a href="./view.jsp?b_idx=<%=b_idx%
	//"> 에서 b_idx(파란색)의 값을 가져옴
	
	String b_userid = "";
	String b_title = "";
	String b_content = "";
	String b_regdate = "";
	String b_file = "";
	int b_like = 0;
	int b_hit = 0;	

	if(dao.hit(board) != null){ //BoardDAO에서 set해준 값들을 가져옴(메소드를 실행)
		b_userid = board.getUserid();
		b_title = board.getTitle();
		b_content = board.getContent();
		b_regdate = board.getRegdate();
		b_like = board.getLike();
		b_hit = board.getHit();
		b_file = board.getFile();
	}
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글보기</title>
<script>
	function like(){
		const xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function(){
			if(xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200){
				document.getElementById('like').innerHTML = xhr.responseText;
			}
		}
		xhr.open('GET', './like_ok.jsp?b_idx=<%=board.getIdx()%>', true);
		xhr.send();
	}
</script>
</head>
<body>
	<h2>글보기</h2>
	<table border="1" width="800">
		<tr>
			<td>제목</td><td><%=b_title%></td>
		</tr>
		<tr>
			<td>날짜</td><td><%=b_regdate%></td>
		</tr>
		<tr>
			<td>작성자</td><td><%=b_userid%></td>
		</tr>
		<tr>
			<td>조회수</td><td><%=b_hit%></td>
		</tr>
		<tr>
			<td>좋아요</td><td><span id="like"><%=b_like%></span></td>
		</tr>
		<tr>
			<td>내용</td><td><%=b_content%></td>
		</tr>
		<tr>
			<td>파일</td>
			<td>
				<%
					if(b_file != null && !b_file.equals("")){
						out.println("첨부파일");
						out.println("<img src='../upload/"+b_file+"' alt='첨부파일' width='150'>");
					}
				%>
			</td>
		</tr>
		<tr>
			<td colspan="2">
<%
	if(b_userid.equals((String)session.getAttribute("userid"))){
%>
		<input type="button" value="수정" onclick="location.href='./edit.jsp?b_idx=<%=board.getIdx()%>'"> 
		<input type="button" value="삭제" onclick="location.href='./delete.jsp?b_idx=<%=board.getIdx()%>'">
<%
	}	
%>		
			<input type="button" value="좋아요" onclick="like()">
			<input type="button" value="리스트" onclick="location.href='./list.jsp'">
			</td>
		</tr>
	</table>
	<hr/>
	<form method="post" action="reply_ok.jsp">
		<input type="hidden" name="b_idx" value="<%=board.getIdx()%>">
		<p><%=session.getAttribute("userid")%> : <input type="text" size="40" name="re_content"> <input type="submit" value="확인"></p>
	</form>
	<hr/>
		<% 
		String idx = String.valueOf(board.getIdx());
		System.out.println(idx);
		List<ReplyDTO> list = Replydao.reply_view(idx); 
			for(int i=0; i<list.size(); i++){
			System.out.println(list.get(i).getUserid());
		%>
		<p><%=list.get(i).getUserid()%> : <%=list.get(i).getContent()%> ( <%=list.get(i).getRegdate()%> ) 
		
<%
	if(list.get(i).getUserid().equals((String)session.getAttribute("userid"))){
		
%>
		<input type="button" value="삭제" onclick="location.href='reply_del.jsp?re_idx=<%=list.get(i).getIdx()%>'">
		
<%
	
		
%>		
		</p>
<%
			}
		}
%>
</body>
</html>