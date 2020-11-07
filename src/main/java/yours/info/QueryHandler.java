package yours.info;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * 查询条件控制类 ,服务于mybatis Mapper.xml 语法<br>
 * limit分页适用于mysql数据库
 * @author Mine
 * @since 2016年11月9日_下午2:21:06
 */
public class QueryHandler {
    private String whereSentence = null;// where条件语句
    private String limitSentence = null;// limit分页条件语句
    private String orderBySentence = null;// 排序语句

    private boolean canSet = true;// 判断是否执行set()方法;

    private List<String> whereList = null;// 临时存放查询条件
    private List<String> orderByList = null;// 临时存放查询条件

    private Integer pageNumber = null;
    private Integer pageSize = null;

    // 设置是否需要拼接 where 或 order by 关键字
    private boolean needWhereWord = true;
    private boolean needOrderByWord = true;

    private Map<String, Object> params; // 可能会附加的其他参数

    private String whereSentenceNoWhereWord = null;// where条件语句

    private QueryHandler() {
    }

    /**
     * 添加附加参数
     */
    public QueryHandler put(String name, Object value) {
        if (params == null) {
            params = new HashMap<String, Object>();
        }
        params.put(name, value);
        return this;
    }

    /**
     * QueryHandler创建方法
     */
    public static QueryHandler create() {
        return new QueryHandler();
    }

    /**
     * 创建并设置语句拼接时不需要 WHERE 关键字
     */
    public static QueryHandler creatWithNotNeedWhereWord() {
        return new QueryHandler().setNeedWhereWord(false);
    }
    /**
     * 创建并设置语句拼接时不需要 ORDER BY 关键字
     */
    public static QueryHandler creatWithNotNeedOrderByWord() {
        return new QueryHandler().setNeedOrderByWord(false);
    }
    /**
     * or "组"即带"()"以区分优先级 模糊 开始--- 未完全测试
     */
    public QueryHandler orColumnLikeWithGroup(String ColumnName, String key) {
        this.addWhereList("OR (", ColumnName, "LIKE", "%" + key + "%");
        return this;
    }

    /**
     * and "组"即带()以区分优先级  模糊 开始 --- 未完全测试
     */
    public QueryHandler andColumnLikeWithGroup(String ColumnName, String key) {
        this.addWhereList("AND (", ColumnName, "LIKE", "%" + key + "%");
        return this;
    }

    /**
     * and "组"即带()以区分优先级  模糊 开始 --- 未完全测试
     */
    public QueryHandler andColumnEqualWithGroup(String ColumnName, String key) {
        this.addWhereList("AND (", ColumnName, "=", key);
        return this;
    }

    /**
     * 组结束--- 未完全测试
     */
    public QueryHandler endGroup() {
        whereList.add(" ) ");
        return this;
    }

    /**
     * or + 模糊
     */
    public QueryHandler orColumnLike(String ColumnName, String key) {
        this.addWhereList("OR", ColumnName, "LIKE", "%" + key + "%");
        return this;
    }

    /**
     * and + 模糊
     */
    public QueryHandler andColumnLike(String ColumnName, String key) {
        this.addWhereList("AND", ColumnName, "LIKE", "%" + key + "%");
        return this;
    }

    /**
     * or + =
     */
    public QueryHandler orColumnEqual(String ColumnName, String key) {
        this.addWhereList("OR", ColumnName, "=", key);
        return this;
    }

    /**
     * and + =
     */
    public QueryHandler andColumnEqual(String ColumnName, String key) {
        this.addWhereList("AND", ColumnName, "=", key);
        return this;
    }

    /**
     * or + =
     */
    public QueryHandler orColumnNotEqual(String ColumnName, String key) {
        this.addWhereList("OR", ColumnName, "!=", key);
        return this;
    }

    /**
     * and + =
     */
    public QueryHandler andColumnNotEqual(String ColumnName, String key) {
        this.addWhereList("AND", ColumnName, "!=", key);
        return this;
    }

    /**
     * and 自己选择符号
     */
    public QueryHandler andColumnMark(String ColumnName, String operMark,
                                      String key) {
        this.addWhereList("AND", ColumnName, operMark, key);
        return this;
    }

    /**
     * or 自己选择符号
     */
    public QueryHandler orColumnMark(String ColumnName, String operMark,
                                     String key) {
        this.addWhereList("OR", ColumnName, operMark, key);
        return this;
    }

