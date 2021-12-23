package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.Criteria;
import org.zerock.domain.ProductAttachVO;
import org.zerock.domain.ProductVO;
import org.zerock.mapper.ProductAttachMapper;
import org.zerock.mapper.ProductMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ProductServiceImpl implements ProductService{


	@Setter(onMethod_=@Autowired)
	private ProductMapper mapper;
	
	@Setter(onMethod_=@Autowired)
	private ProductAttachMapper attachMapper;
	
	@Override
	public void register(ProductVO board) {
		log.info("register......"+board);
		
		mapper.insertSelectKey(board);
		
		if(board.getAttachList()==null || board.getAttachList().size()<=0) {
			return;
		}
		
		board.getAttachList().forEach(attach->{
			attach.setBno(board.getBno());
			attachMapper.insert(attach);
		});
	}

	@Override
	public ProductVO get(Long bno) {
		log.info("번호로 조회하기(service)..."+bno);
		return mapper.read(bno);
	}
	
	@Override
	public List<ProductVO> getFile(Long bno) {
		log.info("getFile(service)..."+bno);
		return mapper.readFile(bno);
	}

	@Override
	public boolean modify(ProductVO board) {
		log.info("modify..........."+board);
		
		attachMapper.deleteAll(board.getBno());
		
		boolean modifyResult=mapper.update(board)==1;
		
		if(modifyResult && board.getAttachList()!=null && board.getAttachList().size()>0) {
			board.getAttachList().forEach(attach->{
				attach.setBno(board.getBno());
				attachMapper.insert(attach);
			});
		}
		
		return modifyResult;
	}
	@Transactional
	@Override
	public boolean remove(Long bno) {
		log.info("remove.........."+bno);
		
		attachMapper.deleteAll(bno);
		
		return mapper.delete(bno)==1;
	}

	@Override
	public List<ProductVO> getList(Criteria cri) {
		log.info("테이블가져오기(service): "+cri);
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		log.info("전체갯수 조회");
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<ProductAttachVO> getAttachList(Long bno) {
		log.info("get Attach listby bno"+bno);
		
		return attachMapper.findByBno(bno);
	}

	@Override
	public List<ProductVO> getTypeA() {
		
		return mapper.readTypeA();
	}

	@Override
	public List<ProductVO> getTypeB() {
		return mapper.readTypeB();
	}

	@Override
	public List<ProductVO> getTypeC() {
		return mapper.readTypeC();
	}
	/////////////////////////카트///////////////////////////
	@Override
	public List<ProductVO> get2(String userid) {
		return mapper.get2(userid);
	}

	@Override
	public List<ProductVO> getListNoPaging() {
		return mapper.getListNoPaging();
	}

	@Override
	public ProductVO getorder(String cartnum) {
		ProductVO product = new ProductVO();
		product = mapper.getorder(cartnum);
		log.info("service: "+product);
		Long bno = product.getBno();
		log.info("bno: "+bno);
		
		List<ProductVO> list = mapper.getImg(bno);
		String uuid = list.get(0).getUuid();
		String filename = list.get(0).getFilename();
		
		product.setUuid(uuid);
		product.setFilename(filename);
		
		return product;
	}

	@Override
	public void updateQuant(int sales, Long bno) {
		
		mapper.updateQuan(sales, bno);
		
	}
	
	@Override
	public void stackmodify(int bno, String stack) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<ProductVO> getListAdmin(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getListAdmin(cri);
	}

	
}
