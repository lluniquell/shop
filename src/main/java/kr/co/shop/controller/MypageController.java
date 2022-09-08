package kr.co.shop.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.shop.service.MypageService;
import kr.co.shop.vo.MemberVO;

@Controller
public class MypageController {

	@Autowired
	@Qualifier("ms2")
	private MypageService service;
	
	@RequestMapping("/mypage/myinfo")
	public String myinfo(HttpSession session,Model model)
	{
		return service.myinfo(session,model);
	}
	
	@RequestMapping("/mypage/myinfo_edit")
	public String myinfo_edit(HttpSession session,Model model)
	{
		return service.myinfo_edit(session,model);
	}
	
	@RequestMapping("/mypage/myinfo_edit_ok")
	public String myinfo_edit_ok(MemberVO mvo,HttpSession session)
	{
		return service.myinfo_edit_ok(mvo,session);
	}
	
	@RequestMapping("/mypage/change_pwd")
	public String change_pwd(HttpSession session ,HttpServletRequest request)
	{
		return service.change_pwd(session,request);
	}
	
	@RequestMapping("/mypage/wish")
	public String wish(HttpSession session, Model model) // wish테이블에서 내가 선택한 정보를 가져온다..
	{
		return service.wish(session, model);
	}
	
	@RequestMapping("/mypage/wish_del")
	public String wish_del(HttpServletRequest request)
	{
		return service.wish_del(request);
	}
	
	@RequestMapping("/mypage/select_del")
	public String select_del(HttpServletRequest request)
	{
		return service.select_del(request);
	}
	
	@RequestMapping("/mypage/move_cart")
	public String move_cart(HttpServletRequest request,HttpSession session)
	{
	    return service.move_cart(request,session);
	}
	
	@RequestMapping("/mypage/cart")
	public String cart(HttpSession session,Model model)
	{
		return service.cart(session,model);
	}
	
	@RequestMapping("/mypage/cart_del")
	public String cart_del(HttpServletRequest request)
	{
		return service.cart_del(request);
	}
	
	@RequestMapping("/mypage/myjumun")
	public String myjumun(HttpSession session, Model model)
	{
		return service.myjumun(session,model);
	}
}










