package kr.spring.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;


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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.spring.entity.Board;
import kr.spring.entity.Comment;
import kr.spring.entity.Member;
import kr.spring.mapper.BoardMapper;
import kr.spring.mapper.CommentMapper;
import kr.spring.mapper.MemberMapper;

@Controller
public class BoardRestController2 { // 서버 기능들

	@Autowired
	private BoardMapper boardMapper;
	@Autowired
	private CommentMapper commentMapper;

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

	// 업로드로 가는 메소드
	@GetMapping("/upload")
	public void form() {
	}

	@PostMapping("/upload_ok")
	public String upload(@RequestParam("file") MultipartFile file, Board board, HttpServletRequest request) {
		
		// 투표 항목 개수 추출
	    //int itemCount = Integer.parseInt(request.getParameter("itemCount"));
		
		String fileRealName = file.getOriginalFilename(); // 파일명을 얻어낼 수 있는 메서드!
		long size = file.getSize(); // 파일 사이즈

		System.out.println("파일명 : " + fileRealName);
		System.out.println("용량크기(byte) : " + size);
		// 서버에 저장할 파일이름 fileextension으로 .jsp이런식의 확장자 명을 구함
		String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."), fileRealName.length());
		//이고관PC 로컬 주소 - 수정해야합니다.
		String uploadFolder = "D:\\NAMUBORY\\easyTerior_lgg\\src\\main\\webapp\\resources\\upload";

		/*
		 * 파일 업로드시 파일명이 동일한 파일이 이미 존재할 수도 있고 사용자가 업로드 하는 파일명이 언어 이외의 언어로 되어있을 수 있습니다.
		 * 타인어를 지원하지 않는 환경에서는 정산 동작이 되지 않습니다.(리눅스가 대표적인 예시) 고유한 랜덤 문자를 통해 db와 서버에 저장할
		 * 파일명을 새롭게 만들어 준다.
		 */

		UUID uuid = UUID.randomUUID();
		System.out.println(uuid.toString());
		String[] uuids = uuid.toString().split("-");

		String uniqueName = uuids[0];
		System.out.println("생성된 고유문자열 : " + uniqueName);
		System.out.println("확장자명 : " + fileExtension);
		
		String fileName = uniqueName + fileExtension; //확장자까지 그냥 하나의 변수로 묶음

		// File saveFile = new File(uploadFolder+"\\"+fileRealName); uuid 적용 전

		File saveFile = new File(uploadFolder + "\\" + uniqueName + fileExtension); // 적용 후
		try {	
			file.transferTo(saveFile);
			board.setUniqueName(fileName);
			boardMapper.boardInsert(board); // 실제 파일 저장메서드(filewriter 작업을 손쉽게 한방에 처리해준다.)
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "redirect:/boardList.do";
	}

}
