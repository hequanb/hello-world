package cn.hqb.pets.service.baike;

import java.util.List;

import cn.hqb.pets.comm.LayuiTableData;
import cn.hqb.pets.comm.Result;
import cn.hqb.pets.pojo.baike.TBaike;
import cn.hqb.pets.vo.baike.TAllBaikeVo;
import cn.hqb.pets.vo.baike.TBaikeVo;

public interface BaikeService {
	
	Result insert(TBaike baike);
	
	Result delete(Long id);
	
	LayuiTableData getBaikeList(TBaikeVo vo);
	
	TBaike getBaikeById(Long id);
	
	Result update(TBaike baike);
	
	TAllBaikeVo getAllBaike();
	
	List<TBaike> getKindOfBaike(Integer cid);
	
}
