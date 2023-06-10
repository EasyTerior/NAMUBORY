package kr.spring.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.spring.entity.Board;
import kr.spring.mapper.BoardMapper;

@RequestMapping("/board")
@RestController
public class BoardRestController {

	@Autowired
	private BoardMapper boardMapper;

	// 게시글 전체 리스트 보기 (비동기) 요청 URL - /boardList.do
	@GetMapping("/all")
	public List<Board> boardList() {
		List<Board> list = boardMapper.boardList();
		return list; // JSON Object → JSON Array로 return
	}

	// 게시글 입력 기능 : (비동기) 요청 URL - /boardInsert.do
	// @PostMapping("/boardInsert.do")
	@PostMapping("/new")
	public void boardInsert(HttpServletRequest request, RedirectAttributes rttr, HttpSession session, Board board) { // RestController
		MultipartRequest multi = null;

		int fileMaxSize = 100 * 1024 * 1024; // 파일 최대 크기 - 100MB
		String savePath = request.getRealPath("D:\\NAMUBORY\\easyTerior_lgg\\src\\main\\webapp\\resources\\upload");
		String encType = "UTF-8";
		// 중복제거 객체
		DefaultFileRenamePolicy dfrp = new DefaultFileRenamePolicy();

		// 파일 업로드 객체 생성
		// 매개변수 - 요청데이터, 저장경로, 인코딩, 파일명중복제거
		try {
			multi = new MultipartRequest(request, savePath, fileMaxSize, encType, dfrp);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		String newImage = "";

		// 사용자가 업로드한 파일 가져오기
		File file = multi.getFile("file");

		if (file != null) {
			// 사용자가 파일을 올렸을 때
			String ext = file.getName();
			// .뒤에 있는 확장자만 가져오기
			ext = ext.substring(ext.lastIndexOf(".") + 1);
			// .뒤에 확장자를 대문자로 다 바꾸기
			ext = ext.toUpperCase();

			boolean isCheck = ext.equals("PNG") || ext.equals("JPG") || ext.equals("GIF");

			if (!isCheck) {
				if (file.exists()) {
					file.delete();
				}
				// 이미지 파일이 아닐때
				/*
				 * rttr.addFlashAttribute("msgType", "실패 메세지"); rttr.addFlashAttribute("msg",
				 * "실패~");
				 */
			} else {
				// 이미지 파일 일 때
				newImage = file.getName();
				
			}
		}
		
		board.setBoardImage(newImage);
		boardMapper.boardInsert(board);

	}
	
	// 테스트 코드
	@PostMapping("/new2")
	public void boardInsert2(HttpServletRequest request, RedirectAttributes rttr, HttpSession session, Board board) { // RestController
		
		MultipartRequest multi = null;

		int fileMaxSize = 100 * 1024 * 1024; // 파일 최대 크기 - 100MB
		String savePath = request.getRealPath("D:\\NAMUBORY\\easyTerior_lgg\\src\\main\\webapp\\resources\\upload");
		String encType = "UTF-8";
		// 중복제거 객체
		DefaultFileRenamePolicy dfrp = new DefaultFileRenamePolicy();

		// 파일 업로드 객체 생성
		// 매개변수 - 요청데이터, 저장경로, 인코딩, 파일명중복제거
		try {
			multi = new MultipartRequest(request, savePath, fileMaxSize, encType, dfrp);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		String newImage = "";

		// 사용자가 업로드한 파일 가져오기
		File file = multi.getFile("file2");

		if (file != null) {
			// 사용자가 파일을 올렸을 때
			String ext = file.getName();
			// .뒤에 있는 확장자만 가져오기
			ext = ext.substring(ext.lastIndexOf(".") + 1);
			// .뒤에 확장자를 대문자로 다 바꾸기
			ext = ext.toUpperCase();

			boolean isCheck = ext.equals("PNG") || ext.equals("JPG") || ext.equals("GIF");

			if (!isCheck) {
				if (file.exists()) {
					file.delete();
				}
				// 이미지 파일이 아닐때
				/*
				 * rttr.addFlashAttribute("msgType", "실패 메세지"); rttr.addFlashAttribute("msg",
				 * "실패~");
				 */
			} else {
				// 이미지 파일 일 때
				newImage = file.getName();
				
			}
		}
		
		board.setBoardImage(newImage);
		boardMapper.boardInsert(board);

	}
	

	// 게시글 삭제 기능 : (비동기) 요청 URL - /boardDelete.do
	// @GetMapping("/boardDelete.do") // type을 GET 에서 DELETE로 바꿨으니 맞춰야 함.
	@DeleteMapping("/{idx}")
	// public void boardDelete(@RequestParam("idx") int idx) { // RestController 에서
	// @ResonseBody 삭제
	public void boardDelete(@PathVariable("idx") int idx) {
		boardMapper.boardDelete(idx);
	}

	// 게시글 수정하기 기능 : (비동기) 요청 URL - /boardUpdate.do
	// @PostMapping("/boardUpdate.do") // RestController 에서 @ResonseBody 삭제
	// public void boardUpdate(Board b) { // 기본 생성자가 있어야 하고 setter 있어야 함.
	@PutMapping("/update")
	public void boardUpdate(@RequestBody Board b) { // Board 객체로 묶기 위해 @RequestBody 필수
		boardMapper.boardUpdate(b);
	}

	// 게시글 조회수 올리는 기능 : (비동기) 요청 URL - /boardCount.do
	// @GetMapping("/boardCount.do") // RestController 에서 @ResonseBody 삭제
	// public void boardCount(@RequestParam("idx") int idx) {
	@PutMapping("/count/{idx}")
	public void boardCount(@PathVariable("idx") int idx) {
		boardMapper.boardCount(idx);
	}

}
