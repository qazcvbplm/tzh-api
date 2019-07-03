package ops.school.api.dao;

import ops.school.api.entity.Charge;

import java.util.List;

public interface ChargeMapper {
    int insert(Charge record);

    Charge selectByPrimaryKey(Integer id);

    List<Charge> find();

    int remove(int id);

}