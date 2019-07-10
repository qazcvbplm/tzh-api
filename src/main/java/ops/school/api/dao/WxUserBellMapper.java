package ops.school.api.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import ops.school.api.entity.WxUserBell;

import java.util.Map;

public interface WxUserBellMapper extends BaseMapper<WxUserBell> {

    int insert(WxUserBell record);


    WxUserBell selectByPrimaryKey(String phone);


    int pay(Map<String, Object> map);


    int charge(Map<String, Object> map);


    int paySource(Map<String, Object> map);


    int addSource(Map<String, Object> map);


    int findByPhone(String string);

}