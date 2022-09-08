package kr.co.shop.mapper;

import java.util.ArrayList;

import kr.co.shop.vo.CartVO;
import kr.co.shop.vo.GumaeVO;
import kr.co.shop.vo.MemberVO;
import kr.co.shop.vo.WishVO;

public interface MypageMapper {
   public MemberVO  myinfo(String userid);
   public void myinfo_edit_ok(MemberVO mvo);
   public String getPwd(String userid);
   public void change_pwd(String pwd, String userid);
   public ArrayList<WishVO> wish(String userid);
   public void wish_del(String id);
   public void move_cart(String userid,String pcode);
   public void wish_del2(String userid,String pcode);
   public ArrayList<CartVO> cart(String userid);
   
   public void cart_del(String id);
   
   public ArrayList<GumaeVO> myjumun(String userid);
}
