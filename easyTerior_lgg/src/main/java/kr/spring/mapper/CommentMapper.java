package kr.spring.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import kr.spring.entity.Comment;

@Mapper
public interface CommentMapper {
	
	//댓글 입력
    public void addComment(Comment comment);

    //댓글 리스트 출력
	public List<Comment> selectBoardCommentByCode();
}
