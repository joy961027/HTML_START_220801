<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Document</title>
</head>
<body>
<%
	for(int i=1; i<=9; i++){
	out.print("2*1 = 2 <br>");
	}
	out.print("this is my first web application<br>");
	//자바 스탠다드의 문법이 적용되므로, 오라클을 연동해부자!!
	//sqlplus : 서버의주소/id/pass
	//우리의 오라클 서버에 접속시도
	String url="jdbc:oracle:thin:@localhost:1521:XE";
	String user="java";
	String password="1234";
	//방금 가져온 드라이버를 메모리에 로드!!
	Class.forName("oracle.jdbc.driver.OracleDriver"); //static 영역 클래스 로드
		
	//접속 
	Connection con =  DriverManager.getConnection(url,user,password);
	if(con==null){
		out.print("접속 실패");
	}else{
		out.print("접속 성공 ^^ <br>");
		//query문 수행하기
		PreparedStatement pstmt = null; // 인터페이스
		String sql = "select * from dept";
		pstmt = con.prepareStatement(sql); //이시점에 메모리에 올라옴
		//쿼리문 수행
		ResultSet rs = pstmt.executeQuery();
		out.print("<table border='1px'>");
		while(rs.next()){;//커서 한칸전진 
		//컬럼이 loc인 데이터 가져오기
		out.print("<tr>");
		out.print("<td>"+rs.getInt("DEPTNO")+"</td>");
		out.print("<td>"+rs.getString("DNAME")+"</td>");
		out.print("<td>"+rs.getString("LOC")+"</td>");
		out.print("</tr>");
		}
		out.print("</table>");
		
	}

	if(con != null){ // 접속 성공 했을때만
		con.close();
	}	
	

%>
</body>
</html>
