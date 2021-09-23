<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<script src="js/jquery-3.6.0.min.js"></script>
<title>TBG API</title>
<style>
	#wrap {
		width:480px;
		/* margin-top:50px; */
		margin-bottom:50px;
		float: left;
	}
	
	table {
		border:3px solid black
	}
	
	td {
		border:1px solid black
	}
	
	#title {
		background-color:skyblue
	}
	.box-container {
		display: flex;
	}
	button {
		cursor : pointer;
	}
</style>
<script type="text/javascript">
	function insertUser(){ 
		var user_id = document.getElementById("user_id").value;
		var user_name = document.getElementById("user_name").value;
		var user_mobile = document.getElementById("user_mobile").value;
		var user_email = document.getElementById("user_email").value;
		var user_code = document.getElementById("user_code").value;
		
		var service_id = document.getElementById("service_id").value;
		var manager_id = document.getElementById("manager_id").value;
		var password = document.getElementById("password").value;
		
		$.ajax({
			url : "/insertuser.do",
			dataType : "json",
			beforeSend : function(xhr) {
				xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
				xhr.setRequestHeader("Authorization", service_id+":"+manager_id+":"+password);
			},
			data : {
				'user_id' : user_id,
				'user_name' : user_name,
				'user_mobile' : user_mobile,
				'user_email' : user_email,
				'user_code' : user_code
			},
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(data) {
				var obj = eval(data);
				alert("결과 : "+obj.message+"\nrtnCode : "+obj.rtnCode);
			}, error:function(request, status, error) {
			      alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    }
		});
	}
	
	function insertDevice() {
		var user_id = document.getElementById("d_user_id").value;
		var device_id = document.getElementById("device_id").value;
		var device_name = document.getElementById("device_name").value;
		var device_code = document.getElementById("device_code").value;
		var device_mac = document.getElementById("device_mac").value;
		
		var service_id = document.getElementById("service_id").value;
		var manager_id = document.getElementById("manager_id").value;
		var password = document.getElementById("password").value;

		$.ajax({
			url : "/insertdevice.do",
			dataType : "json",
			beforeSend : function(xhr) {
				xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
				xhr.setRequestHeader("Authorization", service_id+":"+manager_id+":"+password);
			},
			data : {
				'user_id' : user_id,
				'device_id' : device_id,
				'device_name' : device_name,
				'device_code' : device_code,
				'device_mac' : device_mac
			},
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(data) {
				var obj = eval(data);
				alert("결과 : "+obj.message+"\nrtnCode : "+obj.rtnCode);
			}
		});
	}
	
	function deletefn(flag){
		
		var service_id = document.getElementById("service_id").value;
		var manager_id = document.getElementById("manager_id").value;
		var password = document.getElementById("password").value;
		
		if(flag=="user"){
			var user_id = document.getElementById("delete_user_id").value;
			
			$.ajax({
				url : "/deleteuser.do",
				dataType : "json",
				beforeSend : function(xhr) {
					xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
					xhr.setRequestHeader("Authorization", service_id+":"+manager_id+":"+password);
				},
				data : {
					'user_id' : user_id
				},
				contentType : "application/x-www-form-urlencoded; charset=UTF-8",
				success : function(data) {
					var obj = eval(data);
					alert("결과 : "+obj.message+"\nrtnCode : "+obj.rtnCode);
				}
			});
			
		} else {
			var device_id = document.getElementById("delete_device_id").value;
			
			$.ajax({
				url : "/deletedevice.do",
				dataType : "json",
				beforeSend : function(xhr) {
					xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
					xhr.setRequestHeader("Authorization", service_id+":"+manager_id+":"+password);
				},
				data : {
					'device_id' : device_id
				},
				contentType : "application/x-www-form-urlencoded; charset=UTF-8",
				success : function(data) {
					var obj = eval(data);
					alert("결과 : "+obj.message+"\nrtnCode : "+obj.rtnCode);
				}
			});
		}
	}
	
	function updateUser() {
		var user_id = document.getElementById("update_user_id").value;
		var user_name = document.getElementById("update_user_name").value;
		var user_mobile = document.getElementById("update_user_mobile").value;
		var user_email = document.getElementById("update_user_email").value;
		var user_code = document.getElementById("update_user_code").value;
		
		var service_id = document.getElementById("service_id").value;
		var manager_id = document.getElementById("manager_id").value;
		var password = document.getElementById("password").value;
		
		$.ajax({
			url : "/updateuser.do",
			dataType : "json",
			beforeSend : function(xhr) {
				xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
				xhr.setRequestHeader("Authorization", service_id+":"+manager_id+":"+password);
			},
			data : {
				'user_id' : user_id,
				'user_name' : user_name,
				'user_mobile' : user_mobile,
				'user_email' : user_email,
				'user_code' : user_code
			},
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(data) {
				var obj = eval(data);
				alert("결과 : "+obj.message+"\nrtnCode : "+obj.rtnCode);
			}, error:function(request, status, error) {
			      alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    }
		});
	}
	
	function auth() {
		var service_id = document.getElementById("service_id").value;
		var manager_id = document.getElementById("manager_id").value;
		var password = document.getElementById("password").value;
		
		var user_id = document.getElementById("a_user_id").value;
		var device_id = document.getElementById("a_device_id").value;
		//var system_code = document.getElementById("system_code").value;
		var action_code = document.getElementById("action_code").value;
		var connection_type = document.getElementById("connection_type").value;
		
		$.ajax({
			url : "/auth.do",
			dataType : "json",
			beforeSend : function(xhr) {
				xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
				xhr.setRequestHeader("Authorization", service_id+":"+manager_id+":"+password);
			},
			data : {
				'user_id' : user_id,
				'device_id' : device_id,
				//'system_code' : system_code,
				'action_code' : action_code,
				'connection_type' : connection_type
			},
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(data) {
				var obj = eval(data);
				alert("결과 : "+obj.message+"\nrtnCode : "+obj.rtnCode+"\n점수 : "+obj.score+"\n인증 : "+obj.auth);
			}
		});
	}
