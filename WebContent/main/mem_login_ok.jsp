<%@page import="member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String mem_id = request.getParameter("mem_id");
	String mem_pw = request.getParameter("mem_pwd");
	
	MemberDBBean db = MemberDBBean.getInstance();
	int re = db.memLogin(mem_id, mem_pw);
	
	if(re == 1){
		session.setAttribute("id", mem_id);
		int type = db.getType(mem_id);
		if(type == 2){
			session.setAttribute("type", "teacher");
		}else if(type == 1){
			session.setAttribute("type", "admin");
		}else{
			session.setAttribute("type", "student");
		}
		response.sendRedirect("../main/main.jsp");
	}else if(re == 0){
%>
		<script>
			alert("�߸��� ��й�ȣ�Դϴ�.");
			history.back();
		</script>
<%		
	}else{
		session.invalidate();
%>		
		<script>
			alert("�������� �ʴ� ȸ��");
			history.back();
		</script>
<%
	}
%>	
