<%@page import="java.io.File"%>
<%@page import="comment.CommentBean"%>
<%@page import="comment.CommentDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%

	int bo_no = Integer.parseInt(request.getParameter("bo_no"));
	int co_nom = Integer.parseInt(request.getParameter("co_nom"));
	String mem_pw = request.getParameter("mem_pw");
	String mem_id = request.getParameter("mem_id");
	
	CommentDBBean cm = CommentDBBean.getInstance();
	CommentBean comment = cm.getComment(co_nom);
	int re = cm.deleteComment(co_nom);
	
	if(re == 1){
		%>
			<script type="text/javascript">
				alert('�����Ǿ����ϴ�! co_nom ==>'+<%=co_nom%>);
			</script>
		<%
		response.sendRedirect("show.jsp?bo_no="+bo_no);
	}else if(re == 0){
		//��й�ȣ Ʋ��
%>
		<script>
			alert("��й�ȣ�� ���� �ʽ��ϴ�.");
			history.go(-1);
		</script>
<%
	}else if(re == -1){
		//���� ����
%>
		<script>
			alert("������ �����Ͽ����ϴ�..  "+<%=mem_pw%>+<%=mem_pw%>+<%=co_nom%>);
			history.go(-1);
		</script>
<%
	}
%>