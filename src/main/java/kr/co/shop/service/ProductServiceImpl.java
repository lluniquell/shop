package kr.co.shop.service;

import static org.hamcrest.CoreMatchers.instanceOf;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.shop.mapper.ProductMapper;
import kr.co.shop.vo.BaesongVO;
import kr.co.shop.vo.CartVO;
import kr.co.shop.vo.DaeVO;
import kr.co.shop.vo.GumaeVO;
import kr.co.shop.vo.JungVO;
import kr.co.shop.vo.MemberVO;
import kr.co.shop.vo.ProductVO;
import kr.co.shop.vo.ProductViewVO;
import kr.co.shop.vo.QuestionVO;
import kr.co.shop.vo.SoVO;

@Service
@Qualifier("ps")
public class ProductServiceImpl implements ProductService{

	@Autowired
	private ProductMapper mapper;
	
	@Override
	public String pro_write(Model model) {
		// dae테이블을 읽어와서 view에 전달
		ArrayList<DaeVO> list=mapper.pro_write();
		model.addAttribute("list",list);
		return "/product/pro_write";
	}

	@Override
	public void getjung(HttpServletRequest request, PrintWriter out) {
		String daecode=request.getParameter("daecode");
		ArrayList<JungVO> list=mapper.getjung(daecode);
		// option태그를 생성해도 전달
		String str="";
	    // ArrayList => list.get(0)....  
		for(int i=0;i<list.size();i++)
		{
			JungVO jvo=list.get(i);
			// 문자열과 변수는 +연산을 통해 연결			 
			str=str+"<option value='"+jvo.getCode()+"'>"+URLEncoder.encode(jvo.getTitle())+"</option>";
			         // <option value='01'> 야채류 </option>
		}
		
		out.print(str);
	}

	@Override
	public void getso(HttpServletRequest request, PrintWriter out) {
		 String daejung=request.getParameter("daejung");
		 ArrayList<SoVO> list=mapper.getso(daejung);
		 String str="";
	 	 for(int i=0;i<list.size();i++)
		 {
			SoVO svo=list.get(i);
			str=str+"<option value='"+svo.getCode()+"'>"+URLEncoder.encode(svo.getTitle())+"</option>";
		 }
			
			out.print(str);
	}

	@Override
	public void getbunho(HttpServletRequest request, PrintWriter out) {
		 String code=request.getParameter("code");
		 Integer bunho=mapper.getbunho(code);
		 out.print(bunho);
	}

	@Override
	public String product_ok(HttpServletRequest request) {
		// 라이브러리를 이용하여 폼태그에 값을 가져오기
		String path="C:\\spring\\shop\\src\\main\\webapp\\resources\\img";
		int size=1024*1024*20;
		ProductVO pvo=new ProductVO();
		try
		{
		  MultipartRequest multi=new MultipartRequest(request,path,size,"utf-8",new DefaultFileRenamePolicy());
		  // 폼값 가져오기 => ProductVO에 넣기
		  
		  /*String pcode=request.getParameter("pcode");
		  pvo.setPcode(pcode);*/
		  pvo.setPcode(multi.getParameter("pcode"));
		  pvo.setPimg(multi.getFilesystemName("pimg"));
		  pvo.setCimg(multi.getFilesystemName("cimg"));
		  pvo.setTitle(multi.getParameter("title"));
		  pvo.setPrice(Integer.parseInt(multi.getParameter("price")));
		  pvo.setMade(multi.getParameter("made"));
		  pvo.setHalin(Integer.parseInt(multi.getParameter("halin")));
		  pvo.setJuk(Integer.parseInt(multi.getParameter("juk")));
		  pvo.setSu(Integer.parseInt(multi.getParameter("su")));
		  pvo.setBaesong(Integer.parseInt(multi.getParameter("baesong")));
		  pvo.setBaeday(Integer.parseInt(multi.getParameter("baeday")));
		}
		catch(Exception e)
		{
			// return "redirect:error";
		}
		mapper.product_ok(pvo);
		return "/product/pro_list";
	}

	@Override
	public String pro_list(HttpServletRequest request, Model model) {
		// 필요한 상품리스트를 가져와서 view에 전달
		String pcode=request.getParameter("pcode");
		ArrayList<ProductVO> list=mapper.pro_list(pcode);
		/*
		for(int i=0;i<list.size();i++)
		{
			int n=list.get(i).getBaeday();
			LocalDate today=LocalDate.now();
			LocalDate dday=today.plusDays(n);
			list.get(i).setBaeday2=dday.toString();
		}
		*/
		model.addAttribute("list",list);
		return "/product/pro_list";
	}
	
	
	@Override
	public String index(Model model) {
		ArrayList<ProductVO> nlist=mapper.pro_list_new();
		model.addAttribute("nlist",nlist);
		ArrayList<ProductVO> mlist=mapper.pro_list_manysell();
		model.addAttribute("mlist",mlist);
		ArrayList<ProductVO> slist=mapper.pro_list_sale();
		model.addAttribute("slist",slist);
		return "/main/index";
	}
	

	

