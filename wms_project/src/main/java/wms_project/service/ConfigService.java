package wms_project.service;

import java.util.List;
import java.util.Map;

import wms_project.dto.ConfigDTO;

public interface ConfigService {

	List<ConfigDTO> all(Map<String, Object> params);
	List<ConfigDTO> searchall(Map<String, Object>params);
	int update1(ConfigDTO configDTO);
	Integer Total(ConfigDTO configDTO);
	Integer totalsearch(Map<String, Object> params);
	
}
