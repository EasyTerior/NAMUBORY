<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%-- JSTL --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	$(document).ready(function(){
		// 회원가입 후 modal 표시
		if(${ not empty msgType}){
			if(${msgType eq "성공 메세지"}){ // MemberController.java에서 rttr.addFlashAttribute("msgType", "성공 메세지");로 보냄
				$("#checkType .modal-header.card-header").attr("class", "modal-header card-header bg-success");
			}
			$("#myModal").modal("show");
		}
		
	});
</script>
<title>EasyTerior</title>
</head>
<body>
	<main class="main">
		<jsp:include page="../common/header.jsp"></jsp:include>
		<jsp:include page="../common/submenu.jsp"></jsp:include>
		<section class="fixed-top container-fluid overflow-auto h-100"
			style="margin: 137px 0 56px 0; padding: 0 0 400px 0;">
			<h1 class="text-center mb-3 fw-bold" style="margin-top: 30px;">글
				상세</h1>
			<!-- 실질 컨텐츠 위치 -->

			<div class="container px-5">
				<br>
				<div class="row">
					<div class="col-md-12 text-end">
						<div class="d-flex justify-content-end align-items-center">
							<p class="me-3">
								<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
									value="${board.createdAt}" />
							</p>
							<p>${board.memID}</p>
						</div>
					</div>
				</div>




				<div class="d-flex justify-content-end align-items-center">
					<a href="boardList.do"><button class="btn btn-primary">목록으로</button></a>
				</div>
				<h3 class="fw-bold">${board.title}</h3>
				<hr>
				<br> <br> <br>
				<div
					style="display: flex; justify-content: center; align-items: center;">
					<span>사진 위치</span>
				</div>
				<br> <br> <br> <br>
				<!-- 추후 삭제 -->
				<h5>${board.content }</h5>
				<hr>

				<jsp:include page="../board/comment.jsp"></jsp:include>
				





			</div>






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
				<div class="modal-footer">
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