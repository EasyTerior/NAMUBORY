-- 회원 테이블 생성
CREATE TABLE member(
	memIdx INT,
	memID VARCHAR(50) NOT NULL,
	memPassword VARCHAR(50) NOT NULL,
	memName VARCHAR(50) NOT NULL,
	memNickname VARCHAR(50),
	memPhone VARCHAR(50),
	memEmail VARCHAR(150),
	memAddress VARCHAR(150),
	memProfile VARCHAR(150), -- photo가 아니라 경로 저장용. 
	PRIMARY KEY(memID) --  기본키
);


-- DROP TABLE member;
SELECT * FROM member;
DELETE FROM member;

-- admin 계정 추가?
SET @nextIdx = (SELECT IFNULL(MAX(memIdx) + 1, 1) FROM member);  -- 자동으로 idx 추가하면서 생성.
INSERT INTO member(memIdx, memID, memPassword, memName, memNickname, memPhone, memEmail, memAddress, memProfile)
VALUES (@nextIdx, 'admin', '1234', '관리자', 'admin관리자', '010-0000-0000', 'admin@admin.com', '주소', '');


-- 게시판 테이블 생성
CREATE TABLE Board (
    boardID INT(11) NOT NULL AUTO_INCREMENT,
    title VARCHAR(50) NOT NULL,
    content VARCHAR(2000) NOT NULL,
    boardImage VARCHAR(50),
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    views INT(11) DEFAULT 0,
    memID VARCHAR(50) NOT NULL,
    voteContent1 VARCHAR(2000),
    voteContent2 VARCHAR(2000),
    count1 int default 0,
    count2 int default 0,
    PRIMARY KEY (boardID)
);



select * from Board;
DELETE FROM Board;
DROP TABLE Board;

SELECT * FROM Board
		ORDER BY
		createdAt DESC;



-- 댓글 테이블 생성;
CREATE TABLE Comment (
    commentID INT(11) NOT NULL AUTO_INCREMENT,
    commentContent VARCHAR(2000) NOT NULL,
    writeAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    memID VARCHAR(50) NOT NULL,
    boardID INT(11) NOT NULL,
    PRIMARY KEY(commentID)
);


drop table Comment;
select * from Comment;
DELETE FROM Comment;