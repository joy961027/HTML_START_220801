<%@ page contentType="text/html;charset=utf-8"%>
<%! 
	int price=5;


	public int getPrice(){
		return price;
	}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>index.jsp</title>
</head>
<body>
가격은<%=getPrice()%>입니다.
</body>
</html>
