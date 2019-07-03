package ops.school.api.dao;

import ops.school.api.entity.SecondHand;

import java.util.List;

public interface SecondHandMapper {
    int insert(SecondHand record);

    int insertSelective(SecondHand record);

    SecondHand selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SecondHand record);

    int updateByPrimaryKeyWithBLOBs(SecondHand record);

    int updateByPrimaryKey(SecondHand record);

    List<SecondHand> find(SecondHand secondHand);

    int count(SecondHand secondHand);
}