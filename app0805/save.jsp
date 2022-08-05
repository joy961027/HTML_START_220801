<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.File"%>
<%! 
	String url ="jdbc:mysql://localhost:3306/javastudy?useUnicod=true&characterEncoding=utf8";
	String user = "root";
	String pass = "1234";
	//클래스의 멤버변수는 컴파일러에 의해 자동 초기화된다. 따라서 숫자인경우 0문자열인경우 null;
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;

	//확장자 추출하는 메서드
	public String getExt(String path){
		//xp.a.jpg
		return path.substring(path.lastIndexOf(".")+1,path.length());
	
	}
%>
<%
	//클라이언트가 보낸 파일을 서버에 업로드처리하려면, 많은 로직이 수반되므로 누군가가 만들어 놓은
	//라이브러리를 이용해보자, 우리가 사용할 라이브러니는 cos.jar이며, 이라이브러리중	MultipartRequest
	//클래스가 업로드를 처리하는 클래스이다.
	//아래와 같이 이미지가 업로드될 경로를 해당 OS플랫폼에 맞게 고정시켜버리면 다른 플랫폼 기반에서는 
	//어플리케이션을 또 수정해야 하므로, 아래와 같은 하드코딩은 하지 말자
	//해결책? 앞으로 배우게 될 JSP의 내장객체 중 현재 웹어프리케이션의 전반적인 정보를 다루는 객체인 
	//application 객체를 이용하면 된다..
	
	String saveDir= application.getRealPath("/Data");
	out.print(saveDir+"<br>");

	int maxSize=1024*1024*3;//개발자가 직접계산하지말고, 언어에 맡기자!
	String encoding ="utf-8";
	MultipartRequest multi = new MultipartRequest(request,saveDir,maxSize,encoding);
	
	//클라이언트의 브라우저에서 전공한 parameter(전송되어온 변수)들을 받자
	//request.setCharacterEncoding("utf-8");
	String title		= multi.getParameter("title");
	String spot	= multi.getParameter("spot");
	String detail	= multi.getParameter("detail");
	//클라이언트가 전송한 원래 이미지명 추출
	File file			= multi.getFile("myfile");//javase의 file을 반환
	String filename = file.getName();

	out.print("업로드한 파일 네임은 " + filename +"<br>");
	
	//파일의 이름을 아직 바꾸지 않았으믈, insert를 먼저 진행한후 그 쿼리로부터 생성된 레코드의
	//primary key를 이용하여 파일명으로 사용해본다!!(ex) 54이면 54.jpg)

	Class.forName("com.mysql.jdbc.Driver");
	
	con = DriverManager.getConnection(url,user,pass);
	if(con == null){
		out.print("접속실패!");
	}else{
		out.print("접속성공");
	}
	//업로드 는 insert+update모두 성공해야, 전체를 성공으로 간주하는 트랜잭션 상황이다.
	//즉 세부 업무가 2개짜리 트랜잭션이다.
	con.setAutoCommit(false);
	try{	
		String sql="insert into gallery(title,spot,detail) values(?,?,?)";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1,title);
		pstmt.setString(2,spot);
		pstmt.setString(3,detail);
		int result = pstmt.executeUpdate();//dml의 경우
		if(result==0){
			out.print("등록실패");
		}else{
			out.print("등록성공");
			//현재 이 커넥션에서 일으킨 가장 마지막 primary key를 얻어오기
			//주의)select max()쓰지말자 다른 사람이 일으킨 값도 가져오니깐.
			sql="select last_insert_id() as gallery_id";
			pstmt=con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			int gallery_id=0;
			if(rs.next()){
				gallery_id = rs.getInt("gallery_id");
			}
			String lastName = gallery_id+"."+getExt(filename);
			boolean result2 = file.renameTo(new File(saveDir+"/"+lastName));
			if(result2){
				//filename을 업데이트
				sql="update gallery set filename=? where gallery_id=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1,lastName);
				pstmt.setInt(2,gallery_id);
				pstmt.executeUpdate();
			}

		}
		con.commit();//트랜잭션 성공
	}catch(SQLException e){
		con.rollback();//트랜잭션 실패
	}finally{
		con.setAutoCommit(true);//원상복귀
	}

	if(rs!=null)rs.close();
	if(pstmt!=null)pstmt.close();
	if(con!=null)con.close();
	
	//등록이 완료되면, 클라이언트에 브라우저로 하여금 우리가 지정한 페이지를 다시 접속하도록 명령
	response.sendRedirect("/list.jsp");
%>