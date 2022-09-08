package kr.co.shop.mapper;

import java.util.ArrayList;

import kr.co.shop.vo.CounselVO;
import kr.co.shop.vo.MemberVO;

public interface MemberMapper {
    public void memberinput_ok(MemberVO mvo);
    public int check_userid(String userid);
    public void cwrite_ok(CounselVO cvo);
    public ArrayList<CounselVO> clist(String userid);
    public CounselVO ccontent(int id);
    public void ccontent_del(String id);
    public void ccontent_update_ok(CounselVO cvo);
	
}
