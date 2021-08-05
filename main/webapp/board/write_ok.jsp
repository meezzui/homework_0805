<jsp:useBean id="boardDTO" class="com.koreait.board.BoardDTO"/>
<jsp:useBean id="boardDAO" class="com.koreait.board.BoardDAO"/>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%
   String b_title = "";
   request.setCharacterEncoding("UTF-8");
   if (session.getAttribute("userid") == null) {
%>
<script>
   alert('로그인 후 이용하세요');
   location.href = '../login.jsp';
</script>
<%
   } else {
      String uploadPath = request.getRealPath("/upload");
      System.out.println(uploadPath);
      int size = 1024 * 1024 * 10;
      

   try{
      MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());
      boardDTO.setTitle(multi.getParameter("b_title"));
      boardDTO.setContent(multi.getParameter("b_content"));
      boardDTO.setFile(multi.getFilesystemName("b_file"));
      System.out.println(multi.getFilesystemName("b_file"));
      System.out.println(boardDTO.getFile());
      
   }catch(Exception e){
      e.printStackTrace();
   }
     boardDTO.setUserid((String) session.getAttribute("userid"));
      if (boardDAO.write(boardDTO) == 1) {
%>
<script>
   alert('등록되었습니다.');
   location.href = 'list.jsp';
</script>

<%
   } else {
%>
<script>
   alert('등록실패');
   history.back();
</script>
<%
}
   }
%>