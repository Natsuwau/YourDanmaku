package yours.front.service.impl;

import org.springframework.stereotype.Service;
import yours.info.PageInfo;
import yours.info.QueryHandler;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import yours.dao.BaseMapper;
import yours.front.service.BaseService;
import yours.pojo.BasePojo;
import yours.utils.MineCommonUtils;
import yours.utils.MsgException;
import yours.utils.MineStringUtils;
@Service
public class BaseServiceImpl<T extends BasePojo> implements BaseService<T> {

    private static final Log logger= LogFactory.getLog(BaseServiceImpl.class);

    private BaseMapper<T> baseMapper;

    public void  setBaseMapper(BaseMapper<T> baseMapper){this.baseMapper=baseMapper;}



    @Override
    public String addWithAutoId(T one) throws Exception {

        String errMsg=null;
        if (one==null){
            errMsg="添加失败：实体为空";
            logger.debug(errMsg);
            return errMsg;
        }

        //uuid自动生成id
        String uuid= MineCommonUtils.getUUID_NoHyphen();
        one.setId(uuid);

        if (logger.isDebugEnabled()){
            logger.debug("添加并自动生成id"+uuid);
        }

        //采用动态插入语句

        if (baseMapper.insertSelective(one)==1){
            if (logger.isDebugEnabled()){
                logger.debug("添加成功"+one.toString());
            }
        }else {
            errMsg="添加失败";
            logger.debug(errMsg);

        }

        return errMsg;

    }


    @Override
    public String add(T one) throws Exception {

        String errMsg=null;
        if (one==null){
            errMsg="添加失败,实体为空";
            logger.debug(errMsg);
            return errMsg;
        }
        if (MineStringUtils.IsNullWhiteSpace(one.getId()))
        {
            errMsg="添加失败，id为空";
            logger.debug(errMsg);
            return errMsg;
        }

        //去空格
        one.setId(one.getId().trim());

        //采用动态sql

        if (baseMapper.insertSelective(one)==1)
        {

            if (logger.isDebugEnabled()){
                logger.debug("添加成功"+one.toString());
            }
            else {
                errMsg="添加失败";
                logger.debug(errMsg);
            }

        }

        return errMsg;
    }


    @Override
    public String update(T one) throws Exception {
        String errMsg=null;
        if (one==null|| MineStringUtils.IsNullWhiteSpace(one.getId()))
        {
            errMsg="更新失败：实体为空或id为空";
            logger.debug(errMsg);
            return errMsg;
        }


        //采用动态sql
        if (baseMapper.updateByPrimaryKeySelective(one)==1)
        {
            if (logger.isDebugEnabled()){
                logger.debug("更新成功：id="+one.getId());
            }
        }else {
            errMsg="更新失败";
            logger.debug(errMsg);
        }

        return errMsg;
    }


    @Override
    public String updateState(String id, Integer state, Class<T> tClass) throws Exception {
        String errMsg=null;
        if (MineStringUtils.IsNullWhiteSpace(id))
        {
            errMsg="根据id更新state失败：id为空";
            logger.debug(errMsg);
            return errMsg;
        }
        if (state==null){
            errMsg="根据id更新state失败：state";
            logger.debug(errMsg);
            return errMsg;
        }
        T one=null;

        try {
           one=tClass.newInstance();
        }catch (Exception e){
            logger.debug("实例化"+tClass.getName()+"出现异常");
        }
        if (one==null){
            errMsg="根据id更新state失败：实例化"+tClass.getName()+"出现异常";
            logger.debug(errMsg);
            return errMsg;
        }
        one.setId(id);
        one.setState(state);

        //采用动态sql
        if (baseMapper.updateByPrimaryKeySelective(one)==1){
            if (logger.isDebugEnabled()){
                logger.debug("根据id更新state成功:id="+one.getId());
            }
        }else {
            errMsg="根据id更新state失败！";
            logger.debug(errMsg);
        }


        return errMsg;
    }


    @Override
    public String delete(String id) throws Exception {
        String errMsg=null;
        if (MineStringUtils.IsNullWhiteSpace(id))
        {
            errMsg="根据id删除失败：id为空";
            logger.debug(errMsg);
            return errMsg;
        }
        if (baseMapper.deleteByPrimaryKey(id)==1)
        {
            if (logger.isDebugEnabled()){
                logger.debug("根据id删除成功,id:"+id);
            }
        }
        else {

            errMsg="根据id删除失败,id:"+id;
            logger.debug(errMsg);
        }

        return errMsg;
    }


    @Override
    public T findOneById(String id) throws MsgException, Exception {
        if (MineStringUtils.IsNullWhiteSpace(id)){
            String str="根据id查询失败：id为空！";
            logger.debug(str);
            throw new MsgException(str);
        }
        T one=baseMapper.selectByPrimaryKey(id);
        if (one==null){
            if (logger.isDebugEnabled()){
                logger.debug("根据id查询失败：id非法");
            }
        }else {
            if (logger.isDebugEnabled()){
                logger.debug("根据id查询成功");
            }

        }

        return one;
    }

    @Override
    public PageInfo<T> findSomeByQueryHandler(QueryHandler queryHandler) throws Exception {
        return null;
    }


}
