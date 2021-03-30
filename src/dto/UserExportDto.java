package dto;

import pojo.User;

public class UserExportDto extends User {

    //注册时间
    private String registerTime;
    //导出字段
    private String userColums;

    public String getRegisterTime() {
        return registerTime;
    }

    public void setRegisterTime(String registerTime) {
        this.registerTime = registerTime;
    }

    public String getUserColums() {
        return userColums;
    }

    public void setUserColums(String userColums) {
        this.userColums = userColums;
    }
}
