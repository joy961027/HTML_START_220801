<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%
	//로직을 작성하자!!
	//드라이버 로드
	Class.forName("com.mysql.jdbc.Driver");
	//접속시도
	String url="jdbc:mysql://localhost/javastudy";
	String user ="root";
	String password="1234";
	//아래의 영역에서 이 변수들을 접근하게 하기 위함..(if문 밖으로 뺌)
	PreparedStatement pstmt = null; 
	ResultSet rs = null;


	Connection con =  DriverManager.getConnection(url,user,password);



	if(con== null){
		out.print("mysql 접속실패");
	}else{
			out.print("mysql 접속성공");
			//emp table 출력하기
			String sql="select * from emp";
			pstmt = con.prepareStatement(sql); //쿼리 수행 객체
			rs = pstmt.executeQuery(); // select문 수행

			/*out.print("<table border='1'>");
			while(rs.next()){
				out.print("<tr>");
				out.print("<td>"+ rs.getInt("empno") +"</td>");
				out.print("<td>"+ rs.getString("ename") +"</td>");
				out.print("<td>"+ rs.getString("job") +"</td>");
				out.print("<td>"+ rs.getInt("mgr") +"</td>");
				out.print("<td>"+ rs.getTimestamp("hiredate") +"</td>");
				out.print("<td>"+ rs.getInt("sal") +"</td>");
				out.print("<td>"+ rs.getInt("comm") +"</td>");
				out.print("<td>"+ rs.getInt("deptno") +"</td>");
				out.print("</tr>");
			}
			out.print("</table>");

		}
		out.print("<br>");
		if(con != null){
			con.close();
			}*/
	}
%>

<table width="800px" border="1px">
	<tr>
		<td>empno</td>
		<td>ename</td>
		<td>job</td>
		<td>mgr</td>
		<td>hiredate</td>
		<td>sal</td>
		<td>comm</td>
		<td>deptno</td>
	</tr>
<%while(rs.next()){%>
	<tr onMouseOver="this.style.background='yellow'" onMouseOut="this.style.background=''">
		<td><%=rs.getInt("empno")%></td>
		<td><%=rs.getString("ename")%></td>
		<td><%=rs.getString("job")%></td>
		<td><%=rs.getInt("mgr")%></td>
		<td><%=rs.getString("hiredate")%></td>
		<td><%=rs.getInt("sal")%></td>
		<td><%=rs.getInt("comm")%></td>
		<td><%=rs.getInt("deptno")%></td>
	</tr>
<%}%>
</table>
<%
if(rs !=null)rs.close();
if(pstmt !=null)pstmt.close();
if(con !=null)con.close();
%>