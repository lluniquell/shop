package kr.co.shop.mapper;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.co.shop.vo.BaesongVO;
import kr.co.shop.vo.DaeVO;
import kr.co.shop.vo.GumaeVO;
import kr.co.shop.vo.JungVO;
import kr.co.shop.vo.MemberVO;
import kr.co.shop.vo.SoVO;
import kr.co.shop.vo.ProductVO;
import kr.co.shop.vo.ProductViewVO;

public interface ProductMapper {
    public ArrayList<DaeVO> pro_write();
    public ArrayList<JungVO> getjung(String daecode);
    public ArrayList<SoVO> getso(String daejung);
    public Integer getbunho(String code);
    public void product_ok(ProductVO pvo);
    public ArrayList<ProductVO> pro_list(String pcode);
    public ProductVO pro_content(String pcode);
    public void wish_add(String userid,String pcode);
    public void cart_add(String userid,String pcode,String su);
    public ProductVO pro_gumae(String pcode);
    public MemberVO getmember(String userid);
    
    public BaesongVO getbaesong(String userid);
    public void bae_chuga(MemberVO mvo);
    
    public ArrayList<BaesongVO> baesong_list(String userid);
    public void juso_add_ok(BaesongVO bvo);
    
    public BaesongVO baesong_edit(String id);
    public void baesong_edit_ok(BaesongVO bvo);
    
    public void pro_gumae_ok(GumaeVO gvo);
    public Integer getjumun(String userid);
    public ArrayList<ProductViewVO>  product_view(String jumuncode);
    
    public int checkwish(String userid,String pcode);
    
    public void wish_cancel(String pcode, String userid);
    public void cart_del(String pcode,String userid);
 
}
