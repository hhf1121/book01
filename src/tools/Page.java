package tools;

public class Page {
	
	private Integer pageSize=5;//页面容量
	private Integer pageCount;//页数
	private Integer currentPage=1;//当前页面；
	private Integer CountSize;//总条数
	private String page;//easyui
	private String rows;//easyui

	public String getPage() {
		return page;
	}

	public void setPage(String page) {
		this.page = page;
	}

	public String getRows() {
		return rows;
	}

	public void setRows(String rows) {
		this.rows = rows;
	}

	public Integer getPageSize() {
		return pageSize;
	}
	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}
	public Integer getPageCount() {
		return pageCount;
	}
	public Integer getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(Integer currentPage) {
		this.currentPage = currentPage;
	}
	public Integer getCountSize() {
		return CountSize;
	}
	public void setCountSize(Integer countSize) {
		CountSize = countSize;
		if(CountSize%pageSize==0){
			pageCount=CountSize/pageSize;
		}else if(CountSize%pageSize!=0){
			pageCount=CountSize/pageSize+1;
		}
	}
	
	
	

}
