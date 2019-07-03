package ops.school.api.dao;

import ops.school.api.entity.Address;

import java.util.List;

public interface AddressMapper {
    int insert(Address record);

    int insertSelective(Address record);

    Address selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Address record);

    int updateByPrimaryKey(Address record);

    List<Address> find(Address address);
}