<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%! 
	String url ="jdbc:mysql://localhost:3306/javastudy?useUnicod=true&characterEncoding=utf8";
	String user = "root";
	String pass = "1234";
	//클래스의 멤버변수는 컴파일러에 의해 자동 초기화된다. 따라서 숫자인경우 0문자열인경우 null;
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
%>
<%
	Class.forName("com.mysql.jdbc.Driver");
	String sql="select * from gallery order by gallery_id desc";//내림차순 정렬
	con = DriverManager.getConnection(url,user,pass);
	
	pstmt= con.prepareStatement(sql);//쿼리문 준비
	rs = pstmt.executeQuery();
	
	
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>사진목록</title>
</head>
<body>
	<table width="80%" border="1px" align="center">
		<tr>
			<td>gallery_id</td>
			<td>제목</td>
			<td>장소</td>
			<td>상세설명</td>
			<td>이미지</td>
		</tr>
<%while(rs.next()){%>
		<tr>
			<td><%=rs.getInt("gallery_id")%></td>
			<td><%=rs.getString("title")%></td>
			<td><%=rs.getString("spot")%></td>
			<td><%=rs.getString("detail")%></td>
			<td><img src="/Data/<%=rs.getString("filename")%>" width="200px" height="200px"></td>
		</tr>
<%}%>
		<tr>
			<td colspan="5" align="center"><button onClick="location.href='/upload.html'">사진등록</button></td>
		</tr>
	</table>
</body>
</html>
<%
	if(rs!=null)rs.close();
	if(pstmt!=null)pstmt.close();
	if(con!=null)con.close();
%>
