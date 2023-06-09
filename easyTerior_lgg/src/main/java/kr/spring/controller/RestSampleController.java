package kr.spring.controller;

import java.io.Console;
import java.util.ArrayList;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.spring.entity.Board;
import kr.spring.entity.Comment;
import lombok.extern.log4j.Log4j;


@RestController
@RequestMapping
@Log4j
public class RestSampleController {

	@GetMapping(value = "/getText", produces = "text/plain; charset=UTF-8")
	public String getText() {
		return "안녕하세요";
	}

	// json데이터와 xml 데이터 모두 사용해줌
	@GetMapping(value = "/getMap", produces = { MediaType.APPLICATION_JSON_UTF8_VALUE,
			MediaType.APPLICATION_XML_VALUE })
	public List<Board> getList() {
		List<Board> list = new ArrayList<Board>();
		Board board = new Board();
		board.setBoardID(10);
		board.setTitle("게시판");
		list.add(board);

		Board board2 = new Board();
		board.setTitle("하이");
		list.add(board);

		return list;
	}

	// ajax 하다보면 내부에 오류가 있는지 헷갈리기에 ResponseEntity 객체 사용
	@GetMapping(value="/check")
	public ResponseEntity<Comment> check(Double height, Double weight){
		
		log.info("height=" + height + ",weight=" + weight);
		
		ResponseEntity<Comment> result = null;
		
		Comment comment = new Comment();
		comment.setCommentContent("hi");
		
		if(height < 150) {
			result = ResponseEntity.status(HttpStatus.BAD_GATEWAY).body(comment);
		} else {
			result = new ResponseEntity<Comment>(comment, HttpStatus.OK);
		}
		return result;
	}
}
