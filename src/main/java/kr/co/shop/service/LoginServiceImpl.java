package kr.co.shop.service;

import java.io.PrintWriter;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.co.shop.mapper.LoginMapper;
import kr.co.shop.vo.MemberVO;

@Service
@Qualifier("ls")
public class LoginServiceImpl implements LoginService{

	@Autowired
	private LoginMapper mapper;
	
	@Override
	public String login_ok(MemberVO mvo,HttpSession session) {
		// 사용자의 아이디와 비번을 통해 확인
		MemberVO mvo2=mapper.login_ok(mvo);
		if(mvo2 != null)
		{
			// 세션변수를 생성
			session.setAttribute("userid", mvo2.getUserid());
			session.setAttribute("name", mvo2.getName());
			return "redirect:/main/index";
		}
		else
		{
		
			return "redirect:/login/login?err=1";
		}
		 
	}

	@Override
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/main/index";
	}

	@Override
	public void userid_search_ok(MemberVO mvo, PrintWriter out) {
		 String userid=mapper.userid_search_ok(mvo);
		 if(userid==null)
			 userid="0";
		 out.print(userid);
	}

	@Override
	public void pwd_search_ok(MemberVO mvo, PrintWriter out) {
		String pwd=mapper.pwd_search_ok(mvo);
		if(pwd==null)
			pwd="0";
		out.print(pwd);
	}

}
