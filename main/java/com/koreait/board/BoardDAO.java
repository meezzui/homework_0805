package com.koreait.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.koreait.db.Dbconn;
import com.koreait.db.SqlMapConfig;

public class BoardDAO {
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	String sql = "";
	
	SqlSessionFactory ssf = SqlMapConfig.getSqlMapInstance();
	SqlSession sqlsession;
	
	public BoardDAO() {
		sqlsession = ssf.openSession(true); // 설정 시 자동 커밋(sql이 자동반영)
		System.out.println("마이바티스 설정 성공!!");
	}
	
	 public int totalCount() { 
		 int totalCount =0;
		 totalCount = (Integer)sqlsession.selectOne("Board.totalCount");
		 return totalCount;
	 }
	
	 public List<BoardDTO> pageNum(int start, int pagePerCount){
		 HashMap<String, String> dataMap = new HashMap<String, String>();
		 dataMap.put("start", String.valueOf(start));
		 dataMap.put("pagePerCount", String.valueOf(pagePerCount));
		 return sqlsession.selectList("Board.pageNum",dataMap);
	 }


	 
	 public int write(BoardDTO board) {
		 HashMap<String, String> dataMap = new HashMap<String, String>();
		 dataMap.put("b_userid", board.getUserid());
		 dataMap.put("b_title", board.getTitle());
		 dataMap.put("b_content", board.getContent());
		 dataMap.put("b_file", board.getFile());
		 return sqlsession.insert("Board.write", dataMap);
	 }
	 
	 public int delete(BoardDTO board) {
		 HashMap<String, String> dataMap = new HashMap<String, String>();
		 dataMap.put("b_idx", String.valueOf(board.getIdx()));
		 return sqlsession.delete("Board.delete", dataMap);
		 }
	 
	
	 public BoardDTO like(BoardDTO board){
		  
		 HashMap<String, String> dataMap = new HashMap<String, String>();
		 dataMap.put("b_idx", String.valueOf(board.getIdx()));
		 sqlsession.update("Board.like", dataMap);
		 
		 dataMap = sqlsession.selectOne("Board.like_ok",dataMap);
		 if(dataMap != null) {
			 board.setLike(Integer.parseInt(String.valueOf(dataMap.get("b_like"))));
			 return board;
		 }
			return null;
			 
		   }
	   
	   public BoardDTO hit(BoardDTO board) {
		   HashMap<String, String> dataMap = new HashMap();
		      dataMap.put("b_idx", String.valueOf(board.getIdx()));
		      sqlsession.update("Board.hit", dataMap);
		      
		      dataMap = sqlsession.selectOne("Board.view", dataMap);
		      if (dataMap != null) {
		         board.setIdx(Integer.parseInt(String.valueOf(dataMap.get("b_idx"))));
		         board.setUserid(dataMap.get("b_userid"));
		         board.setTitle(dataMap.get("b_title"));
		         board.setContent(dataMap.get("b_content"));
		         board.setRegdate(String.valueOf(dataMap.get("b_regdate")));//java.time.LocalDateTime cannot be cast to java.lang.String -> string으로 바꿔줘야한다.
		         board.setLike(Integer.parseInt(String.valueOf(dataMap.get("b_like"))));
		         board.setHit(Integer.parseInt(String.valueOf(dataMap.get("b_hit"))));
		         board.setFile(dataMap.get("b_file"));
		         return board;
		      }
		      return null;
	   }
	 
	   
	   public BoardDTO edit(BoardDTO board) {
		   HashMap<String, String> dataMap = new HashMap<String, String>();
		   dataMap.put("b_idx", String.valueOf(board.getIdx()));
		   dataMap = sqlsession.selectOne("Board.edit", dataMap);
		   
		   if(dataMap != null) {
			   board.setTitle(dataMap.get("b_title"));
			   board.setContent(dataMap.get("b_content"));
			   board.setFile(dataMap.get("b_file"));
			   return board;
		   }
		   return null;
	   }
	   
	   public int edit_ok(BoardDTO board) {
		   HashMap<String, String> dataMap = new HashMap<String, String>();
		   if(board.getFile() != null && !board.getFile().equals("")) {
			   dataMap.put("b_idx", String.valueOf(board.getIdx()));
			   dataMap.put("b_title", board.getTitle());
			   dataMap.put("b_content", board.getContent());
			   dataMap.put("b_file", board.getFile());
			   return sqlsession.update("Board.edit_ok", dataMap);
		   }else{
			   dataMap.put("b_idx", String.valueOf(board.getIdx()));
			   dataMap.put("b_title", board.getTitle());
			   dataMap.put("b_content", board.getContent());
			   return sqlsession.update("Board.edit_ok1", dataMap);
		   }
	   }
	   
}
