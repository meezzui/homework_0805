package com.koreait.reply;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.koreait.reply.ReplyDTO;
import com.koreait.db.Dbconn;
import com.koreait.db.SqlMapConfig;

public class ReplyDAO {
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	String sql = "";
	
	SqlSessionFactory ssf = SqlMapConfig.getSqlMapInstance();
	SqlSession sqlsession;
	
	public ReplyDAO() {
		sqlsession = ssf.openSession(true); // 설정 시 자동 커밋(sql이 자동반영)
		System.out.println("마이바티스 설정 성공!!");
	}
	
	
	public int replyNum(int idx){
		
		HashMap<String, String> dataMap = new HashMap();
	      dataMap.put("re_boardidx", String.valueOf(idx));
	      
		return Integer.parseInt(String.valueOf(sqlsession.selectOne("Reply.replyNum", dataMap)));
			
	}

	 public List<ReplyDTO> reply_view(String idx) {
		   return sqlsession.selectList("Reply.reply_view", idx); //selectList는 while문을 쓰지 않아도 알아서 데이터가 차곡차곡 들어감.
	   }
	 
	 public int reply_ok(ReplyDTO reply) {
		 HashMap<String, String> dataMap = new HashMap();
		 dataMap.put("re_userid", reply.getUserid());
		 dataMap.put("re_content", reply.getContent());
		 dataMap.put("re_boardidx", String.valueOf(reply.getIdx())); //글 번로랑 같아야함. 글 번호를 가져오는 거임
		 return sqlsession.insert("Reply.reply_ok", dataMap);
		}
		
		public int reply_del(ReplyDTO reply) {
			HashMap<String, String> dataMap = new HashMap<String, String>();
			 dataMap.put("re_idx", String.valueOf(reply.getIdx()));
			 return sqlsession.delete("Reply.reply_delete", dataMap);
		}
}
