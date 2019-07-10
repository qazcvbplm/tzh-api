package ops.school.api.service;


import com.baomidou.mybatisplus.extension.service.IService;
import ops.school.api.entity.WxUserBell;

import java.util.Map;

public interface WxUserBellService extends IService<WxUserBell> {

    Integer charge(Map<String, Object> map);

    int pay(Map<String, Object> map);

    Integer addSource(Map<String, Object> map2);
}
