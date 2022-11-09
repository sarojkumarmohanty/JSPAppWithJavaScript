<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Student Regd. Form</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
	integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-2.2.4.min.js"
	integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44="
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx"
	crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/3f5992c71f.js"
	crossorigin="anonymous"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/js/bootstrap-datepicker.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/css/bootstrap-datepicker3.css" />
<link rel="stylesheet" type="text/css"
	href="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables.css" />

<script type="text/javascript"
	src="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/jquery.dataTables.min.js"></script>

</head>
<body>
	<div class="container mt-5">

		<div>
			<c:if test="${not empty msg}">
				<p class="alert alert-success">${msg}</p>
				<c:remove var="msg" scope="session" />
			</c:if>
		</div>
		
		<h3 class="text-primary">Student Regd. Form</h3>
		<form class="form-group" method="post" action="./savestudent"
			id="regdform" onsubmit="return validateRegdForm();">

			<input type="hidden" name="rollNo" value="${ustud.rollNo}">

			<div class="row">
				<div class="col-md-4">
					<lable class="text-warning font-weight-bold">Name<sup
						class="text-danger">*</sup></lable>
					<input type="text" name="name" id="nameId" class="form-control"
						value="${ustud.name}">
				</div>
				<div class="col-md-4">
					<lable class="text-warning font-weight-bold">Email<sup
						class="text-danger">*</sup></lable>
					<input type="text" name="email" id="emailId" class="form-control"
						value="${ustud.email}">
				</div>
				<div class="col-md-4">
					<lable class="text-warning font-weight-bold">Phone No<sup
						class="text-danger">*</sup></lable>
					<input type="text" name="phone" id="phoneId" class="form-control"
						value="${ustud.phoneNo}">
				</div>

			</div>


			<div class="row">
				<div class="col-md-5">
					<lable class="text-warning font-weight-bold">College Name<sup
						class="text-danger">*</sup></lable>
					<input type="text" name="collegeName" id="collegeNameId"
						class="form-control" value="${ustud.collegeName}">
				</div>
				<div class="col-md-2">
					<lable class="text-warning font-weight-bold">Branch</lable>
					&nbsp;&nbsp;<small id="fid"></small> <select class="form-control"
						name="branch" id="branchId" onchange="getBranchFee()">
						<option value="0">-select-</option>
						<c:forEach items="${branchList}" var="branch">
							<option value="${branch.branchId}"
								<c:if test="${branch.branchId eq ustud.branch.branchId }">selected="selected" </c:if>>${branch.branchName }</option>
						</c:forEach>
					</select>

				</div>
				<div class="col-md-2">
					<lable class="text-warning font-weight-bold">CGPA</lable>
					<input type="text" name="cgpa" id="cgpaId" class="form-control"
						value="${ustud.cgpa}">
				</div>


				<div class="col-md-3">
					<lable class="text-warning font-weight-bold">DOB</lable>
					<input type="text" name="dob" id="dobId" class="form-control dp"
						value=<fmt:formatDate value="${ustud.dob}" pattern="yyyy-MM-dd"/>>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<div>
						<lable class="text-warning font-weight-bold">Student Type</lable>
					</div>


					<input type="radio" name="studType" id="studTypeId" value="regular"
						<c:if test="${ustud.studentType eq 'regular' }">checked="checked"</c:if>>
					Regular <input type="radio" name="studType" id="studTypeId"
						value="lateralentry"
						<c:if test="${ustud.studentType eq 'lateralentry' }">checked="checked"</c:if>>Lateral
					Entry
				</div>

				<div class="col-md-4">

					<c:set var="intr" value="${ustud.interestArea}" />
					<c:set var="splitName" value="${fn:split(intr,', ')}" />
					<div>
						<lable class="text-warning font-weight-bold">Interest Area</lable>
					</div>
					<input type="checkbox" name="interestArea" id="interestAreaId"
						value="art"
						<c:forEach var="name" items="${splitName}"><c:if test="${name eq 'art'}">checked='checked'</c:if></c:forEach>>
					Art <input type="checkbox" name="interestArea" id="interestAreaId"
						value="science"
						<c:forEach var="name1" items="${splitName}"><c:if test="${name1 eq 'science'}">checked='checked'</c:if></c:forEach>>Science
					<input type="checkbox" name="interestArea" id="interestAreaId"
						value="literature"
						<c:forEach var="name2" items="${splitName}"><c:if test="${name2 eq 'literature'}">checked='checked'</c:if></c:forEach>>
					literature
				</div>
			</div>


			<div class="row">
				<div class="col-md-4">
					<lable class="text-warning font-weight-bold">Country</lable>
					<select class="form-control" name="country" id="countryId"
						onchange="getStates()">
						<option value="0">-select-</option>

						<c:forEach items="${countryList}" var="con">
							<option value="${con.countryId}"
								<c:if test="${con.countryId eq ustud.address.country.countryId}">selected="selected"</c:if>>${con.countryName}</option>
						</c:forEach>
					</select>
				</div>
				<div class="col-md-4">
					<lable class="text-warning font-weight-bold">State</lable>
					<select class="form-control" name="state" id="stateId" onchange="getCities()">
						<option value="0">-select-</option>
						<c:if test="${ustud ne null}">
							<c:forEach var="st" items="${uStateList}">
								<option value="${st.stateId}"
									<c:if test="${st.stateId eq ustud.address.state.stateId}">selected="selected"</c:if>>${st.stateName}</option>
							</c:forEach>
						</c:if>
					</select>
				</div>
				<div class="col-md-4">
					<lable class="text-warning font-weight-bold">City</lable>
					<select class="form-control" name="city" id="cityId">
						<option value="0">-select-</option>
						<c:if test="${ustud ne null}">
							<c:forEach var="ct" items="${uCityList}">
								<option value="${ct.cityId}"
									<c:if test="${ct.cityId eq ustud.address.city.cityId}">selected="selected"</c:if>>${ct.cityName}</option>
							</c:forEach>
						</c:if>
					</select>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<lable class="text-warning font-weight-bold">Address</lable>
					<textarea name="addressl" id="addresslId" rows="2" cols="15"
						class="form-control">${ustud.address.address}</textarea>
				</div>
			</div>
	
			<div class="text-center mt-3">
				<input type="submit" value=${ustud ne null ?'Update':'Save'}
					name="collegeName" id="collegeNameId" class="btn btn-success">
				<input class="btn btn-warning" type="reset" value="Reset">
			</div>
	</form>


	<form action="./dateFilter">
	
		<div class="row my-5">
			<div class="col-md-4">
				<lable class="text-warning font-weight-bold">From Date</lable>
					<input type="text" name="fdate" id="fdateId" class="form-control dp">
			</div>	
			<div class="col-md-4">
				<lable class="text-warning font-weight-bold">To Date</lable>
					<input type="text" name="tdate" id="tdateId" class="form-control dp">
			</div>
			<div class="col-md-2">
					<label></label>
					<input type="submit" value="Search" class="form-control btn btn-success">
			</div>	
		</div>
	</form>
	<div class="h3">Student List</div>
	<table class="table table-bordered" id="student_data">
		<thead>
			<tr>
				<th>Sl#</th>
				<th>Roll No</th>
				<th>Name</th>
				<th>Email</th>
				<th>Phone</th>
				<th>College</th>
				<th>Branch</th>
				<th>Cgpa</th>
				<th>Dob</th>
				<th>Type</th>
				<th>Interests</th>
				<th>Address</th>
				<th>Action</th>
			</tr>
		</thead>
		<tbody>

			<c:forEach var="stud" items="${studentList}" varStatus="counter">
				<tr>
					<td>${counter.count}</td>
					<td>${stud.rollNo}</td>
					<td>${stud.name}</td>
					<td>${stud.email}</td>
					<td>${stud.phoneNo}</td>
					<td>${stud.collegeName}</td>
					<td>${stud.branch.branchName}</td>
					<td>${stud.cgpa}</td>
					<td><fmt:formatDate pattern="dd/MM/yy" value="${stud.dob}" />
					</td>
					<td>${stud.studentType}</td>
					<td>${stud.interestArea}</td>
					<td>${stud.address.address}, &nbsp;${ stud.address.country.countryName}, &nbsp;${stud.address.city.cityName}</td>
					<td><a class="text-danger"
						href="http://localhost:8080/JSPAppWithJavaScript/deletestudent?rollNo=${stud.rollNo}"><i
							class="fa-regular fa-trash-can"></i></a>&nbsp;<a class="text-warning"
						href="http://localhost:8080/JSPAppWithJavaScript/updatestudent?rollNo=${stud.rollNo}"><i
							class="fa-regular fa-pen-to-square"></i></a></td>
				</tr>
			</c:forEach>
	</table>

	</div>
