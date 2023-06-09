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
.card img {
  max-width: 100%;
  max-height: 200px;
  object-fit: contain;
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
			style="margin: 137px 0 56px 0; padding: 0 0 56px 100px;">
			<h1 class="text-center mb-3 fw-bold" style="margin-top: 30px;">커뮤니티</h1>
			<!-- 실질 컨텐츠 위치 -->
			<div class="container-fluid"
				style="min-height: 100vh; margin-bottom: 200px;">

				<div class="container">
					<div class="row">
						<c:if test="${not empty sessionScope.memResult}">
							<div
								class="col-12 d-flex justify-content-between align-items-center mb-3">
								<div></div>
								<!-- 이 공백 div를 추가하여 글쓰기 +를 오른쪽으로 밀 수 있다. -->
								<div class="h5 ms-auto">
									<a href="boardForm.do" class="text-decoration-none text-dark">
										<span>글쓰기 +</span>
									</a>
								</div>
							</div>
						</c:if>
					</div>




					<div class="row">
						<c:forEach var="model" items="${list}" varStatus="status">
							<c:if test="${status.index % 2 == 0}">
								<div class="row">
							</c:if>

							<div class="col-md-6">
								<div class="card mb-3">
									<img src="${pageContext.request.contextPath}/resources/upload/${model.boardImage}" alt="이미지">
									<div class="card-body">
										<h5 class="card-title fw-bold">
											<a href="boardContent.do/${model.boardID}"
												class="text-decoration-none text-dark"> <c:out
													value="${model.title}" />
											</a>
										</h5>
										<p class="card-text">
											<c:out value="${model.content}" />
											<br> <a href="#">더보기</a>
										</p>
									</div>
								</div>
							</div>

							<c:if test="${status.index % 2 == 1 || status.last}">
					</div>
					</c:if>
					</c:forEach>
				</div>






			</div>
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