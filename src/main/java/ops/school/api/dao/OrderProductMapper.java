package ops.school.api.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import ops.school.api.entity.OrderProduct;

public interface OrderProductMapper extends BaseMapper<OrderProduct> {
    int insert(OrderProduct record);

    int insertSelective(OrderProduct record);

    OrderProduct findByOrderId(String id);

    int updateByPrimaryKeySelective(OrderProduct record);

    int updateByPrimaryKey(OrderProduct record);
}