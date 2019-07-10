package ops.school.api.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import ops.school.api.entity.FullCut;

import java.util.List;

public interface FullCutMapper extends BaseMapper<FullCut> {
    int insert(FullCut record);

    int delete(int id);

    List<FullCut> findByShop(int shopId);
}