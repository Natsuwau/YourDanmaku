package yours.front.service.impl;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import yours.dao.FrontVideoMapper;
import yours.dao.QueryMapper;
import yours.front.service.FrontVideoService;
import yours.info.PageInfo;
import yours.info.QueryHandler;
import yours.info.SysInfo;
import yours.pojo.FrontVideo;
import yours.utils.MsgException;
import yours.utils.MineStringUtils;

import java.util.List;

@Service
public class FrontVideoServiceImpl extends BaseServiceImpl<FrontVideo> implements FrontVideoService {

    private static final Log logger= LogFactory.getLog(FrontVideoServiceImpl.class);

    @Autowired
    private QueryMapper queryMapper;

    private FrontVideoMapper frontVideoMapper;

    @Autowired
    public void setFrontVideoMapper(FrontVideoMapper frontVideoMapper){
        this.frontVideoMapper=frontVideoMapper;
        super.setBaseMapper(frontVideoMapper);//为BaseServiceImpl赋值
    }

    @Override
    public PageInfo<FrontVideo> findSomeByQueryHandler(QueryHandler queryHandler) throws Exception {
        List<FrontVideo> list=queryMapper.queryFrontVideo(queryHandler);
        long rootSize=0;
        int nowPage=1;
        int pageSize= SysInfo.PAGE_INFO_DEFAULT_SIZE;

        if (queryHandler==null||queryHandler.getLimitSentence()==null){
            if (logger.isDebugEnabled()){
                logger.debug("构造PageInfo:未指定分页信息.....");
            }
            if (list!=null)
            {
                rootSize=list.size();
            }
        }else {
            nowPage=queryHandler.getPageNumber();
            pageSize=queryHandler.getPageSize();

            //获取总记录数

            rootSize=queryMapper.findLastRows();

            if (logger.isDebugEnabled()){
                logger.debug("构造PageInfo,分页信息:rootSize="+rootSize
                        + ",nowPage=" + nowPage + ",pageSize=" + pageSize);
            }
        }
        PageInfo<FrontVideo>pageInfo=new PageInfo<FrontVideo>((int)rootSize,nowPage,pageSize);

        pageInfo.setBasePageList(list);

        return pageInfo;
    }

    @Override
    public FrontVideo findOneByName(String name) throws Exception {
        List<FrontVideo>list=frontVideoMapper.selectByName(name);
        if (list.size()>1){
            return list.get(0);
        }
        return null;
    }

    @Override
    public List<FrontVideo> findByKeys(List<String> keys, String banId) throws Exception {
        QueryHandler qh=QueryHandler.create().andColumnEqual("fv_state","1")
                .andColumnNotEqual("fv_id",banId).limit(1,5);
        int size=keys.size();

        for (int i=0;i<size;i++)
        {
            if (i==0){
                qh.andColumnLikeWithGroup("fv_name",keys.get(i))
                        .orColumnLike("fv_desc",keys.get(i));
            }
            else{
                qh.orColumnLike("fv_name",keys.get(i))
                        .orColumnLike("fv_desc",keys.get(i));
            }
            if (i==(size-1)){
                qh.endGroup();
            }
        }

        qh.set();

        return findSomeByQueryHandler(qh).getBasePageList();
    }

    @Override
    public long addOneHit(String vid) throws MsgException, Exception {
    FrontVideo one=frontVideoMapper.selectByPrimaryKey(vid);

    if (one==null){
        throw new MsgException("视频id有误");
    }
    if (one.getState()!=1){
        throw new MsgException("视频状态非法");
    }
    FrontVideo temp=new FrontVideo();
    temp.setId(one.getId());
    long hits=one.getHits()+1;
    temp.setHits(hits);
    String result=super.update(temp);

    if (!MineStringUtils.IsNullOrEmpty(result)){
        throw new MsgException(result);
    }

    if (logger.isDebugEnabled()){
        logger.debug("点击量增加成功");
    }

        return hits;
    }
}
