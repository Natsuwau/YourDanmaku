package yours.pojo;


//视频类型
public class FrontVideoType {

//    视频类型转换
public static String convertTypeCodeToName(String code)
{
    if (code==null)
    {
        return "N/A";
    }
    switch (code.toUpperCase()){
        case "ACG":return "动漫/番剧";

        case"MOVIE":return "影视频道";

        case "SG":return "科技/游戏";

        case "MAD":return "鬼畜专区";

        case "FUN":return "时尚/娱乐";

        case "MUSIC":return "音乐/MV";

        case"OTHER":return "其他";

        default:
            break;
    }

    return "N/A";
}

//展示类型转换
    public static String convertShowTypeCodeToName(String code)
    {
        if (code==null){
            return "N/A";
        }
        switch (code.toUpperCase()){
            case "@HOT":return "热门";

            case "@NEW":return "最新";

            case "@LIKE":return "喜欢";

            case "@RECOMMEND":return "推荐";

            default:
                break;

        }
        return "N/A";
    }
    //视频类型
    public static  String[] TYPES={"ACG","MOVIES","SG","MAD","FUN","MUSIC","OTHER"};

    //视频类型+@
    public static String[] TYPES_PRO={"@ACG","@MOVIES","@SG","@MAD","@FUN","@MUSIC","@OTHER"};

    //首页展示类型
    public static String[]SHOW_TYPES={"@HOT","@NEW","@LIKE","@RECOMMEND"};
}
