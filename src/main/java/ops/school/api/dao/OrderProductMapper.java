package ops.school.api.dao;

import ops.school.api.entity.OrderProduct;

public interface OrderProductMapper {
    int insert(OrderProduct record);

    int insertSelective(OrderProduct record);

    OrderProduct findByOrderId(String id);

    int updateByPrimaryKeySelective(OrderProduct record);

    int updateByPrimaryKey(OrderProduct record);
}