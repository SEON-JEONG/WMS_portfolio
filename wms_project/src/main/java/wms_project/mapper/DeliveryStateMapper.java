package wms_project.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import wms_project.dto.DeliveryStateDTO;

@Mapper
public interface DeliveryStateMapper {
	public List<DeliveryStateDTO> shipstatus(Map<String, Object> list);
	public int stateCtn(Map<String, Object> ctn);
}