	@Override
	public String pro_content(HttpSession session,HttpServletRequest request, Model model) {
		// 하나의 레코드를 읽어와서 model에 전달 view를 리턴
		String pcode=request.getParameter("pcode");
		ProductVO pvo=mapper.pro_content(pcode);
		model.addAttribute("pvo",pvo);
		
		// 현재사용자의 wish테이블에 상품이 저장되어 있는지 확인해서 view에 전달
		int wishcnt;
		if(session.getAttribute("userid")==null)
		{
			wishcnt=0;
		}
		else 
		{
			// 테이블에서 확인(존재여부)
			String userid=session.getAttribute("userid").toString();
			int num=mapper.checkwish(userid,pcode);
			if(num==0)
			{
				wishcnt=0;
			}
			else
			{
				wishcnt=1;
			}
		}
		model.addAttribute("wishcnt",wishcnt);
		
		//상품문의를 읽어서 전달
		ArrayList<QuestionVO> qlist=mapper.get_question(pcode);
		// content에 br 붙이기
		for(int i=0;i<qlist.size();i++) {
			qlist.get(i).setContent(qlist.get(i).getContent().replace("\r\n", "<br>"));
		}
		model.addAttribute("qlist",qlist);
		
		return "/product/pro_content";
	}

	@Override
	public void wish_add(HttpSession session, HttpServletRequest request, PrintWriter out) {
		 String userid=session.getAttribute("userid").toString();
		 String pcode=request.getParameter("pcode");
		 
		 // 아이디,pcode를 넘겨서 레코드가 존재하는지 체크
		 // 있다면 아래의 내용을 실행 X
		 mapper.wish_add(userid,pcode);
		
		 out.print("0");
	}

	@Override
	public void cart_add(HttpSession session, HttpServletRequest request, PrintWriter out) {
         String userid=session.getAttribute("userid").toString();
         String pcode=request.getParameter("pcode");
         String su=request.getParameter("su");
         
         mapper.cart_add(userid,pcode,su);
         
         out.print("0");
			
	}

	@Override
	public String pro_gumae(HttpServletRequest request, Model model,HttpSession session) {
		// 해당상품의 정보를 뷰에 전달
		String[] pcode=request.getParameter("pcode").split(",");
		String[] su=request.getParameter("su").split(",");
		String gchk=request.getParameter("gchk");
		ArrayList<ProductVO> list=new ArrayList<ProductVO>();
		for(int i=0;i<pcode.length;i++)
		{
			ProductVO pvo=mapper.pro_gumae(pcode[i]);
			pvo.setSu(Integer.parseInt(su[i]));
			list.add(pvo);
		}
	    model.addAttribute("gchk",gchk);  // wish에서 오면 1, cart에서 오면 2
		model.addAttribute("list",list);
		//model.addAttribute("su",su);
		
		// 회원정보
		String userid=session.getAttribute("userid").toString();
		MemberVO mvo=mapper.getmember(userid);
		model.addAttribute("mvo",mvo);
		
		// 배송지 정보
		BaesongVO bvo=mapper.getbaesong(userid);
		model.addAttribute("bvo",bvo);
		return "/product/pro_gumae";
	}

	@Override // 배송지테이블에 정보가 없을때 한번 사용
	public void bae_chuga(HttpSession session, PrintWriter out) {
		// member테이블에서 필요한 정보를 읽어온다.
		String userid=session.getAttribute("userid").toString();
		MemberVO mvo=mapper.getmember(userid);
		// member테이블의 주소를 baesong테이블에 전달 
		mapper.bae_chuga(mvo);
		// out을 통해 주소를 view에 전달
	    String str="";       //  홍길동 , 고양시 어쩌구 저쩌구 , 010-1234-5678
	    str=URLEncoder.encode(mvo.getName())+",";      // URLEncoder.encode(이름), 주소, 상세주소
	    str=str+URLEncoder.encode(mvo.getJuso())+" "+URLEncoder.encode(mvo.getJuso_etc())+",";
	    str=str+mvo.getPhone();
	    
	    str=str.replace("+", " ");
	    
	    out.print(str);
	}

