<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.koreait.db.Dbconn"%>
<%
	if(session.getAttribute("userid") == null){
%>

	<script>
		alert('로그인 후 이용하세요');
		location.href='../login.jsp';
	</script>
<%
	}else{
		
%>
<jsp:useBean id="reply" class="com.koreait.reply.ReplyDTO"/>
<jsp:useBean id="Replydao" class="com.koreait.reply.ReplyDAO"/>
<jsp:useBean id="board" class="com.koreait.board.BoardDTO"/>
<jsp:useBean id="dao" class="com.koreait.board.BoardDAO"/>


<%
		reply.setIdx(Integer.parseInt(request.getParameter("re_idx")));
	
	if(Replydao.reply_del(reply) ==1){
%>
	<script>
	alert('삭제되었습니다');
	location.href='list.jsp';
	</script>
<%
	}

}
%>