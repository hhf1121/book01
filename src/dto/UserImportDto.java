package dto;

import pojo.User;

public class UserImportDto extends User {

    private String errInfo;

    public String getErrInfo() {
        return errInfo;
    }

    public void setErrInfo(String errInfo) {
        this.errInfo = errInfo;
    }
}
