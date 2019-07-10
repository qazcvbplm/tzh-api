package ops.school.api.serviceimple;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import ops.school.api.dao.OrdersMapper;
import ops.school.api.entity.Orders;
import ops.school.api.entity.Shop;
import ops.school.api.service.OrdersService;
import ops.school.api.util.RedisUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrdersServiceImple extends ServiceImpl<OrdersMapper, Orders> implements OrdersService {

    @Autowired
    private OrdersMapper ordersMapper;
    @Autowired
    private StringRedisTemplate stringRedisTemplate;
    @Autowired
    private RedisUtil cache;

  /*  @Transactional
    @Override
    public void addTakeout(Integer[] productIds, Integer[] attributeIndex, Integer[] counts, @Valid Orders orders) {
        WxUser wxUser = wxUserService.findById(orders.getOpenId());
        School school = schoolService.findById(wxUser.getSchoolId());
        Shop shop = shopMapper.selectByPrimaryKey(productMapper.selectByPrimaryKey(productIds[0]).getShopId());
        Floor floor = floorMapper.selectByPrimaryKey(orders.getFloorId());
        Product pt;
        ProductAttribute pa;
        int totalcount = 0;
        int boxcount = 0;
        boolean isDiscount = false;
        for (int i = 0; i < productIds.length; i++) {
            totalcount += counts[i];
            pt = productMapper.selectByPrimaryKey(productIds[i]);
            pa = productAttributeMapper.selectByPrimaryKey(attributeIndex[i]);
            OrderProduct op = new OrderProduct(productIds[i], pt.getProductName(), pt.getProductImage(), counts[i],
                    pt.getDiscount(), orders.getId(), pa.getName(), pa.getPrice());
            orderProductMapper.insert(op);
            orders.setProductPrice(
                    orders.getProductPrice().add(op.getAttributePrice().multiply(new BigDecimal(counts[i]))));
            // 查看餐盒费
            if (pt.getBoxPriceFlag() == 1) {
                boxcount += counts[i];
            }
            // 计算商品折扣
            if (pa.getIsDiscount() == 1) {
                isDiscount = true;
                orders.setDiscountType("商品折扣");
                BigDecimal DiscountPrice = (pa.getPrice().subtract(op.getAttributePrice()))
                        .multiply(new BigDecimal(counts[i]));
                orders.setDiscountPrice(orders.getDiscountPrice().add(DiscountPrice));
            }
        }
        orders.takeoutinit1(wxUser, school, shop, floor, totalcount, isDiscount, fullCutMapper.findByShop(shop.getId()),
                boxcount);
        ordersMapper.insert(orders);
    }*/

    @Override
    public int pl(String id) {
        return ordersMapper.pl(id);
    }

    @Override
    public List<Orders> find(Orders orders) {
        return ordersMapper.find(orders);
    }

    @Override
    public int count(Orders orders) {
        return ordersMapper.count(orders);
    }

    @Override
    public Orders findById(String orderId) {
        return ordersMapper.selectById(orderId);
    }

    /*@Transactional
    @Override
    public int paySuccess(String orderId, String payment) {
        Map<String, Object> map = new HashMap<>();
        map.put("orderId", orderId);
        map.put("payment", payment);
        map.put("payTimeLong", System.currentTimeMillis());
        Orders orders = findById(orderId);
        int rs = ordersMapper.paySuccess(map);
        if (rs == 1) {
            cache.takeoutCountadd(orders.getSchoolId());
            String ordersStr = JSON.toJSONString(orders);
            orders.setStatus("待接手");
            stringRedisTemplate.boundHashOps("SHOP_DJS" + orders.getShopId()).put(orderId, JSON.toJSONString(orders));
            stringRedisTemplate.convertAndSend(Server.SOCKET, ordersStr);
        }
        return rs;
    }*/

    @Override
    public List<Orders> findByShopByDjs(int shopId) {
        return ordersMapper.findByShopByDjs(shopId);
    }

    /*@Transactional
    @Override
    public int shopAcceptOrderById(String orderId) {
        Orders orders = findById(orderId);
        synchronized (orders.getShopId()) {
            Orders update = new Orders();
            update.setShopId(orders.getShopId());
            update.setId(orderId);
            update.setPayTime(orders.getCreateTime().toString().substring(0, 10) + "%");
            synchronized (update.getShopId()) {
                int water = ordersMapper.waterNumber(update);
                update.setWaterNumber(water + 1);
            }
            if (ordersMapper.shopAcceptOrderById(update) == 1) {
                if (orders.getTyp().equals("堂食订单") || orders.getTyp().equals("自取订单")) {
                    stringRedisTemplate.opsForValue().set("tsout," + orderId, "1", 2, TimeUnit.HOURS);
                }
                WxUser wxUser = wxUserService.findById(orders.getOpenId());
                School school = schoolService.findById(wxUser.getSchoolId());
                wxUserService.sendWXGZHM(wxUser.getPhone(), new Message(null, "AFavOESyzBju1s8Wjete1SNVUvJr-YixgR67v6yMxpg",
                        school.getWxAppId(), "pages/order/orderDetail/orderDetail?orderId="
                        + orders.getId() + "&typ=" + orders.getTyp(),
                        "您的订单已被商家接手!", orderId, new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()),
                        null, null, null, null, null, null,
                        null, " 商家正火速给您备餐中，请耐心等待"));
                return orders.getShopId();
            }
            return 0;
        }
    }*/

    @Override
    public List<Orders> findByShop(int shopId, int page, int size) {
        Shop s = new Shop();
        s.setId(shopId);
        s.setPage(page);
        s.setSize(size);
        return ordersMapper.findByShop(s);
    }

    @Override
    public void remove() {
        ordersMapper.remove();
    }

   /* @Transactional
    @Override
    public int pay(Orders orders) {
        Shop shop = shopMapper.selectByPrimaryKey(orders.getShopId());
        School school = schoolService.findById(shop.getSchoolId());
        Application application = applicationMapper.selectByPrimaryKey(school.getAppId());
        if (application.getVipTakeoutDiscountFlag() == 1) {
            orders.setPayPrice((orders.getPayPrice().multiply(application.getVipTakeoutDiscount())).setScale(2,
                    BigDecimal.ROUND_HALF_DOWN));
        }

        Map<String, Object> map = new HashMap<>();
        WxUser user = wxUserService.findById(orders.getOpenId());
        map.put("phone", user.getOpenId() + "-" + user.getPhone());
        map.put("amount", orders.getPayPrice());
        if (wxUserBellMapper.pay(map) == 1) {
            if (paySuccess(orders.getId(), "余额支付") == 0) {
                throw new YWException("订单状态异常");
            }
            WxUser wxUser = wxUserService.findById(orders.getOpenId());
            WxUserBell userbell = wxUserBellMapper.selectByPrimaryKey(wxUser.getOpenId() + "-" + wxUser.getPhone());
            wxUserService.sendWXGZHM(wxUser.getPhone(), new Message(null, "JlaWQafk6M4M2FIh6s7kn30yPdy2Cd9k2qtG6o4SuDk"
                    , school.getWxAppId(), "pages/mine/payment/payment", " 您的会员帐户余额有变动！", "暂无", "-" + orders.getPayPrice(),
                    new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()), "消费",
                    userbell.getMoney() + "", null, null,
                    null, null, "如有疑问请在小程序内联系客服人员！"));
            return 1;
        } else {
            throw new YWException("余额不足");
        }
    }*/

   /* @Transactional
    @Override
    public int cancel(String id) {
        Orders orders = ordersMapper.selectByPrimaryKey(id);
        if (System.currentTimeMillis() - orders.getPayTimeLong() < 5 * 60 * 1000) {
            return 2;
        }
        if (ordersMapper.cancel(id) == 1) {
            if (orders.getPayment().equals("微信支付")) {
                School school = schoolService.findById(orders.getSchoolId());
                String fee = AmountUtils.changeY2F(orders.getPayPrice().toString());
                int result = RefundUtil.wechatRefund1(school.getWxAppId(), school.getWxSecret(), school.getMchId(),
                        school.getWxPayId(), school.getCertPath(), orders.getId(), fee, fee);
                if (result != 1) {
                    throw new YWException("退款失败联系管理员");
                } else {
                    return orders.getShopId();
                }
            }
            if (orders.getPayment().equals("余额支付")) {
                Map<String, Object> map = new HashMap<>();
                WxUser user = wxUserService.findById(orders.getOpenId());
                map.put("phone", user.getOpenId() + "-" + user.getPhone());
                map.put("amount", orders.getPayPrice());
                if (wxUserBellMapper.charge(map) == 1) {
                    return orders.getShopId();
                } else {
                    throw new YWException("退款失败联系管理员");
                }
            }
        }
        return 0;
    }*/

    @Override
    public int countBySchoolId(int schoolId) {
        return ordersMapper.countBySchoolId(schoolId);
    }

    @Override
    public List<Orders> findByShopYJS(int shopId, int page, int size) {
        Shop s = new Shop();
        s.setId(shopId);
        s.setPage(page);
        s.setSize(size);
        return ordersMapper.findByShopYJS(s);
    }

    @Override
    public List<Orders> findAllDjs() {
        return ordersMapper.findAllDjs();
    }
}
