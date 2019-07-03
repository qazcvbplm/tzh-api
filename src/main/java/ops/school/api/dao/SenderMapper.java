package ops.school.api.dao;

import ops.school.api.entity.Sender;

import java.util.List;

public interface SenderMapper {
    int insert(Sender record);

    int insertSelective(Sender record);

    Sender selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Sender record);

    int updateByPrimaryKey(Sender record);

    List<Sender> find(Sender sender);

    Sender check(String openId);

    int count(Sender sender);

    int finddsh(int schoolId);

    List<Integer> findSenderIdBySchoolId(Integer schoolId);
}