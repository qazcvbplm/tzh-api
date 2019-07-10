package ops.school.api.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import ops.school.api.entity.Slide;

import java.util.List;

public interface SlideMapper extends BaseMapper<Slide> {
    int insert(Slide record);

    int insertSelective(Slide record);


    Slide findById(Integer id);

    int updateByPrimaryKeySelective(Slide record);

    int updateByPrimaryKey(Slide record);

    List<Slide> find(int schoolId);
}