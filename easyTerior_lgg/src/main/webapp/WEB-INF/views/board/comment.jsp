<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</head>
<body>
	<div class="container">
		<form id="commentForm" name="commentForm" method="post">
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />
			<div>
				<div>
					<span><strong>Comments</strong></span> <span id="cCnt"></span>
				</div>
				<div>
					<table class="table">
						<tr>
							<td><textarea style="width: 1100px" rows="3" cols="30"
									id="commentContent" name="commentContent"
									placeholder="댓글을 입력하세요"></textarea> <br>
								<div>
									<button type="button" class="btn pull-right btn-success"
										onclick="fn_comment()">등록</button>

								</div></td>
						</tr>
					</table>
				</div>
			</div>
			<input type="hidden" id="boardID" name="boardID"
				value="${board.boardID}" /> <input type="hidden" id="memID"
				name="memID" value="${sessionScope.memResult.memID}" />
		</form>
	</div>
	<div class="container">
		<form id="commentListForm" name="commentListForm" method="post">
			<div id="commentList"></div>
		</form>
	</div>

	<script type="text/javascript">
		//댓글 등록하기(Ajax) 
		//기존 코드
		/* 		function fn_comment() {
		 var url = "/comment/addComment.do";
		 var params = $("#commentForm").serialize();

		 $.ajax({
		 type : "POST",
		 url : url,
		 data : params,
		 success : function(data) {
		 if (data === "success") {
		 getCommentList();
		 $("#comment").val("");
		 }
		 },
		 error : function(xhr, status, error) {
		 var errorMessage = "code: " + xhr.status + "\n"
		 + "message: " + xhr.responseText;
		 alert(errorMessage);
		 }
		 });
		 } */
		// 예시 코드
		function fn_comment() {
			var url = "/comment/addComment";
			var params = $("#commentForm").serialize();

			$.ajax({
				type : "POST",
				url : url,
				data : params,
				success : function(data) {
					console.log(data); // Output the response to the console
					$("#comment").val("");
				},
				error : function(xhr, status, error) {
					var errorMessage = "code: " + xhr.status + "\n"
							+ "message: " + xhr.responseText;
					alert(errorMessage);
				}
			});
		}

		// 초기 페이지 로딩시 댓글 불러오기

		/* 	$(function() {

				 getCommentList(); 

			}); */

		// 댓글 불러오기(Ajax)
		/*  function getCommentList() {
			    var url = "/comment/commentList.do";
			    var params = $("#commentForm").serialize();

			    $.ajax({
			        type: 'GET',
			        url: url,
			        dataType: "json",
			        data: params,
			        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			        success: function(data) {
			            var html = "";
			            var cCnt = data.length;

			            if (data.length > 0) {
			                for (var i = 0; i < data.length; i++) {
			                    html += "<div>";
			                    html += "<div><table class='table'><h6><strong>" + data[i].writer + "</strong></h6>";
			                    html += data[i].comment + "<tr><td></td></tr>";
			                    html += "</table></div>";
			                    html += "</div>";
			                }
			            } else {
			                html += "<div>";
			                html += "<div><table class='table'><h6><strong>등록된 댓글이 없습니다.</strong></h6>";
			                html += "</table></div>";
			                html += "</div>";
			            }

			            $("#cCnt").html(cCnt);
			            $("#commentList").html(html);
			        },
			        error: function(request, status, error) {
			            // 에러 처리
			        }
			    });
			} */
		/* 	function getCommentList() {
				  var url = "/comment/commentList.do";

				  $.ajax({
				    type: 'GET',
				    url: url,
				    dataType: "json",
				    success: function(data) {
				      var html = "";
				      var cCnt = data.length;

				      if (data.length > 0) {
				        for (var i = 0; i < data.length; i++) {
				          html += "<div>";
				          html += "<div><table class='table'><h6><strong>" + data[i].writer + "</strong></h6>";
				          html += data[i].comment + "<tr><td></td></tr>";
				          html += "</table></div>";
				          html += "</div>";
				        }
				      } else {
				        html += "<div>";
				        html += "<div><table class='table'><h6><strong>No comments available.</strong></h6>";
				        html += "</table></div>";
				        html += "</div>";
				      }

				      $("#cCnt").html(cCnt);
				      $("#commentList").html(html);
				    },
				    error: function(request, status, error) {
				      // handle errors
				    }
				  });
				} */
	</script>

</body>
</html>
