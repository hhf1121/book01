package dto;

import java.io.Serializable;

/**
 * 导出字段处理类
 */
public class UserColumnDto implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 字段英文
	 */
	private String field;
	
	/**
	 * 字段中文
	 */
	private String title;
	
	/**
	 * 是否添加Text
	 */
	private Boolean isText;
	
	/**
	 * 是否导出
	 */
	private Boolean isExport;

	public String getField() {
		return field;
	}

	public void setField(String field) {
		this.field = field;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Boolean getIsText() {
		return isText;
	}

	public void setIsText(Boolean isText) {
		this.isText = isText;
	}

	public Boolean getIsExport() {
		return isExport;
	}

	public void setIsExport(Boolean isExport) {
		this.isExport = isExport;
	}
	
	

}
