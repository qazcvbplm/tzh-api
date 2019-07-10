package ops.school.api.service;

import com.baomidou.mybatisplus.extension.service.IService;
import ops.school.api.entity.RunOrders;

import javax.validation.Valid;
import java.util.List;

public interface RunOrdersService extends IService<RunOrders> {

    int pl(String id);

    void add(@Valid RunOrders orders);

    List<RunOrders> find(RunOrders orders);

    int count(RunOrders orders);

    RunOrders findById(String orderId);

    int paySuccess(String orderId, String string);

    void remove();

    int cancel(String id);

    int countBySchoolId(int schoolId);


}
