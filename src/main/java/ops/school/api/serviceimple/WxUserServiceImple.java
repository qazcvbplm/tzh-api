package ops.school.api.serviceimple;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import ops.school.api.dao.*;
import ops.school.api.dto.wxgzh.Message;
import ops.school.api.entity.WxUser;
import ops.school.api.entity.WxUserBell;
import ops.school.api.exception.YWException;
import ops.school.api.service.SchoolService;
import ops.school.api.service.WxUserService;
import ops.school.api.util.SpringUtil;
import ops.school.api.wxutil.WxGUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class WxUserServiceImple extends ServiceImpl<WxUserMapper, WxUser> implements WxUserService {

    @Autowired
    private WxUserMapper wxUserMapper;
    @Autowired
    private WxUserBellMapper wxUserBellMapper;
    @Autowired
    private ChargeMapper chargeMapper;
    @Autowired
    private SchoolService schoolService;
    @Autowired
    private ChargeLogMapper chargeLogMapper;
    @Autowired
    private LogsMapper logsMapper;
    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Override
    public WxUser login(String openid, Integer schoolId, Integer appId, String client) {
        WxUser wxUser = findById(openid);
        if (wxUser == null) {
            wxUser = new WxUser(openid, client);
            wxUser.setAppId(appId);
            wxUser.setSchoolId(schoolId);
            this.save(wxUser);
        }
        return wxUser;
    }

    @Transactional
    @Override
    public WxUser update(WxUser wxUser) {
        if (wxUser.getPhone() != null) {
            if (wxUserBellMapper.findByPhone(wxUser.getOpenId() + "-" + wxUser.getPhone()) == 0) {
                wxUserBellMapper.insert(new WxUserBell(wxUser.getOpenId() + "-" + wxUser.getPhone()));
            } else {
                throw new YWException("手机号码已被注册");
            }
        }
        boolean rs = this.updateById(wxUser);
        if (SpringUtil.redisCache() && rs) {
            stringRedisTemplate.boundHashOps("WX_USER_LIST").delete(wxUser.getOpenId());
        }
        return wxUserMapper.selectByPrimaryKey(wxUser.getOpenId());
    }

    @Override
    public List<WxUser> find(WxUser wxUser) {
        if (wxUser.getQueryType().equals("ops")) {
            wxUser.setSchoolId(Integer.valueOf(wxUser.getQuery()));
        }
        return wxUserMapper.find(wxUser);
    }




   /* @Transactional
    @Override
    public void chargeSuccess(String orderId, String openId, String attach) {
        WxUser wxUser = wxUserMapper.selectByPrimaryKey(openId);
        School school = schoolService.findById(wxUser.getSchoolId());
        Charge charge = chargeMapper.selectByPrimaryKey(Integer.valueOf(attach));
        ChargeLog log = new ChargeLog(orderId, new BigDecimal(charge.getFull()), new BigDecimal(charge.getSend()), openId, wxUser.getAppId());
        chargeLogMapper.insert(log);
        Map<String, Object> map = new HashMap<>();
        map.put("phone", wxUser.getOpenId() + "-" + wxUser.getPhone());
        map.put("amount", log.getPay().add(log.getSend()));
        if (wxUserBellMapper.charge(map) == 0) {
            LoggerUtil.log("充值失败：" + wxUser.getPhone() + "" + (log.getPay().add(log.getSend()).toString()));
        } else {
            Map<String, Object> map2 = new HashMap<>();
            map2.put("schoolId", school.getId());
            map2.put("charge", log.getPay());
            map2.put("send", log.getSend());
            try {
                schoolService.charge(map2);
            } catch (Exception e) {
                logsMapper.insert(new Logs(e.getMessage()));
            }

            WxUserBell userbell = wxUserBellMapper.selectByPrimaryKey(wxUser.getOpenId() + "-" + wxUser.getPhone());
            //发送模板
            sendWXGZHM(wxUser.getPhone(), new Message(null,
                    "JlaWQafk6M4M2FIh6s7kn30yPdy2Cd9k2qtG6o4SuDk",
                    school.getWxAppId(),
                    "pages/mine/payment/payment",
                    "暂无",
                    "+" + log.getPay().add(log.getSend()),
                    new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())
                    , "充值", userbell.getMoney() + "", null, null, null, null, null, "如有疑问请在小程序内联系客服人员！"));
        }
    }*/

    @Override
    public void sendWXGZHM(String phone, Message message) {
        WxUser wxGUser = findGzh(phone);
        if (wxGUser != null) {
            message.setToUser(wxGUser.getOpenId());
            WxGUtil.snedM(message.toJson());
        }
    }



    @Override
    public WxUser findById(String openId) {
        if (SpringUtil.redisCache()) {
            String rs = stringRedisTemplate.opsForValue().get("WX_USER_OPENID_" + openId);
            if (rs != null) {
                return JSON.parseObject(rs, WxUser.class);
            } else {
                WxUser wxUser = wxUserMapper.selectByPrimaryKey(openId);
                stringRedisTemplate.boundHashOps("WX_USER_LIST").put(openId, JSON.toJSONString(wxUser));
                return wxUser;
            }
        }
        return wxUserMapper.selectById(openId);
    }



    @Override
    public int countBySchoolId(int schoolId) {
        return wxUserMapper.countBySchoolId(schoolId);
    }

    @Override
    public List<WxUser> findByPhoneGZH(String query) {
        return wxUserMapper.findByPhoneGZH(query);
    }


    @Override
    public WxUser findGzh(String phone) {
        List<WxUser> users = wxUserMapper.findGzh(phone);
        return users.size() > 0 ? users.get(0) : null;
    }

    @Override
    public WxUser findByschoolAndPhone(WxUser query) {
        return wxUserMapper.findByschoolAndPhone(query);
    }


}
