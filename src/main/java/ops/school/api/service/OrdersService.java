package ops.school.api.service;

import ops.school.api.entity.Orders;

import javax.validation.Valid;
import java.util.List;

public interface OrdersService {

    void addTakeout(Integer[] productIds, Integer[] attributeIndex, Integer[] counts, @Valid Orders orders);

    List<Orders> find(Orders orders);

    int count(Orders orders);

    Orders findById(String orderId);

    int paySuccess(String orderId, String string);

    List<Orders> findByShopByDjs(int shopId);

    int shopAcceptOrderById(String orderId);

    List<Orders> findByShop(int shopId, int page, int size);

    void remove();

    int pay(Orders orders);

    int cancel(String id);

    int countBySchoolId(int schoolId);

    List<Orders> findByShopYJS(int shopId, int page, int size);

    List<Orders> findAllDjs();


}
