package pojo;

import java.util.ArrayList;
import java.util.List;

public class MyTreeNode {

    private Long id;

    private String levelType;

    private String code;

    private String text;

    private String parentCode;

    private List<MyTreeNode> children=new ArrayList<MyTreeNode>();

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getParentCode() {
        return parentCode;
    }

    public void setParentCode(String parentCode) {
        this.parentCode = parentCode;
    }

    public List<MyTreeNode> getChildren() {
        return children;
    }

    public void setChildren(List<MyTreeNode> children) {
        this.children = children;
    }

    public String getLevelType() {
        return levelType;
    }

    public void setLevelType(String levelType) {
        this.levelType = levelType;
    }

    @Override
    public String toString() {
        return "MyTreeNode{" +
                "code='" + code + '\'' +
                ", text='" + text + '\'' +
                ", parentCode='" + parentCode + '\'' +
                ", children=" + children +
                '}';
    }
}
