package ops.school.api.serviceimple;


import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import ops.school.api.dao.SourceOrderMapper;
import ops.school.api.entity.SourceOrder;
import ops.school.api.service.SourceOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SourceOrderServiceImple extends ServiceImpl<SourceOrderMapper, SourceOrder> implements SourceOrderService {

    @Autowired
    private SourceOrderMapper sourceOrderMapper;

   /* @Transactional
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
    }*/

    @Override
    public List<SourceOrder> find(SourceOrder sourceOrder) {
        return sourceOrderMapper.find(sourceOrder);
    }

}
