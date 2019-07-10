package ops.school.api.service;

import com.baomidou.mybatisplus.extension.service.IService;
import ops.school.api.entity.Orders;

import java.util.List;

public interface OrdersService extends IService<Orders> {

    int pl(String id);

    List<Orders> find(Orders orders);

    int count(Orders orders);

    Orders findById(String orderId);


    List<Orders> findByShop(int shopId, int page, int size);

    void remove();

    int countBySchoolId(int schoolId);

    public List<Orders> findByShopByDjs(int shopId);

    List<Orders> findByShopYJS(int shopId, int page, int size);

    List<Orders> findAllDjs();


}