</script>
</head>
<body>
<div>
<h1>TBG API</h1>
</div>
<div>
		<h3>인증 정보(필수 입력)</h3>
	</div>
	<div>
		<table>
		<tr>
			<td id="title">서비스 아이디</td>
			<td>
				<input type="text" name="service_id" id="service_id" title="서비스 아이디" value="1261b31d-56ed000b-f236286b">
			</td>
		</tr>
		<tr>
			<td id="title">매니저 아이디</td>
			<td>
				<input type="text" name="manager_id" id="manager_id" title="매니저 아이디" value="admin"/>
			</td>
		</tr>
		<tr>
			<td id="title">패스워드</td>
			<td>
				<input type="password" name="password" id="password" title="비밀번호" value="dsm1234"/>
			</td>
		</tr>
		</table>
	</div>
	<div style="margin-top: 50px;">
		<h3>등록 정보</h3>
	</div>
	<div class="box-container">
	<div id="wrap" class="box">
		<caption>사용자 추가</caption>
		<form>
			<table>
				<tr>
					<td id="title">아이디</td>
					<td>
						<input type="text" name="user_id" id="user_id" title="아이디">
					</td>
				</tr>
				<tr>
					<td id="title">이름</td>
					<td>
						<input type="text" name="user_name" id="user_name" title="이름">
					</td>
				</tr>
				<tr>
					<td id="title">이메일</td>
					<td>
						<input type="text" name="user_email" id="user_email" title="이메일">
					</td>
				</tr>
				<tr>
					<td id="title">전화번호</td>
					<td>
						<input type="text" name="user_mobile" id="user_mobile" title="전화번호">
					</td>
				</tr>
				<tr>
					<td id="title">사용자 유형</td>
					<td>
						<input type="text" name="user_code" id="user_code" title="사용자 유형" value="9f1099-utc0001">
					</td>
				</tr>
			</table>
			<br>
			<button type="button" onclick="insertUser()">SEND</button>
		</form>
	</div>	
	<div id="wrap" class="box">
		<caption>사용자 수정</caption>
		<form>
			<table>
				<tr>
					<td id="title">아이디</td>
					<td>
						<input type="text" name="update_user_id" id="update_user_id" title="아이디">
					</td>
				</tr>
				<tr>
					<td id="title">이름</td>
					<td>
						<input type="text" name="update_user_name" id="update_user_name" title="이름">
					</td>
				</tr>
				<tr>
					<td id="title">이메일</td>
					<td>
						<input type="text" name="update_user_email" id="update_user_email" title="이메일">
					</td>
				</tr>
				<tr>
					<td id="title">전화번호</td>
					<td>
						<input type="text" name="update_user_mobile" id="update_user_mobile" title="전화번호">
					</td>
				</tr>
				<tr>
					<td id="title">사용자 유형</td>
					<td>
						<input type="text" name="update_user_code" id="update_user_code" title="사용자 유형" value="9f1099-utc0001"/>
					</td>
				</tr>
			</table>
			<br>
			<button type="button" onclick="updateUser();">SEND</button>
		</form>
	</div>	
	
	<div id="wrap" class="box">
		<caption>사용자 삭제</caption>
		<form>
			<table>
				<tr>
					<td id="title">사용자 아이디</td>
					<td>
						<input type="text" name="delete_user_id" id="delete_user_id" title="사용자 아이디">
					</td>
				</tr>
				
			</table>
			<br>
			<button type="button" onclick="deletefn('user');">SEND</button>
		</form>
	</div>	
	</div>
	
	<div class="box-container">
	<div id="wrap" class="box">
		<caption>디바이스 추가</caption>
		<form>
			<table>
				<tr>
					<td id="title">사용자 아이디</td>
					<td>
						<input type="text" name="d_user_id" id="d_user_id" title="사용자 아이디">
					</td>
				</tr>
				<tr>
					<td id="title">디바이스 아이디</td>
					<td>
						<input type="text" name="device_id" id="device_id" title="디바이스 아이디">
					</td>
				</tr>
				<tr>
					<td id="title">디바이스 이름</td>
					<td>
						<input type="text" name="device_name" id="device_name" title="디바이스">
					</td>
				</tr>
				<tr>
					<td id="title">디바이스 유형</td>
					<td>
						<input type="text" name="device_code" id="device_code" title="디바이스 유형">
					</td>
				</tr>
				<tr>
					<td id="title">MAC 주소</td>
					<td>
						<input type="text" name="device_mac" id="device_mac" title="MAC 주소">
					</td>
				</tr>
			</table>
			<br>
			<button type="button" onclick="insertDevice()">SEND</button>
		</form>
	</div>
	<div id="wrap" class="box">
		<caption>디바이스 삭제</caption>
		<form>
			<table>
				<tr>
					<td id="title">디바이스 아이디</td>
					<td>
						<input type="text" name="delete_device_id" id="delete_device_id" title="디바이스 아이디">
					</td>
				</tr>
			</table>
			<br>
			<button type="button" onclick="deletefn('device')">SEND</button>
		</form>
	</div>
	<div id="wrap" class="box">
		<caption>인증/인가 요청</caption>
		<form>
			<table>
				<tr>
					<td id="title">사용자 아이디</td>
					<td>
						<input type="text" name="a_user_id" id="a_user_id" title="사용자 아이디">
					</td>
				</tr>
				<tr>
					<td id="title">디바이스 아이디</td>
					<td>
						<input type="text" name="a_device_id" id="a_device_id" title="디바이스 아이디">
					</td>
				</tr>
				<!-- <tr>
					<td id="title">시스템 유형</td>
					<td>
						<input type="text" name="system_code" id="system_code" title="시스템 유형">
					</td>
				</tr> -->
				<tr>
					<td id="title">액션 코드</td>
					<td>
						<input type="text" name="action_code" id="action_code" title="업무 유형">
					</td>
				</tr>
				<tr>
					<td id="title">접속 방식</td>
					<td>
						<input type="text" name="connection_type" id="connection_type" title="접속 방식">
					</td>
				</tr>
			</table>
			<br>
			<button type="button" onclick="auth()">SEND</button>
		</form>
	</div>
	</div>
</body>
</html>
