package ops.school.api.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;

import javax.validation.constraints.NotNull;

public class Charge {
    @TableId(type = IdType.AUTO)
    private Integer id;
    @NotNull
    private Integer full;
    @NotNull
    private Integer send;

    private Integer isDelete;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getFull() {
        return full;
    }

    public void setFull(Integer full) {
        this.full = full;
    }

    public Integer getSend() {
        return send;
    }

    public void setSend(Integer send) {
        this.send = send;
    }

    public Integer getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(Integer isDelete) {
        this.isDelete = isDelete;
    }
}