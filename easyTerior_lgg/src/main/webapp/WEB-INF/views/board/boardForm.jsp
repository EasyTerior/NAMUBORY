<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%-- JSTL --%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<!-- icons -->
<link
	href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css"
	rel="stylesheet" />
<!-- icons -->
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.min.js"></script>
<style>
body, main, section {
	position: relative;
}
</style>
<script type="text/javascript">
$(document).ready(function() {
    // 회원가입 후 modal 표시
    if (${not empty msgType}) {
        if (${msgType eq "성공 메세지"}) {
            $("#checkType .modal-header.card-header").attr("class", "modal-header card-header bg-success");
        }
        $("#myModal").modal("show");
    }

    // 투표 항목 추가
    var itemCount = 2; // 초기 항목 수 설정

    $("#addItemBtn").click(function() {
        itemCount++; // 항목 수 증가
        var inputField = '<div class="offset-md-1 col-md-11 mb-2" style="display: block;">' +
            '<input type="text" class="form-control vote-item" placeholder="' + (itemCount+1) + '. 항목을 입력하세요">' +
            '</div>';
        var newInputField = $(inputField).clone(); // 새로운 input 요소 생성
        newInputField.find("input").attr("id", "vote-item-" + (itemCount+1)); // 증가된 id 적용 -> 이렇게 하면 input 태그 각각 id값이 달라짐
        $("input[type='text']:last").parent().after(newInputField); // 마지막 input 요소 바로 뒤에 동적으로 입력 필드를 생성하여 쭉쭉 추가됨
    });

    // 페이지 로드 시 checkbox 상태에 따라 입력 필드와 버튼 초기 상태 설정
    if ($("#vote_check").is(":checked")) {
        enableVoteItems();
    } else {
        disableVoteItems();
    }

    // 투표여부 checkbox 상태 변경 시
    $("#vote_check").change(function() {
        if ($(this).is(":checked")) {
            enableVoteItems();
        } else {
            disableVoteItems();
        }
    });

    // '+항목 추가' 버튼 클릭 시
    $("#addItemBtn").click(function() {
        if ($("#vote_check").is(":checked")) {
            enableLastVoteItem();
        }
    });

    function enableVoteItems() {
        // 입력 필드와 버튼을 활성화
        $(".vote-item").prop("disabled", false);
        $("#addItemBtn").prop("disabled", false);
    }

    function disableVoteItems() {
        // 입력 필드와 버튼을 비활성화
        $(".vote-item").prop("disabled", true);
        $("#addItemBtn").prop("disabled", true);
    }

    // 초기 '+항목 추가' 버튼 클릭 시 비활성화
    disableVoteItems();
});

//이미지 업로드
function readURL(input) {
    var file = input.files[0];
    console.log(file);
    if (file != '') {
        var reader = new FileReader();
        reader.readAsDataURL(file);
        reader.onload = function (e) {
            console.log(e.target);
            console.log(e.target.result);
            $('#preview').attr('src', e.target.result);
        }
    }
}   
</script>
<title>EasyTerior</title>
</head>
<body>
	<main class="main">
		<jsp:include page="../common/header.jsp"></jsp:include>
		<jsp:include page="../common/submenu.jsp"></jsp:include>
		<section class="fixed-top container-fluid overflow-auto h-100"
			style="margin: 137px 0 56px 0; padding: 0 0 300px 100px;">
			<!-- 실질 컨텐츠 위치 -->

			<div class="container">
				<div class="row">
					<div class="col-12 mx-auto mt-3 p-2"
						style="background-color: lightgray;">
						<div class="d-flex justify-content-center">
							<h5 class="text-dark">글쓰기</h5>
						</div>
					</div>
				</div>
				<form action="upload_ok?${_csrf.parameterName}=${_csrf.token}"
					method="post" enctype="multipart/form-data">
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" /> <input type="hidden" name="memID"
						value="${sessionScope.memResult.memID}">
					<div class="row mb-4">
						<label for="title"
							class="col-form-label col-md-1 text-center fw-bold">제목</label>
						<div class="col-md-11">
							<input type="text" class="form-control" name="title">
						</div>
					</div>
					<hr>
					<div class="row mb-4">
						<label for="image"
							class="col-form-label col-md-1 text-center fw-bold">사진 추가</label>
						<div class="col-md-11">
							<input type="file" name="file">
						</div>
					</div>
					<div class="row mb-4">
						<label for="content"
							class="col-form-label col-md-1 text-Scenter fw-bold">내용</label>
						<div class="col-md-11">
							<textarea class="form-control" name="content" rows="5"></textarea>
						</div>
					</div>
					<hr>

					<div class="row">
						<label for="content"
							class="col-form-label col-md-1 text-center fw-bold">투표여부</label>
						<div class="col-md-11 d-flex align-items-center">
							<input type="checkbox" name="vote_check" id="vote_check">
						</div>
					</div>

					<div class="row mb-4">
						<div class="offset-md-1 col-md-11 mb-2">
							<span class="fw-bold fs-4">투표 항목</span>
						</div>
						<div class="offset-md-1 col-md-11 mb-2">
							<input type="text" class="form-control vote-item"
								id="vote-item-1" placeholder="1. 항목을 입력하세요">
						</div>
						<div class="offset-md-1 col-md-11 mb-2">
							<input type="text" class="form-control vote-item"
								id="vote-item-2" placeholder="2. 항목을 입력하세요">
						</div>
						<div class="offset-md-1 col-md-11 mb-2">
							<input type="text" class="form-control vote-item"
								id="vote-item-3" placeholder="3. 항목을 입력하세요">
						</div>
						<div class="offset-md-1 col-md-11 mb-2">
							<button id="addItemBtn" type="button" class="btn btn-primary">+항목추가</button>
						</div>
					</div>
					<button type="submit" class="btn btn-primary">글쓰기</button>
			</div>
			</form>
		</section>
		<jsp:include page="../common/footer.jsp"></jsp:include>
	</main>

	<!-- The Modal -->
	<div class="modal fade" id="myModal">
		<!-- animation : fade -->
		<div class="modal-dialog">
			<div id="checkType" class="card modal-content">
				<!-- Modal Header -->
				<div class="modal-header card-header">
					<h4 class="modal-title text-center">${ msgType }</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<!-- Modal body -->
				<div class="modal-body">
					<p id="checkMessage" class="text-center">${ msg }</p>
				</div>
				<!-- Modal footer -->
				<div class="modal-footer mb-5">
					<button type="button" class="btn btn-danger"
						data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">

</script>
</body>
</html>