    /**
     * or时间范围
     */
    public QueryHandler orColumnDateBetween(String ColumnName,
                                            String startDate, String endDate) {
        return this.addWhereListWithDate("OR", ColumnName, startDate, endDate);
    }

    /**
     * and时间范围
     */
    public QueryHandler andColumnDateBetween(String ColumnName,
                                             String startDate, String endDate) {
        return this.addWhereListWithDate("AND", ColumnName, startDate, endDate);
    }

    /**
     * 拼接时间选择
     */
    public QueryHandler addWhereListWithDate(String oper, String ColumnName,
                                             String startDate, String endDate) {
        if (canSet == false) {
            throw new RuntimeException("无法设置!!!");
        }
        if (whereList == null) {
            whereList = new ArrayList<String>();
        }
        if ((endDate == null || "".equals(endDate)) && (startDate == null || "".equals(startDate))) {// 不判断
            return this;
        }
        if (startDate == null || "".equals(startDate)) {
            whereList.add(oper + " " + ColumnName + " < '" + endDate + "'");
        } else if (endDate == null || "".equals(endDate)) {
            whereList.add(oper + " " + ColumnName + " > '" + startDate + "'");
        } else {
            whereList.add(oper + " " + ColumnName + " > '" + startDate
                    + "' AND " + ColumnName + " < '" + endDate + "'");
        }
        return this;
    }

    /**
     * and in 选择
     */
    public QueryHandler andColumnIn(String ColumnName, Set<String> keys) {

        int size = keys.size();
        StringBuilder temp = new StringBuilder();
        int i = 0;
        for (String str : keys) {
            temp.append("'");
            temp.append(str);
            temp.append("'");
            if (i != (size - 1)) {
                temp.append(",");
            }
            i++;
        }
        return this.addWhereList("AND", ColumnName, "IN", temp.toString());
    }

    /**
     * or in 选择
     */
    public QueryHandler orColumnIn(String ColumnName, Set<String> keys) {
        int size = keys.size();
        StringBuilder temp = new StringBuilder();
        int i = 0;
        for (String str : keys) {
            temp.append("'");
            temp.append(str);
            temp.append("'");
            if (i != (size - 1)) {
                temp.append(",");
            }
            i++;
        }
        return this.addWhereList("OR", ColumnName, "IN", temp.toString());
    }

    /**
     * 自己选择
     */
    public QueryHandler addWhereList(String oper, String ColumnName,
                                     String operMark, String key) {
        if (canSet == false) {
            throw new RuntimeException("无法设置!!!");
        }
        if (whereList == null) {
            whereList = new ArrayList<String>();
        }

        if ("in".equalsIgnoreCase(operMark)) {
            whereList.add(oper + " " + ColumnName + " " + operMark + " (" + key
                    + " )");
            return this;
        }
        whereList.add(oper + " " + ColumnName + " " + operMark + " '" + key
                + "'");
        return this;
    }

    /**
     * 指定列名 降序
     */
    public QueryHandler OrderByDESC(String columnName) {
        this.OrderBy(columnName, "DESC");
        return this;
    }
    /**
     * 指定列名  升序
     */
    public QueryHandler OrderByASC(String columnName) {
        this.OrderBy(columnName, "ASC");
        return this;
    }

    /**
     * 分页,传入页号以及页面大小
     */
    public QueryHandler limit(int pageNumber, int pageSize) {
        if (canSet == false) {
            throw new RuntimeException("无法设置!!!");
        }
        if (pageNumber < 1) {
            pageNumber = 1;
        }
        if (pageSize < 1) {
            pageSize = 5;
        }

        this.pageNumber = pageNumber;
        this.pageSize = pageSize;
        int startIndex = (pageNumber - 1) * pageSize;// 计算开始索引

        limitSentence = " LIMIT " + startIndex + "," + pageSize + " ";
        return this;
    }

    /**
     * 显示前pageSize项
     */
    public QueryHandler limitByPageSize(int pageSize) {
        if (canSet == false) {
            throw new RuntimeException("无法设置!!!");
        }
        if (pageSize < 1) {
            pageSize = 5;
        }
        this.pageNumber = 1;
        this.pageSize = pageSize;
        limitSentence = " LIMIT " + pageSize + " ";
        return this;
    }

