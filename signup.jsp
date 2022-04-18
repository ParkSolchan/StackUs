<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
	<link rel="stylesheet" href="signup.css" type="text/css">
</head>
<body>
	<div style="width:700px"  align="center">
		<header>
	        <h1>
	            <a href="page.html">Stack Us</a><br>
	        </h1>
	    </header>
	    <hr><hr>
	    <div class="wrapper">
	        <div class="title"><h1 style="font-size: 21px;">ȸ������</h1></div><br>
	        <div class="email">
	            <input id="email" type="text" placeholder="�̸����� �Է��� �ּ���.">
	            <div id="emailError" class="error"></div>
	        </div>
	        <div class="name">
	            <input id="name"  type="text" placeholder="�̸��� �Է��� �ּ���.">
	            <div id="nameError" class="error"></div>
	        </div>
	        <div class="password">
	            <input id="password" type="password" placeholder="��й�ȣ�� �Է��� �ּ���.">
	            <div id="passwordError" class="error"></div>
	        </div>
	        <div class="passwordCheck">
	            <input id="passwordCheck" type="password" placeholder="��й�ȣ�� �ٽ� �Է��� �ּ���.">
	            <div id="passwordCheckError" class="error"></div>
	        </div>
	        <div class="phone"> 
	            <!--input id="phone1" type="text" size="1" maxlength="3" oninput="changePhone1()"-->
	            <select id="phone1">
	            	<option>010</option>
	            	<option>011</option>
	            	<option>016</option>
	            	<option>019</option>
	            </select>
	             -
	            <input id="phone2" type="text" size="3" maxlength="4" oninput="changePhone2()"> -
	            <input id="phone3" type="text" size="3" maxlength="4" oninput="changePhone3()">
	        </div>
	        <br>
	        <div class="area">
	            <select id="area">
	                <option selected disabled>������ �����ϼ���.</option>
	                <option>����Ư����</option>
	                <option>��⵵</option>
	                <option>��õ������</option>
	                <option>�λ걤����</option>
	                <option>����������</option>
	                <option>�뱸������</option>
	                <option>���ֱ�����</option>
	                <option>���ϵ�</option>
	                <option>��󳲵�</option>
	                <option>����ϵ�</option>
	                <option>���󳲵�</option>
	                <option>��û�ϵ�</option>
	                <option>��û����</option>
	            </select>
	            <div id="areaError" class="error"></div>
	        </div>
	        <div class="gender">
	            <input id="gender_man" type="radio" name="gender"> ���� &nbsp;  
	            <input id="gender_woman" type="radio" name="gender"> ����
	            <div id="genderError" class="error"></div>
	        </div>
	        <div class="line">
	            <hr>
	        </div>
	        <div class="signUp">
	            <button id="signUpButton" disabled onclick="signUpCheck()">�����ϱ�</button>
	        </div>
	    </div>
    </div>
</body>
</html>