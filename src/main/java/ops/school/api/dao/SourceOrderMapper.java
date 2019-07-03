package ops.school.api.dao;

import ops.school.api.entity.SourceOrder;

import java.util.List;

public interface SourceOrderMapper {
    int insert(SourceOrder record);

    int insertSelective(SourceOrder record);

    SourceOrder selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(SourceOrder record);

    int updateByPrimaryKey(SourceOrder record);

    List<SourceOrder> find(SourceOrder sourceOrder);

    int count(SourceOrder sourceOrder);
}