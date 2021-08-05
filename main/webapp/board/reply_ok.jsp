<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	if(session.getAttribute("userid") == null){//세션에 있는 것을 getAttribute()로 userid란 값을 가져옴
%>
	<script>
		alert('로그인 후 이용하세요');
		location.href='../login.jsp';
	</script>
<%
	}else{
%>
<jsp:useBean id="reply" class="com.koreait.reply.ReplyDTO"/>  
<!--com.koreait.board 패키지 안에  ReplyDTO 클래스를 사용하는 reply객체를 생성(id는 replyDTO) -->

<jsp:useBean id="dao" class="com.koreait.reply.ReplyDAO"/>
<!-- com.koreait.board 패키지 안에 ReplyDAO 클래스를 사용하는 dao객체를 생성(id는 dao) -->
<%
	reply.setIdx(Integer.parseInt(String.valueOf(request.getParameter("b_idx")))); //뷰에서 댓글을 쓴걸 여기로 넘김
	reply.setUserid((String)session.getAttribute("userid"));
	
	//뷰에서 <p>태그안에서 사용자가 요청한 것은 request.getParameter로 받아와야함
	reply.setContent(String.valueOf(request.getParameter("re_content")));
	
	if (dao.reply_ok(reply) == 1) {
%>
	<script>
	alert('등록되었습니다');
	location.href='view.jsp?b_idx=<%=reply.getIdx()%>';
	</script>
<%
	}else{
%>
	<script>
	alert('등록실패');
	location.href='view.jsp?b_idx=<%=reply.getIdx()%>';
	</script>
<%
	}
}
%>