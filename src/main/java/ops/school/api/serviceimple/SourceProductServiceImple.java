package ops.school.api.serviceimple;

import ops.school.api.dao.SourceProductMapper;
import ops.school.api.entity.SourceProduct;
import ops.school.api.service.SourceProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.validation.Valid;
import java.util.List;

@Service
public class SourceProductServiceImple implements SourceProductService {

    @Autowired
    private SourceProductMapper sourceProductMapper;

    @Override
    public void add(@Valid SourceProduct sourceProduct) {
        sourceProductMapper.insert(sourceProduct);
    }

    @Override
    public List<SourceProduct> find(SourceProduct sourceProduct) {
        return sourceProductMapper.find(sourceProduct);
    }

    @Override
    public int update(SourceProduct sourceProduct) {
        // TODO Auto-generated method stub
        return sourceProductMapper.updateByPrimaryKeySelective(sourceProduct);
    }
}
