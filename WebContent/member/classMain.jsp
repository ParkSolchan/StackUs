<%@page import="youtube.youtube"%>
<%@page import="oracle.net.aso.q"%>
<%@page import="question.questionBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="question.questionDBBean"%>
<%@page import="teacher.classBean"%>
<%@page import="teacher.classDBBean"%>
<%@page import="member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html lang="en">
<%
	String mem_image = "default_profile.png";
	String mem_id = "";
	int mem_type = 1;
	String type = "Admin";
	String img = "";
	String mem_name="";
	MemberDBBean db = MemberDBBean.getInstance();
	if(session.getAttribute("id")!= null){
		mem_id = session.getAttribute("id").toString();
		mem_image = db.getMyimg(mem_id);
		mem_type = db.getType(mem_id);
		img = db.getMyimg(mem_id);
		mem_name = db.getMyName(mem_id);
		if(mem_type == 2){
			type = "Teacher";
		}else if(mem_type == 3){
			type = "Student";
		}
	}
	
%>
<% 
	String cla_name = request.getParameter("cla_name");	
	response.setCharacterEncoding("utf-8");
	request.setCharacterEncoding("utf-8");
%>
<head>
    <meta charset="utf-8">
    <title>Stack Us</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Favicon -->
    <link href="../img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="../lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="../lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

    <!-- Customized Bootstrap Stylesheet -->
    <link href="../css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="../css/style.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script type="text/javascript">
    $(function(){
		$(".pop_btn").click(function(){
			var popUrl = "../exam/examMain.jsp";
			var popOption = "width=650px, height = 550px, resizable= no, location=no,top=300px,left=300px";
			window.open("../exam/examMain.jsp","???????? ????","width=880px, height = 550px");
		});
		$(".pop_question").click(function(){
			var popUrl = "../teacher/questionWrite.jsp";
			var popOption = "width=650px, height = 550px, resizable= no, location=no,top=300px,left=300px";
			window.open("../member/questionSolve.jsp","?????? ???? ????","width=800px, height = 1000px");
		});
		/* ???????? */
		$(".pop_manage").click(function(){
			var popupWidth = 500;
			var popupHeight = 600;

			var popupX = (window.screen.width/2)-(popupWidth/2);
			var popupY= (window.screen.height/2)-(popupHeight/2);
			var popUrl = "../teacher/studentManage.jsp";
			window.open(popUrl,"???? ????",'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
		});
		/* ???????? */
     }); 
	</script>
	<script type="text/javascript">
	var lastID = 0;
	var cla_name = '<%=cla_name%>';
	function submitFunction() {
		var chatName = $('#chatName').val();
		var chatContent = $('#chatContent').val();
		var chatImg = $('#chatImg').val();
		var cla_name = $('#cla_name').val();
		$.ajax({
			type: "POST",
			url: "../chatSubmitServlet",
			data: {
				chatName : encodeURIComponent(chatName),
				chatContent : encodeURIComponent(chatContent),
				chatImg : encodeURIComponent(chatImg),
				cla_name : encodeURIComponent(cla_name),
			},
			success : function (result) {
				if(result == 1){
					autoClosingAlert("#successMessage",2000);
				} else if (result == 0){
					autoClosingAlert("#dangerMessage",2000);
				} else {
					autoClosingAlert("#warningMessage",2000);
				}
			}
		});
		$('#chatContent').val('');
	}
	function autoClosingAlert(selector, delay) {
		var alert = $(selector).alert();
		alert.show();
		window.setTimeout(function() {alert.hide()},delay);
	}
	function chatListFunction(type,cla_name) {
		$.ajax({
			type: "POST",
			url: "../chatListServlet",
			data: {
				listType: type,
				cla_name: cla_name,
			},
			success: function(data) {
				if(data == "") return;
				var parsed = JSON.parse(data);
				var result = parsed.result;
				console.log(data)
				for(var i = 0; i < result.length; i++) {
					addChat(result[i][0].value, result[i][1].value, result[i][2].value, result[i][3].value,result[i][4].value);
				}
				lastID = Number(parsed.last);
			}
		});
	}
	function addChat(chatName, chatContent, chatImg, cla_name ,chatTime) {
		$('#chatList').append('<div class="row" style="width:100%">' +
				'<div class = "col-lg-12">' +
				'<div class = "d-flex align-items-center py-3">' +
				'<a class="pull-left" href="#">' +
				'<img class="flex-shrink-0 rounded-circle" width="40px" height="40px" src="../images/'+
				chatImg+
				'" alt="">' +
				'<div class="w-100 ms-3">' +
				'<div class="d-flex w-100 justify-content-between"><b>' +
				chatName +
				'</b><span class="mb-0">' +
				chatTime +
				'</span>' +
				'</div>' +
				'</a>' +
				'<p>' +
				chatContent +
				'</p>' +
				'</div>'+
				'</div>'+
				'</div>'+
				'</div>'+
				'<hr>');
		$('#chatList').scrollTop($('#chatList')[0].scrollHeight);
	}
	function getInfiniteChat() {
		setInterval(function() {
			chatListFunction(lastID,cla_name);
		}, 1000);
	}
	function removeCheck() {

		 if (confirm("?????????????????") == true){    //????

		     location.href='../member/exitclass.jsp?cla_name=<%=cla_name%>';

		 }else{   //????
		     return false;
		 }
	}
	</script>
</head>

<body>
    <div class="container-xxl position-relative bg-white d-flex p-0">
        <!-- Spinner Start -->
        <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
        <!-- Spinner End -->


        <!-- Sidebar Start -->
        <div class="sidebar pe-4 pb-3">
            <nav class="navbar bg-light navbar-light">
                <a href="../main/main.jsp" class="navbar-brand mx-4 mb-3">
                    <h3 class="text-primary"><i class="fa fa-hashtag me-2"></i>STACK US</h3>
                </a>
                <div class="d-flex align-items-center ms-4 mb-4">
                    <div class="position-relative">
                <%
                	if(session.getAttribute("id")!= null){
				%>
                        <img class="rounded-circle" src="../images/<%= mem_image %>" alt="" style="width: 40px; height: 40px;">
                        <div class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1"></div>
                    </div>
                    <div class="ms-3">
                        <h6 class="mb-0"><%= mem_id %></h6>
                        <span><%= type %></span>
                    </div>
				<%
                	}else{
                %>
                      <!--<img class="rounded-circle" src="../img/1235.jpg" alt="" style="width: 40px; height: 40px;"> -->
                        <i class="bi bi-box-arrow-in-left" style="font-size: 2rem; color: #389dff"></i>
                        <!-- <div class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1"></div> -->
                    </div>
                    <div class="ms-3">
                        <h6 class="mb-0 popLogin"><a href="../main/mem_signin.jsp">??????</a></h6>
                        <span>??????</span>
                    </div>
                <%		
                	}
                %>
                </div>
                <div class="navbar-nav w-100">
                    <a href="../main/main.jsp" class="nav-item nav-link"><i class="bi bi-house-fill me-2"></i>Home</a>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="bi bi-chat-dots me-2"></i>Community</a>
                        <div class="dropdown-menu bg-transparent border-0">
                            <a href="../board/boardlist_0.jsp" class="dropdown-item">????????</a>
                            <a href="../board/boardlist_1.jsp" class="dropdown-item">??????????</a>
                            <a href="../board/boardlist_2.jsp" class="dropdown-item">???? ????</a>
                            <a href="../board/boardlist_3.jsp" class="dropdown-item">QnA</a>
                        </div>
                    </div>
                    <%
                    	if(mem_type==3){
                    %>
	                    <a href="../member/mem_Main.jsp" class="nav-item nav-link active"><i class="bi bi-tv-fill me-2"></i>Class</a>
                    <%		
                    	}else{
                    %>
	                    <a href="../teacher/class_list.jsp" class="nav-item nav-link active"><i class="bi bi-tv-fill me-2"></i>Class</a>
                    <%		
                    	}
                    %>
                    <a href="../main/main.jsp" class="nav-item nav-link pop_btn"><i class="bi bi-ui-checks-grid me-2"></i>CBT</a>
                    <a href="../about/aboutS1.jsp" class="nav-item nav-link"><i class="bi bi-three-dots me-2"></i>About</a>
                    <%
                    	if(mem_type == 1){
                    %>		
                    <a href="../main/admin_page.jsp" class="nav-item nav-link"><i class="bi bi-card-list me-2"></i>Manage</a>
                    <%
                    	}
                    %>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="bi bi-shield-lock me-2"></i>Account</a>
                        <div class="dropdown-menu bg-transparent border-0">
                        <%
                        	if(session.getAttribute("id")!=null){
                        %>
                            <a href="#" class="dropdown-item">My Page</a>
                            <a href="../main/logout.jsp" class="dropdown-item">Logout</a>
                        <%		
                        	}else{
                        %>
                            <a href="../main/mem_signin.jsp" class="dropdown-item">Sign In</a>
                            <a href="../main/mem_signup.jsp" class="dropdown-item">Sign Up</a>
                        <%	
                        	}
                        %>
                        </div>
                    </div>
                </div>
            </nav>
        </div>
        <!-- Sidebar End -->


        <!-- Content Start -->
        <div class="content">
            <!-- Navbar Start -->
            <nav class="navbar navbar-expand bg-light navbar-light sticky-top px-4 py-0">
                <a href="index.html" class="navbar-brand d-flex d-lg-none me-4">
                    <h2 class="text-primary mb-0"><i class="fa fa-hashtag"></i></h2>
                </a>
                <a href="#" class="sidebar-toggler flex-shrink-0">
                    <i class="fa fa-bars"></i>
                </a>
                <form class="d-none d-md-flex ms-4" action="../main/search.jsp">
                	<select name="selbox" class="form-select" aria-label="Default select example" style="width: 100px;">
                		<option value="????">????</option>
                		<option value="??????">??????</option>
                		<option value="????">????</option>
                	</select>
                    &nbsp;&nbsp;&nbsp;<input name="search" class="form-control border-0" type="search" placeholder="Search">
                </form>
                <div class="navbar-nav align-items-center ms-auto">
                    <div class="nav-item dropdown">
                <%
                	if(session.getAttribute("id")!= null){
				%>    
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                            <img class="rounded-circle me-lg-2" src="../images/<%= mem_image %>" alt="" style="width: 40px; height: 40px;">
                            <span class="d-none d-lg-inline-flex"><%= mem_id %></span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                            <a href="../main/MyAccount.jsp" class="dropdown-item">??????????</a>
                            <a href="../main/mem_edit.jsp" class="dropdown-item">????????</a>
                            <a href="../main/logout.jsp?href=../main/main.jsp" class="dropdown-item">????????</a>
                        </div>
                <%
                	}else{
                %>
                            <button class="btn btn-outline-primary m-2"><a href="../main/mem_signin.jsp">Login</a></button>
                <%		
                	}
				%>    
                    </div>
                </div>
            </nav>
            <!-- Navbar End -->
<%
	classDBBean cdb = classDBBean.getInstance();
	String tea_id = request.getParameter("tea_id");
	classBean bean = new classBean();
	
	bean = cdb.getClass(tea_id, cla_name);
	session.setAttribute("mem_id", session.getAttribute("mem_id"));
	session.setAttribute("cla_name", bean.getCla_name());
	String tea_image = db.getMyimg(tea_id);	
%>
            <!-- Sale & Revenue Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="row g-4">
                    <div class="col-sm-12">
                        <div class="bg-light rounded d-flex align-items-center justify-content-start p-4">
						<img class="rounded-circle" src="../images/<%= tea_image %>" width="90px" height="90px">
							<div style="margin-left: 10px">
                                <p class="mb-2">??????????.<b><%=cla_name %></b>??????.</p>
                                <h6 class="mb-0"><%= bean.getCla_intro() %></h6>
                                <h6 class="mb-0"><%= tea_id %>???????? ??????</h6>
                            </div>
                            &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                            &emsp;&emsp;&emsp;&emsp;
                            <input type="button" class="btn btn-primary m-2 pop_question" value="????????????">
                            <!-- ???????? -->
                            <% if(type.equals("Teacher")){
                            	%>
                            <input type="button" class="btn btn-primary m-2 pop_manage" value="????????">   
							<%}else{
								}
								%>
                            <!-- ???????? -->    
                        </div>
                    </div>
                </div>
            </div>
            <!-- Sale & Revenue End -->
            
            
            
            <!-- Widgets Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="row g-4">
                    <div class="col-sm-12 col-md-6">
                        <div class="h-100 bg-light rounded p-4">
                            <div class="d-flex align-items-center justify-content-between mb-2">
                                <h6 class="mb-0"><i class="bi bi-award" style="font-size: 1.5rem; color: #389dff;"></i>&nbsp;??????????????</h6>
                            </div>
	<%
		questionDBBean qdb = questionDBBean.getInstance();
		ArrayList<questionBean> qlist = qdb.questionList(cla_name);
		for(int i = 0; i< qlist.size();i++){
			questionBean qbean = qlist.get(i);
			if(i==4) break;
	%>
                            <div class="d-flex align-items-center border-bottom py-3">
                                <%
                                	if(i==0){
                                %>
                                	<i class="bi bi-trophy-fill" style="font-size: 1.5rem; color: #f7e600;"></i>
                                <%		
                                	}else if(i == 1){
                                %>
                                	<i class="bi bi-trophy-fill" style="font-size: 1.5rem; color: silver;"></i>
                                <%		
                                	}else if(i == 2){
                                %>
                                	<i class="bi bi-trophy-fill" style="font-size: 1.5rem; color: #808000;"></i>
                                <%		
                                	}else if(i == 3){
                                %>
                                	<i class="bi bi-trophy-fill" style="font-size: 1.5rem; color: #1E90FF	;"></i>
                                <%		
                                	}
                                %>
                                <div class="w-100 ms-3">
                                    <div class="d-flex w-100 justify-content-between">
                                    <h6 class="mb-0"><%= qbean.getQ_no() %>??????</h6>
                                        <small>?????? : <%= qbean.getPercent() %>%</small>
                                    </div>
                                    <span><%= qbean.getCla_name() %></span>
                                </div>
                            </div>
	<%		
		}
	%>
                        </div>
                    </div>
					<div class="col-sm-12 col-md-6">
                        <div class="h-100 bg-light rounded p-4">
                            <div class="d-flex align-items-center justify-content-start mb-4">
                            <%
                            		String re = cdb.getLink(cla_name);
                       		%>
	                            	<iframe width="100%" height="315" src="https://youtube.com/embed/<%= re %>" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                            </div> 
    <%
    	if(mem_type == 2){
    %>
                        			<form action="../member/youtube.jsp" method="post" style="clear: both;">
                        				<input type="hidden" name="cla_name" value="<%= cla_name%>">
                        				<input type="text" name="str">
	                            		<input type="submit" value="????">
                        			</form>
    <%		
    	}
    %>
                        </div>
                    </div>
				</div>
            </div>
            <!-- Widgets End -->


            <!-- Sales Chart Start  -->
            <div class="container-fluid col-sm-12 pt-4 px-4">
                <div class="row g-4">
	        		<div class="">
						<div class="" style="width:100%; background-color: #f3f6f9; padding: 10px">
							<div class="">
								<div class="">
									<div class="">
										<div class="">
											<h4 style="color: #389dff"><i class="" style=""></i><%=cla_name%> ??????</h4>
										</div>
										<div class=""></div>
									</div>
									<div id="chat" class="">
										<!-- overflow-y : auto; ?? ?????? ???? ???????? ?? ?????????? ???????? ????????. -->
										<div id="chatList" class="" style="overflow-y: auto; width: 100%; height: 600px;">
										</div>
										<div class="">
											<div class="row">
												<div class="">
													<input type="hidden" id="chatImg" value="<%= img %>">
													<input type="hidden" id="cla_name" value="<%= cla_name%>">
													<input style="height: 30px; margin-bottom: 10px" type="text" id="chatName" class="" value="<%=mem_name%>" maxlength="20" disabled>
												</div>
											</div>
											<div class="" style="height:80px">
												<div class=" ">
													<input type="text" onkeyup="enterkey();" style="height:60px;" id="chatContent" class="form-control" placeholder="???????? ??????????" maxlength="100"></textarea>
												</div> 
											</div>
											<div class="">
											<!-- 	<button type="button" onclick="submitFunction()">????</button> -->
												<div class=""></div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="alert alert-success" id="successMessage" style="display:none;">
							<strong>?????? ?????? ??????????????.</strong>
						</div>
						<div class="alert alert-success" id="dangerMessage" style="display:none;">
							<strong>?????? ?????? ???? ????????????.</strong>
						</div>
						<div class="alert alert-success" id="warningMessage" style="display:none;">
							<strong>???????????? ?????? ????????????.</strong>
						</div>
								</div>
					<script type="text/javascript">
						$(document).ready(function() {
							var cla_name = '<%=cla_name%>';
							chatListFunction('ten',cla_name);
							getInfiniteChat();
						});
						function enterkey() {
							if (window.event.keyCode == 13) {
								submitFunction();
							}
						}
					</script>
               </div>   
            </div>
            <!--  Sales Chart End -->
            <!-- ???? ???? ???? -->
            <%if(type.equals("Student")){
            	%>
            <div style="margin: 10px; text-align: right; margin-right: 30px;">
            <input type="button" name="exitbtn" value="?????? ????" class="btn btn-dark" onclick="removeCheck()">
            </div>
            <% }else{
            	}%>
            
            <!-- ???? ???? ???? -->
            
            <!-- Footer Start -->
            <div class="container-fluid bg-white pt-5 px-3">
                    <div class="row">
                        <div class="col-12 col-sm-6 text-center text-sm-start">
                            &copy; <a href="#">StackUs</a>, All Right Reserved. 
                        </div>
                        <div class="col-12 col-sm-6 text-center text-sm-end">
                            <!--/*** This template is free as long as you keep the footer author??s credit link/attribution link/backlink. If you'd like to use the template without the footer author??s credit link/attribution link/backlink, you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". Thank you for your support. ***/-->
                            Designed By <a href="https://htmlcodex.com">HTML Codex</a>
                        </br>
                        Customer Service <a class="border-bottom" href="https://themewagon.com" target="_blank">ThemeWagon</a>
                        </div>
                </div>
            </div>
            <!-- Footer End -->
        </div>
        <!-- Content End -->


        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
    </div>

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../lib/chart/chart.min.js"></script>
    <script src="../lib/easing/easing.min.js"></script>
    <script src="../lib/waypoints/waypoints.min.js"></script>
    <script src="../lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="../lib/tempusdominus/js/moment.min.js"></script>
    <script src="../lib/tempusdominus/js/moment-timezone.min.js"></script>
    <script src="../lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

    <!-- Template Javascript -->
    <script src="../js/main.js"></script>
</body>

</html>