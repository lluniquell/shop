package kr.co.shop.service;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import kr.co.shop.mapper.MemberMapper;
import kr.co.shop.vo.CounselVO;
import kr.co.shop.vo.MemberVO;

@Service
@Qualifier("ms")
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberMapper mapper;
	
	@Override
	public String memberinput_ok(MemberVO mvo) {
		mapper.memberinput_ok(mvo);
		return "/login/login";
	}

	@Override
	public void check_userid(HttpServletRequest request, PrintWriter out) {
		 String userid=request.getParameter("userid");
		 int chk=mapper.check_userid(userid);
		 out.print(chk);
	}

	@Override
	public String cwrite_ok(CounselVO cvo, HttpSession session) {
		String userid=session.getAttribute("userid").toString();
		cvo.setUserid(userid);
		mapper.cwrite_ok(cvo);
		
		return "redirect:/member/clist";
	}

	@Override
	public String clist(HttpSession session, Model model) {
		String userid=session.getAttribute("userid").toString();
		ArrayList<CounselVO> clist=mapper.clist(userid);
		model.addAttribute("clist",clist);
		return "/member/clist";
	}

	@Override
	public String ccontent(CounselVO cvo, Model model) {
		
		model.addAttribute("cvo",mapper.ccontent(cvo.getId()));
		
		return "/member/ccontent";
	}

	@Override
	public String ccontent_del(HttpServletRequest request) {
		String id=request.getParameter("id");
		mapper.ccontent_del(id);
		return "redirect:/member/clist";
	}

	@Override
	public String ccontent_update(HttpServletRequest request, Model model) {
		int id=Integer.parseInt(request.getParameter("id"));
		model.addAttribute("cvo",mapper.ccontent(id));
		return "/member/ccontent_update";
	}

	@Override
	public String ccontent_update_ok(CounselVO cvo) {
		mapper.ccontent_update_ok(cvo);
		
		return "redirect:/member/ccontent?id="+cvo.getId();
		
	}

}
