package com.koreait.db;

import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class SqlMapConfig {
	private static SqlSessionFactory sqlsession;
	
	static { //static블록 특징: 객체를 여러개 만들더래도 객체하나를 실행하면 그 이후엔 실행이 안됨
		try {
			String resource = "com/koreait/db/config.xml";
			Reader reader = Resources.getResourceAsReader(resource);
			sqlsession = new SqlSessionFactoryBuilder().build(reader);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public static SqlSessionFactory getSqlMapInstance() {
		return sqlsession;
	}
}
