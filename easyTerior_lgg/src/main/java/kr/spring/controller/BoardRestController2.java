package kr.spring.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model; // public String boardList (Model model)
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping; // @RequestMapping("/boardList.do")
import org.springframework.web.bind.annotation.RequestParam; // @RequestParam 을 통해서 Board 의 하나 혹은 해당에 없는 걸 받을 때 request로 받아서 매개변수 처리
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.entity.Board;
import kr.spring.mapper.BoardMapper;

@Controller
public class BoardRestController2 { // 서버 기능들

	@Autowired
	private BoardMapper boardMapper;

	// 게시판 이동
	@GetMapping("/boardList.do")
	public String boardList(Model model) {

		List<Board> list = boardMapper.boardList();

		model.addAttribute("list", list);

		return "board/boardList";
	}

	// 게시판 글 쓰기 폼
	@GetMapping("/boardForm.do")
	public String boardForm() {
		return "board/boardForm";
	}

	// 게시판 글 쓰기
	@PostMapping("/boardInsert.do")
	public String boardInsert(Board board) {
		boardMapper.boardInsert(board);
		return "redirect:/boardList.do";
	}

	// 게시글 상세보기
	@GetMapping("/boardContent.do/{boardID}")
	public String boardContent(@PathVariable("boardID") int boardID, Model model) {

		Board board = boardMapper.boardContent(boardID);
		model.addAttribute("board", board);
		return "board/boardContent";
	}


	}