</body>

<script type="text/javascript">
	$(function() {
		$("#student_data").dataTable();
	});

	$(document).ready(function() {
		$(".dp").datepicker({
			"format" : "yyyy-m-d"/* ,
											"startDate": "-5m",
											"endDate": "05-15-2020", */
		}

		);
	});

	function getBranchFee() {
		var bId = $('#branchId').val();
		$.ajax({
			url : "./getFeeByBranchId",
			type : "GET",
			data : {
				branchId : bId
			},
			success : function(result) {

				$("#fid").text(result);
			}
		});

	}

	function getStates() {
		var cId = $('#countryId').val();

		$.ajax({
			url : "./getStates",
			type : "GET",
			data : {
				countryId : cId
			},
			success : function(result) {

				$("#stateId").html(result);
			}
		});

	}

	function getCities(){

		var sId = $('#stateId').val();

		$.ajax({
			url : "./getCities",
			type : "GET",
			data : {
				stateId : sId
			},
			success : function(result) {

				$("#cityId").html(result);
			}
		});
		}
	

	function validateRegdForm() {
		var name = $("#nameId").val();
		var phone = $("#phoneId").val();
		var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
		var email = $("#emailId").val();
		var college = $("#collegeNameId").val();
		var branch = $("#branchId option:selected").val();
		var cgpa = $("#cgpaId").val();
		var dob = $("#dobId").val();

		if (name.length < 5) {
			alert("student name should not be less than 5 character long");
			$("#nameId").focus();
			return false;
		}

		else if (!email.match(emailPattern)) {
			alert("email is not valid");
			$("#emailId").focus();
			return false;
		} else if (isNaN(phone) || phone.length != 10) {
			alert("phone no is not a number or less than 10 digits");
			$("#phoneId").focus();
			return false;
		} else if (college == "") {
			alert("privide a college name");
			$("#collegeNameId").focus();
			return false;
		} else if (branch == 0) {
			alert("select a branch");
			return false;
		} else if (!(cgpa >= 0 && cgpa <= 10)) {
			alert("cgpa must be less than 10");
			return false;
		}

		else if (!(new Date().getFullYear() - new Date(dob).getFullYear() >= 15)) {

			alert("age must be greater than 15 years");
			return false;

		} else if (typeof $("input[name='studType']:checked").val() === "undefined") {
			alert("student type must be selected");
			return false;

		} else if (!($('#regdform :checkbox:checked').length >= 1)) {
			alert("must check atleast one interest area");
			return false;
		}

		return true;

	}
</script>
</html>
