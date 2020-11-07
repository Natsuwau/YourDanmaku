package yours.front.service;

import yours.pojo.FrontUser;
import yours.utils.MsgException;

//前台用户服务
public interface FrontUserService  extends BaseService<FrontUser>{

    //登录操作
    public FrontUser login(String id,String password)throws MsgException,Exception;

    //注册操作
    public String register(FrontUser one)throws Exception;

    //修改密码
    public String changePassword(String id,String oldPassword,String newPassword)throws Exception;

    //修改头像
    public String changeIcon(String id,String newIconUrl)throws Exception;

    //增加硬币数
    public int addCoin(String uid,int dCoin) throws MsgException,Exception;
}
