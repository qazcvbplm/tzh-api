package ops.school.api.dao;

import ops.school.api.entity.ProductCategory;

import java.util.List;

public interface ProductCategoryMapper {
    int insert(ProductCategory record);

    int insertSelective(ProductCategory record);

    ProductCategory selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ProductCategory record);

    int updateByPrimaryKey(ProductCategory record);

    List<ProductCategory> findByShop(int shopId);
}