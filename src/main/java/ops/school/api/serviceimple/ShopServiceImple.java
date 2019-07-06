package ops.school.api.serviceimple;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import ops.school.api.dao.*;
import ops.school.api.dto.SenderTj;
import ops.school.api.dto.ShopTj;
import ops.school.api.entity.*;
import ops.school.api.exception.YWException;
import ops.school.api.service.ShopService;
import ops.school.api.util.ShopTimeUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.validation.Valid;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ShopServiceImple implements ShopService {

    @Autowired
    private ShopMapper shopMapper;
    @Autowired
    private FullCutMapper fullCutMapper;
    @Autowired
    private RunOrdersMapper runOrdersMapper;
    @Autowired
    private ProductMapper productMapper;
    @Autowired
    private ShopOpenTimeMapper shopOpenTimeMapper;
    @Autowired
    private OrdersMapper ordersMapper;


    @Override
    public void add(Shop shop) {
        if (shopMapper.checkByLoginName(shop.getShopLoginName()) == null) {
            shop.setSort(System.currentTimeMillis());
            shopMapper.insert(shop);
        } else {
            throw new YWException("登录名重复请重新 输入");
        }
    }

    @Override
    public List<Shop> find(Shop shop) {
        return shopMapper.find(shop);
    }

    @Override
    public int update(Shop shop) {
        if (shop.getShopLoginName() != null) {
            if (shopMapper.checkByLoginName(shop.getShopLoginName()) != null) {
                throw new YWException("登录名重复请重新 输入");
            }
        }
        return shopMapper.updateById(shop);
    }

    @Override
    public void addFullCut(@Valid FullCut fullcut) {
        fullCutMapper.insert(fullcut);
    }

    @Override
    public int deleteFullCut(int id) {
        return fullCutMapper.delete(id);
    }

    @Override
    public List<FullCut> findFullCut(int shopId) {
        return fullCutMapper.findByShop(shopId);
    }

    @Override
    public int count(Shop shop) {
        return shopMapper.count(shop);
    }

    @Override
    public Shop login(String loginName, String enCode) {
        Shop shop = shopMapper.checkByLoginName(loginName);
        if (shop != null) {
            if (shop.getShopLoginPassWord().equals(enCode)) {
                return shop;
            } else {
                throw new YWException("密码错误");
            }
        } else {
            throw new YWException("用户名不存在");
        }
    }

    @Override
    public SenderTj statistics(Integer shopId, String beginTime, String endTime) {
        SenderTj rs = new SenderTj();
        rs.setTakeoutNosuccess(0);
        rs.setTakeoutSuccess(0);
        Map<String, Object> map = new HashMap<>();
        map.put("shopId", shopId);
        map.put("beginTime", beginTime);
        map.put("endTime", endTime);
        List<RunOrders> list = runOrdersMapper.temp(map);
        for (RunOrders temp : list) {
            if (temp.getStatus().equals("待接手")) {
                rs.setTakeoutNosuccess(rs.getTakeoutNosuccess() + temp.getFloorId());
            }
            if (temp.getStatus().equals("配送员已接手")) {
                rs.setTakeoutNosuccess(rs.getTakeoutNosuccess() + temp.getFloorId());
            }
            if (temp.getStatus().equals("已完成")) {
                rs.setTakeoutSuccess(temp.getFloorId());
            }
        }
        return rs;
    }

    @Override
    public Shop findById(int id) {
        return shopMapper.selectByPrimaryKey(id);
    }

    @Override
    public int openorclose(Integer id) {
        Shop shop = shopMapper.selectByPrimaryKey(id);
        if (shop.getOpenFlag() == 1) {
            shop.setOpenFlag(0);
        } else {
            shop.setOpenFlag(1);
        }
        Shop update = new Shop();
        update.setId(id);
        update.setOpenFlag(shop.getOpenFlag());
        return update(update);
    }

    @Override
    public int addOpenTime(@Valid ShopOpenTime time) {
        time.setStartTimeLong(ShopTimeUtil.parse(time.getStartTime()));
        time.setEndTimeLong(ShopTimeUtil.parse(time.getEndTime()));
        return shopOpenTimeMapper.insert(time);
    }

    @Override
    public int removeopentime(int id) {
        return shopOpenTimeMapper.deleteById(id);
    }

    @Override
    public List<ShopOpenTime> findOpenTime(int shopId) {
        QueryWrapper<ShopOpenTime> query = new QueryWrapper<>();
        query.eq("shop_id", shopId);
        return shopOpenTimeMapper.selectPage(new Page<ShopOpenTime>(1, 100), query).getRecords();
    }

    @Override
    public ShopTj shopstatistics(Integer shopId, String beginTime, String endTime) {
        Map<String, Object> map = new HashMap<>();
        map.put("shopId", shopId);
        map.put("beginTime", beginTime);
        map.put("endTime", endTime);
        List<Orders> list = ordersMapper.shopsta(map);
        if (list.size() > 0) {
            Orders temp = list.get(0);
            ShopTj rs = new ShopTj(Integer.valueOf(temp.getRemark()), temp.getFloorId(), temp.getPayPrice(), temp.getComplete(), temp.getBoxPrice(), temp.getSendPrice());
            return rs;
        }
        return new ShopTj(0, 0, new BigDecimal(0), new BigDecimal(0), new BigDecimal(0), new BigDecimal(0));
    }
}
