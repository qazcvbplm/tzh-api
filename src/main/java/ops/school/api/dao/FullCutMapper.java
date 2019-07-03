package ops.school.api.dao;

import ops.school.api.entity.FullCut;

import java.util.List;

public interface FullCutMapper {
    int insert(FullCut record);

    int delete(int id);

    List<FullCut> findByShop(int shopId);
}