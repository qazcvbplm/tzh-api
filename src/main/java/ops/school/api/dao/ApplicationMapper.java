package ops.school.api.dao;

import ops.school.api.entity.Application;

public interface ApplicationMapper {
    int insert(Application record);

    int insertSelective(Application record);

    Application selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Application record);

    int updateByPrimaryKey(Application record);

    Application login(Application login);
}