package ops.school.api.serviceimple;


import ops.school.api.dao.SourceOrderMapper;
import ops.school.api.dao.SourceProductMapper;
import ops.school.api.dao.WxUserBellMapper;
import ops.school.api.entity.SourceOrder;
import ops.school.api.entity.SourceProduct;
import ops.school.api.entity.WxUser;
import ops.school.api.exception.YWException;
import ops.school.api.service.SourceOrderService;
import ops.school.api.service.WxUserService;
import ops.school.api.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

@Service
public class SourceOrderServiceImple implements SourceOrderService {

    @Autowired
    private SourceOrderMapper sourceOrderMapper;
    @Autowired
    private SourceProductMapper sourceProductMapper;
    @Autowired
    private WxUserService wxUserService;
    @Autowired
    private WxUserBellMapper wxUserBellMapper;

    @Transactional
    @Override
    public String add(Integer id, @Valid SourceOrder sourceOrder) {
        WxUser wxUser = wxUserService.findById(sourceOrder.getOpenId());
        SourceProduct sp = sourceProductMapper.selectByPrimaryKey(id);
        sourceOrder.setId(Util.GenerateOrderId());
        sourceOrder.setPayPrice(sp.getPrice());
        sourceOrder.setProductImage(sp.getProductImage());
        sourceOrder.setProductName(sp.getProductName());
        Map<String, Object> map = new java.util.HashMap<>();
        map.put("phone", wxUser.getOpenId() + "-" + wxUser.getPhone());
        map.put("source", sp.getPrice());
        if (wxUserBellMapper.paySource(map) == 1) {
            sourceOrderMapper.insert(sourceOrder);
        } else {
            throw new YWException("积分不足");
        }
        return sourceOrder.getId();
    }

    @Override
    public List<SourceOrder> find(SourceOrder sourceOrder) {
        return sourceOrderMapper.find(sourceOrder);
    }

    @Override
    public int update(SourceOrder sourceOrder) {
        return sourceOrderMapper.updateByPrimaryKeySelective(sourceOrder);
    }

    @Override
    public int count(SourceOrder sourceOrder) {
        return sourceOrderMapper.count(sourceOrder);
    }
}
