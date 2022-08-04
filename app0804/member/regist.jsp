<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%! 
	//선언부 : 멤버영역(멤버변수, 멤버메소드)
	String url="jdbc:oracle:thin:@localhost:1521:XE";
	String user="java";
	String password="1234";
%>
<%
	//스클립틀릿 : 로직작성
	//out.print("이 jsp에서 회원을 처리할거임");
	//클라이언트인 브라우저가 전송한 파라미터(전송변수 즉 html에서의 name)들을 받아보자!!
	request.setCharacterEncoding("utf-8");
	String user_id		=	request.getParameter("user_id");
	String pass			=	request.getParameter("pass");
	String user_name	=	request.getParameter("user_name");
	String mail_id		=	request.getParameter("mail_id");
	String myserver		=	request.getParameter("myserver");
	String mail_server	=	request.getParameter("mail_server");
	String tel1				=	request.getParameter("tel1");
	String tel2				=	request.getParameter("tel2");
	String tel3				=	request.getParameter("tel3");
	String social1			=	request.getParameter("social1");
	String social2			=	request.getParameter("social2");
	String gender			=	request.getParameter("gender");
	//취미는 이따가 처리
	//취미는 배열로 되어 있으므로, 배열로 받야한다.
	String[] hobby		=  request.getParameterValues("hobby");

	out.print("당신이 선택한 취미수는"+hobby.length);
	//직접입력 이메일 서버가 있다면, 그걸 우선해주고 없으면 select박스 값을 넣는다.
	
	String email = null;
	String s= null;
	if(myserver.length()>0){ // s =(myserver.length()>0)  myserver ? mail_server
		s=myserver;
	}else{
		s=mail_server;
	}
	email= mail_id+"@"+s; //최종결정된 이메일 주소

	
	out.print("user_id 값은 "+user_id);
	out.print("<br>");
	out.print("pass 값은 "+pass);
	out.print("<br>");
	out.print("user_name 값은 "+user_name);
	out.print("<br>");
	out.print("mail_id 값은 "+mail_id);
	out.print("<br>");
	out.print("myserver 값은 "+myserver.length());
	out.print("<br>");
	out.print("mail_server 값은 "+mail_server);
	out.print("<br>");
	out.print("social1 값은 "+social1);
	out.print("<br>");
	out.print("social2 값은 "+social2);
	out.print("<br>");
	out.print("gender 값은 "+gender);
	out.print("<br>");

// 오라클의 테이블에 레코드 넣기!!
	//1) 해당 dbms제품에 맞는 드라이버 로드
	//2) 접속
	//3) 쿼리문 날리기
	//4) db관련된 객체 해제

	Class.forName("oracle.jdbc.OracleDriver");
	
	Connection con = DriverManager.getConnection(url,user,password);
	if(con==null){
		out.print("접속실패<br>");
	}else{
		out.print("접속성공<br>");
	}
	
	String sql = "insert into member(member_id,user_id,pass,user_name,email,tel1,tel2,tel3,social1,social2,gender)";
	sql+=" values(seq_member.nextval,?,?,?,?,?,?,?,?,?,?)";
	//PreparedStatement는 인터페이스 이므로, new로 직접 생성 할 수없다
	//그럼 언제 생성되나?? Connection객체로 부터 인스턴스를 얻어올수 있다.
	//즉 접속이 성공되면 얻어 올수 있다
	PreparedStatement pstmt = con.prepareStatement(sql);
	//바인드 변수값 할당하기 
	pstmt.setString(1, user_id);
	pstmt.setString(2, pass);
	pstmt.setString(3, user_name);
	pstmt.setString(4, email);
	pstmt.setString(5, tel1);
	pstmt.setString(6, tel2);
	pstmt.setString(7, tel3);
	pstmt.setString(8, social1);
	pstmt.setString(9, social2);
	pstmt.setString(10, gender);

	int result = pstmt.executeUpdate(); //DML수행 메서드
	if(result==0){
		out.print("입력실패");
	}else{
		out.print("입력성공");
	}

	//member테이블에 레코드가 입력된 시점에, 얼른 pk인 member_id를 가져와야함....
	//select max문은 너무 위험하다? dbms는 다중사용자 서버이므로 동시사용시 데이터에 일관성이 깨질수 잇음..
	int member_id=0;
	sql = "select seq_member.currval as member_id from dual";
	PreparedStatement pstmt2=con.prepareStatement(sql);
	ResultSet rs = pstmt2.executeQuery();//select문 수행!
	if(rs.next()){//next호출시 트루라면,즉 레코드가 존재한다면..
		member_id = rs.getInt("member_id");
	}	

	PreparedStatement pstmt3=null;
	//hobby테이블에 취미 넣기 
	for(int i=0; i<hobby.length; i++){
		sql="insert into hobby(hobby_id,member_id,hobby_name)";
		sql+=" values(seq_hobby.nextval,?,?)";
		//쿼리문 하나당 preaprestatment 한개씩 생성
		 pstmt3=con.prepareStatement(sql);
		 pstmt3.setInt(1,member_id);
		 pstmt3.setString(2,hobby[i]);
		 pstmt3.executeUpdate();
	}





	if(rs!=null)pstmt.close();
	if(pstmt2!=null)pstmt.close();
	if(pstmt3!=null)pstmt.close();
	if(pstmt!=null)pstmt.close();
	if(con !=null)con.close();
	



%>