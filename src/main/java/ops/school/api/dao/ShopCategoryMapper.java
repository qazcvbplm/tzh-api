package ops.school.api.dao;

import ops.school.api.entity.ShopCategory;

import java.util.List;

public interface ShopCategoryMapper {
    int insert(ShopCategory record);

    int insertSelective(ShopCategory record);

    ShopCategory selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ShopCategory record);

    int updateByPrimaryKey(ShopCategory record);

    List<ShopCategory> find(ShopCategory shopCategory);
}