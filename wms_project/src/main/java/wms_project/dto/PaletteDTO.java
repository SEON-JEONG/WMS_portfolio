package wms_project.dto;

import lombok.Data;
import org.springframework.stereotype.Repository;

@Data
@Repository("PaletteDTO")
public class PaletteDTO {
    int pidx;
    String pname, pcode, psize, pcolor, pusing, mspot, pdate;

    String search;
}
