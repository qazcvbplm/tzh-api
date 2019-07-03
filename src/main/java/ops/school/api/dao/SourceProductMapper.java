package ops.school.api.dao;

import ops.school.api.entity.SourceProduct;

import java.util.List;

public interface SourceProductMapper {
    int insert(SourceProduct record);

    int insertSelective(SourceProduct record);

    SourceProduct selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SourceProduct record);

    int updateByPrimaryKey(SourceProduct record);

    List<SourceProduct> find(SourceProduct sourceProduct);
}