package pojo;

public class listNo {
	private int id;
	private String listName;
	private String path;
	private int yesNo;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getListName() {
		return listName;
	}
	public void setListName(String listName) {
		this.listName = listName;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public int getYesNo() {
		return yesNo;
	}
	public void setYesNo(int yesNo) {
		this.yesNo = yesNo;
	}
	@Override
	public String toString() {
		return "List [id=" + id + ", listName=" + listName + ", path=" + path + ", yesNo=" + yesNo + "]";
	}

	
	
}