    /**
     * 结束条件输入,之后不能再修改,会抛异常,除非clear()
     */
    public QueryHandler set() {
        if (canSet == false) {
            throw new RuntimeException("无法设置!!!");
        }
        StringBuilder temp = null;// 线程非安全就可以
        int listSize = 0;
        // 生成where语句
        if (whereList != null && whereList.size() > 0) {
            // 初始化temp
            temp = new StringBuilder(" ");

            listSize = whereList.size();
            for (int i = 0; i < listSize; i++) {
                // 防止前面单词连接
                temp.append(" ");
                if (i == 0 && needWhereWord) {// 在需要where的情况下第一个条件不需要and或者or
                    temp.append(this.cutOrAnd(whereList.get(i)));
                } else {
                    temp.append(whereList.get(i));// 其余直接拼接
                }
                // 防止后面单词连接
                temp.append(" ");
            }
            whereSentenceNoWhereWord = temp.toString();
            if (isNeedWhereWord()) {
                whereSentence = " WHERE " + whereSentenceNoWhereWord;
            } else {
                whereSentence =  whereSentenceNoWhereWord;
            }

        }
        // 生成order by语句
        if (orderByList != null && orderByList.size() > 0) {
            // 初始化temp
            if (isNeedOrderByWord()) {
                temp = new StringBuilder(" ORDER BY ");
            } else {
                temp = new StringBuilder(" ");
            }
            listSize = orderByList.size();
            for (int i = 0; i < listSize; i++) {
                // 防止前面单词连接
                temp.append(" ");
                temp.append(orderByList.get(i));// 拼接条件
                if ((listSize - 1) != i) {// 最后一项不加 " , "
                    temp.append(" , ");
                }
                // 防止后面单词连接
                temp.append(" ");
            }
            orderBySentence = temp.toString();
        }
        canSet = false;// 设置不能再修改
        return this;
    }

    /**
     * 重置所有
     */
    public QueryHandler clear() {
        canSet = true;
        pageNumber = null;
        pageSize = null;
        whereList = null;
        orderByList = null;
        whereSentence = null;
        limitSentence = null;
        orderBySentence = null;
        return this;
    }

    // 去掉前面的or或者and
    private String cutOrAnd(String str) {
        String strTemp = str.trim();// 去空格
        String upTemp = str.toUpperCase();// 变成大写
        if (upTemp.indexOf("OR ") == 0) {// 存在or，去除
            return strTemp.substring(2);
        }
        if (upTemp.indexOf("AND ") == 0) {// 存在and，去除
            return strTemp.substring(3);
        }
        return str;
    }

    /**
     * 选择排序方式
     * @param columnName 列名
     * @param sortType 排序方式,升序、降序
     */
    public void OrderBy(String columnName, String sortType) {
        if (canSet == false) {
            throw new RuntimeException("无法设置!!!");
        }
        if (orderByList == null) {
            orderByList = new ArrayList<String>();
        }
        orderByList.add(columnName + " " + sortType);
    }

    public String getWhereSentence() {
        return whereSentence;
    }

    public String getLimitSentence() {
        return limitSentence;
    }

    public String getOrderBySentence() {
        return orderBySentence;
    }

    public Integer getPageNumber() {
        return pageNumber;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    @Override
    public String toString() {
        return " " + whereSentence + " " + orderBySentence + " "
                + limitSentence + " ";
    }

    public boolean isNeedWhereWord() {
        return needWhereWord;
    }

    /**
     * @return 设置语句生成时是否需要拼接 WHERE关键字
     */
    public QueryHandler setNeedWhereWord(boolean needWhereWord) {
        this.needWhereWord = needWhereWord;
        return this;
    }
    public boolean isNeedOrderByWord() {
        return needOrderByWord;
    }
    /**
     * @return 设置语句生成时是否需要拼接 ORDER BY 关键字
     */
    public QueryHandler setNeedOrderByWord(boolean needOrderByWord) {
        this.needOrderByWord = needOrderByWord;
        return this;
    }

    /**
     * 获取附加参数Map
     * @return
     */
    public Map<String, Object> getParams() {
        return params;
    }

    public String getWhereSentenceNoWhereWord() {
        return whereSentenceNoWhereWord;
    }
}
