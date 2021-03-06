package pojo;

import java.sql.Timestamp;

public class LibraryBorrow {
	
	private int id;
	private String userName;
	private String bookName;
	private Long userId;
	private int bookId;
	private Timestamp borrowTime;
	private Timestamp bakeTime;
	private String timelag;
	private String readDays;//借阅几天


	public String getTimelag() {
		return timelag;
	}

	public void setTimelag(String timelag) {
		this.timelag = timelag;
	}

	public String getReadDays() {
		return readDays;
	}

	public void setReadDays(String readDays) {
		this.readDays = readDays;
	}

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getBookName() {
		return bookName;
	}
	public void setBookName(String bookName) {
		this.bookName = bookName;
	}
	public int getBookId() {
		return bookId;
	}
	public void setBookId(int bookId) {
		this.bookId = bookId;
	}
	public Timestamp getBorrowTime() {
		return borrowTime;
	}
	public void setBorrowTime(Timestamp borrowTime) {
		this.borrowTime = borrowTime;
	}
	public Timestamp getBakeTime() {
		return bakeTime;
	}
	public void setBakeTime(Timestamp bakeTime) {
		this.bakeTime = bakeTime;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	@Override
	public String toString() {
		return "Borrow [id=" + id + ", userName=" + userName + ", bookName=" + bookName + ", userId=" + userId
				+ ", bookId=" + bookId + ", borrowTime=" + borrowTime + ", bakeTime=" + bakeTime + "]";
	}
	
	
	
}
