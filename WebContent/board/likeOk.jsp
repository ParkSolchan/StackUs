<%@page import="board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<% int bo_no = Integer.parseInt(request.getParameter("bo_no")); %>
	<% String mem_id = request.getParameter("mem_id"); %>
	<%
		BoardDBBean db = BoardDBBean.getInstance();
		session.setAttribute("bo_no", bo_no);
		if(request.getParameter("already").equals("false")){
			db.likeBoard(bo_no, mem_id);
	%>
	<script type="text/javascript">
		alert("��õ�� �����߽��ϴ�.");
		location.href="../board/show.jsp";		
	</script>
	<%
		}else{
			db.disLikeBoard(bo_no, mem_id);
	%>	
	<script type="text/javascript">
		alert("��õ��� �߽��ϴ�.");
		location.href="../board/show.jsp";		
	</script>
	<%
		}
	%>	
</body>
</html>