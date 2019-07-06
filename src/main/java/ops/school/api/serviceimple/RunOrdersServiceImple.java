package ops.school.api.serviceimple;

import ops.school.api.dao.ApplicationMapper;
import ops.school.api.dao.RunOrdersMapper;
import ops.school.api.dao.ShopMapper;
import ops.school.api.dao.WxUserBellMapper;
import ops.school.api.dto.wxgzh.Message;
import ops.school.api.entity.*;
import ops.school.api.exception.YWException;
import ops.school.api.service.RunOrdersService;
import ops.school.api.service.SchoolService;
import ops.school.api.service.WxUserService;
import ops.school.api.util.RedisUtil;
import ops.school.api.wx.refund.RefundUtil;
import ops.school.api.wxutil.AmountUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.validation.Valid;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class RunOrdersServiceImple implements RunOrdersService {

    @Autowired
    private WxUserService wxUserService;
    @Autowired
    private RunOrdersMapper runOrdersMapper;
    @Autowired
    private ApplicationMapper applicationMapper;
    @Autowired
    private WxUserBellMapper wxUserBellMapper;
    @Autowired
    private ShopMapper shopMapper;
    @Autowired
    private SchoolService schoolService;
    @Autowired
    private RedisUtil cache;

    @Override
    public void add(@Valid RunOrders orders) {
        runOrdersMapper.insert(orders);

    }

    @Override
    public List<RunOrders> find(RunOrders orders) {
        return runOrdersMapper.find(orders);
    }

    @Override
    public int count(RunOrders orders) {
        return runOrdersMapper.count(orders);
    }

    @Override
    public RunOrders findById(String orderId) {
        return runOrdersMapper.selectByPrimaryKey(orderId);
    }

    @Override
    public int paySuccess(String orderId, String payment) {
        Map<String, Object> map = new HashMap<>();
        map.put("orderId", orderId);
        map.put("payment", payment);
        map.put("payTimeLong", System.currentTimeMillis());
        RunOrders orders = findById(orderId);
        int rs = runOrdersMapper.paySuccess(map);
        if (rs == 1) {
            cache.runCountadd(orders.getSchoolId());
        }
        return rs;
    }

    @Override
    public int pay(RunOrders orders) {
        Application application = applicationMapper.selectByPrimaryKey(orders.getAppId());
        if (application.getVipRunDiscountFlag() == 1) {
            orders.setTotalPrice((orders.getTotalPrice().multiply(application.getVipRunDiscount())).setScale(2, BigDecimal.ROUND_HALF_DOWN));
        }
        Map<String, Object> map = new HashMap<>();
        WxUser user = wxUserService.findById(orders.getOpenId());
        map.put("phone", user.getOpenId() + "-" + user.getPhone());
        map.put("amount", orders.getTotalPrice());
        if (wxUserBellMapper.pay(map) == 1) {
            if (paySuccess(orders.getId(), "余额支付") == 0) {
                throw new YWException("订单状态异常");
            }
            WxUserBell userbell = wxUserBellMapper.selectByPrimaryKey(user.getOpenId() + "-" + user.getPhone());
            wxUserService.sendWXGZHM(user.getPhone(), new Message(null, "JlaWQafk6M4M2FIh6s7kn30yPdy2Cd9k2qtG6o4SuDk",
                    null, null
                    + orders.getId() + "&typ=" + orders.getTyp(),
                    " 您的会员帐户余额有变动！", "暂无", "-" + orders.getTotalPrice(), new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()),
                    "消费", userbell.getMoney() + "", null, null, null,
                    null, "如有疑问请在小程序内联系客服人员！"));
            return 1;
        } else {
            throw new YWException("余额不足");
        }
    }

    @Override
    public void remove() {
        runOrdersMapper.remove();
    }

    @Transactional
    @Override
    public int cancel(String id) {
        RunOrders orders = runOrdersMapper.selectByPrimaryKey(id);
        if (System.currentTimeMillis() - orders.getPayTimeLong() < 5 * 60 * 1000) {
            return 2;
        }
        if (runOrdersMapper.cancel(id) == 1) {
            if (orders.getPayment().equals("微信支付")) {
                School school = schoolService.findById(orders.getSchoolId());
                String fee = AmountUtils.changeY2F(orders.getTotalPrice().toString());
                int result = RefundUtil.wechatRefund1(school.getWxAppId(), school.getWxSecret(), school.getMchId(), school.getWxPayId(), school.getCertPath(),
                        orders.getId(), fee, fee);
                if (result != 1) {
                    throw new YWException("退款失败联系管理员");
                } else {
                    return 1;
                }
            }
            if (orders.getPayment().equals("余额支付")) {
                Map<String, Object> map = new HashMap<>();
                WxUser user = wxUserService.findById(orders.getOpenId());
                map.put("phone", user.getOpenId() + "-" + user.getPhone());
                map.put("amount", orders.getTotalPrice());
                if (wxUserBellMapper.charge(map) == 1) {
                    return 1;
                } else {
                    throw new YWException("退款失败联系管理员");
                }
            }
        }
        return 0;
    }

    @Override
    public int countBySchoolId(int schoolId) {
        // TODO Auto-generated method stub
        return runOrdersMapper.countBySchoolId(schoolId);
    }

}
