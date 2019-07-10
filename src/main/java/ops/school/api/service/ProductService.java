package ops.school.api.service;

import com.baomidou.mybatisplus.extension.service.IService;
import ops.school.api.entity.Product;

import java.util.List;

public interface ProductService extends IService<Product> {


    List<Product> findByCategoryId(int productCategoryId);

    List<Product> findByCategoryId_wxUser(int productCategoryId);

    List<Product> findByShopAllDiscount(int productCategoryId);


    void sale(List<Integer> pids, List<Integer> counts);


}
