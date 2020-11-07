package yours.info;

public class SysInfo {

    /**shiro_MD5加密次数*/
    public static final int SHIRO_MD5_HASHITERATIONS = 128;

    /**系统用户默认密码*/
    public static final String SYSUSER_DEFAULT_PASSWORD = "12580";

    /**系统超级管理员id*/
    public static final String SYSUSER_SUPER_ADMIN = "admin";

    /**系统作为一个用户，在数据库中的用户id*/
    public static final String SYSTEM_DATABASE_ID = "system";

    /**默认分页页面大小*/
    public static final int PAGE_INFO_DEFAULT_SIZE = 5;

    /**servletContext屏蔽字name*/
    public static final String HATE_WORD_VALI_INFO_NAME = "HateWordInfo";

    /**登录用户session名*/
    public static final String FRONT_USER_SESSION_NAME = "sessionUser";

    /**用户上传视频临时信息session*/
    public static final String FRONT_TEMP_VIDEO_SESSION_NAME = "tempVideoInfo";

    /**登录用户ID非法字符数组*/
    public static final String[] FRONT_USER_ID_BAN_STRS = {" ","<",">","￥","\"","="};

    /**图片默认上传目录*/
    public static final String IMG_UPLOAD_DIRECTORY = "D:\\classmanger\\data\\img\\";

    /**视频默认上传目录[废弃,使用项目内部文件夹]*/
    @Deprecated
    public static final String VIDEO_UPLOAD_DIRECTORY = "D:\\classmanger\\data\\video\\";

    /**视频上传相对目录，项目内部文件夹[不得已而用,项目清空上传文件会丢失]*/
    public static final String VIDEO_UPLOAD_NEW_DIRECTORY = "/assets/uploadData/video";

    /**cms用户头像文件名前缀*/
    public static final String SYSUSER_ICON_PREFIX = "CMSUser";
    /**front用户头像文件名前缀*/
    public static final String FRONT_ICON_PREFIX = "FrontUser";
    /**front视频文件名前缀*/
    public static final String FRONT_VIDEO_PREFIX = "FrontVideo";
    /**front视频封面图片文件名前缀*/
    public static final String FRONT_VIDEO_COVER_PREFIX = "VideoCover";
    /**front视频预览图片文件名前缀*/
    public static final String FRONT_VIDEO_PIC_PREFIX = "VideoPic";
}