	@Override
	public String baesong_list(HttpSession session,Model model) {
		// 배송테이블에서 해당사용자의 주소를 전부 가져와서 전달
		String userid=session.getAttribute("userid").toString();
		ArrayList<BaesongVO> list=mapper.baesong_list(userid);
		model.addAttribute("list",list);
		return "/product/baesong_list";
	}

	@Override
	public String juso_add_ok(BaesongVO bvo,HttpSession session) {
		bvo.setUserid(session.getAttribute("userid").toString());
		mapper.juso_add_ok(bvo);
		return "redirect:/product/baesong_list";
	}

	@Override
	public String baesong_edit(HttpServletRequest request, Model model) {
		String id=request.getParameter("id");
		BaesongVO bvo=mapper.baesong_edit(id);
		model.addAttribute("bvo",bvo);
		return "/product/baesong_edit";
	}

	@Override
	public String baesong_edit_ok(BaesongVO bvo) {
		mapper.baesong_edit_ok(bvo);
		return "redirect:/product/baesong_list";
   }

	@Override
	public String pro_gumae_ok(GumaeVO gvo,HttpSession session) {
		String userid=session.getAttribute("userid").toString();
		gvo.setUserid(userid);		
			
		// 주문번호생성 => 아이디+4자리
		// 가장 높은 주문번호를 가져오기
		Integer number=mapper.getjumun(userid);
		number++;  // 4자리로 변경
		
		String num=number.toString();
		
		if(num.length()==1)
			num="000"+num;
		else if(num.length()==2)
		        num="00"+num;
			 else if(num.length()==3)
		             num="0"+num;
		
		String jumuncode=userid+num;
		
		gvo.setJumuncode(jumuncode);
		
		// pcode,su,chong금액을 배열로 저장
		String[] pcode=gvo.getPcode().split(","); // "p010101001 , p010102055 , p010101006"
		String[] su=gvo.getSu_imsi().split(",");
		String[] chong=gvo.getChong_imsi().split(",");
		
		// 위의 배열에 있는값을 gvo의  pcode, su, chong setter
		for(int i=0;i<pcode.length;i++)
		{	
			gvo.setPcode(pcode[i]);
			gvo.setSu(Integer.parseInt(su[i]));
			gvo.setChong(Integer.parseInt(chong[i]));
		    mapper.pro_gumae_ok(gvo);
		    
		    if(gvo.getGchk()==2)
		    {
 		       // cart테이블에서 삭제
		       mapper.cart_del(pcode[i],userid);
		    }
		    else if(gvo.getGchk()==1)
		         {
		           // wish테이블에서 삭제
		           mapper.wish_cancel(pcode[i],userid);
		         }
		}
		
		return "redirect:/product/product_view?jumuncode="+jumuncode;
	}

	@Override
	public String product_view(HttpServletRequest request, Model model) {
	    String jumuncode=request.getParameter("jumuncode");
	    ArrayList<ProductViewVO> list= mapper.product_view(jumuncode);
		model.addAttribute("list",list);
		return "/product/product_view";
	}

	@Override
	public String wish_cancel(HttpSession session,HttpServletRequest request) {
		String pcode=request.getParameter("pcode");
		String userid=session.getAttribute("userid").toString();
		mapper.wish_cancel(pcode,userid);
		return "redirect:/product/pro_content?pcode="+pcode;
	}

	@Override
	public String qwrite_ok(QuestionVO qvo, HttpSession session) {
		//email 구하기
		String userid=session.getAttribute("userid").toString();
		String email=mapper.get_email(userid);
		qvo.setEmail(email);
		
		//qrp 구하기
		int grp=mapper.get_grp();
		grp++;
		qvo.setGrp(grp);		
		
		// question 테이블에 입력
		mapper.qwrite_ok(qvo);
		return "redirect:/product/pro_content?pcode="+qvo.getPcode();
	}

	@Override
	public String cart_view(HttpSession session, Model model) {
		String userid=session.getAttribute("userid").toString();
		ArrayList<CartVO> clist=mapper.cart_view(userid);
		model.addAttribute("clist",clist);
		
		return "/product/cart_view";
	}

	@Override
	public String find_view(HttpServletRequest request, Model model) {
		String keyword=request.getParameter("keyword");
		ArrayList<ProductVO> klist=mapper.find_view(keyword);
		System.out.println("키워드 :" + keyword);
		model.addAttribute("klist",klist);
		model.addAttribute("keyword",keyword);
		return "/product/find_view";
	}

	
	

	

}










