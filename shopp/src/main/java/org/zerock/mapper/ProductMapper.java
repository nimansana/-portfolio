package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.Criteria;
import org.zerock.domain.ProductVO;

public interface ProductMapper {

//	@Select("select * from tbl_board where bno>0")
	public List<ProductVO> getList();	
	public List<ProductVO> getListWithPaging(Criteria cri);
	public List<ProductVO> getListNoPaging();
	public void insert(ProductVO board);	
	public void insertSelectKey(ProductVO board);
	public ProductVO read(Long bno);
	public List<ProductVO> getCart(@Param("userid") String userid);
	public List<ProductVO> readFile(Long bno);
	public int delete(Long bno);	
	public int update(ProductVO board);
	public int getTotalCount(Criteria cri);
	public void updateReplyCnt(@Param("bno") Long bno,@Param("amount") int amount);
	
////////////////////////////////////////////
	public List<ProductVO> readTypeA();
	public List<ProductVO> readTypeB();
	public List<ProductVO> readTypeC();
//////////////////////////////////////////
	
	public List<ProductVO> get2(String userid);
	
	public ProductVO getorder(String cartnum);
	
	public void updateQuan(@Param("sales")int sales, @Param("bno")Long bno);
	
	public List<ProductVO> getImg(Long bno);
	
	public void stackmodify(@Param("bno")int bno, @Param("stack")String stack);
	
	public List<ProductVO> getListAdmin(Criteria cri);
}
