package m_controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;

import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import logic.CheckCatalogImpl;
import logic.Comment;
import logic.DeleteCatalogImpl;
import logic.InsertCatalogImpl;
import logic.UpdateCatalogImpl;

@Controller
public class Mobile_CommentController {

	//DB연동 DAO들
	@Autowired
	CheckCatalogImpl check;
	@Autowired
	InsertCatalogImpl insert;
	@Autowired
	UpdateCatalogImpl update;
	@Autowired
	DeleteCatalogImpl delete;

	//댓글게시용 메서드
	@RequestMapping(value="/mobile_Comment/insert_Comment.html", method=RequestMethod.POST)
	public ModelAndView postComment(Comment comment, BindingResult br, HttpServletRequest request){
		ModelAndView mav = new ModelAndView();
		
		System.out.println("CommentController 들어옴");
		System.out.println("전달받은 recipe_id : "+comment.getRecipe_id());
		System.out.println("전달받은 user_nick : "+comment.getUser_nick());
		System.out.println("전달받은 comment_text : "+comment.getComment_text());
		
		try{
		System.out.println("한글처리 전달받은 comment_text : "+URLEncoder.encode(comment.getComment_text(),"euc-kr"));
		request.setCharacterEncoding("euc-kr");
		}catch(UnsupportedEncodingException e){}
		
		//comment_info에 insert
		int maxCommentOrder = check.getMaxCommentOrder(comment.getRecipe_id());
		//max comment_order+1을 set해줌
		comment.setComment_order(maxCommentOrder+1);
		System.out.println("maxCommentOrder : "+maxCommentOrder);
		
		//comment_posttime
		DateTime dt = new DateTime();
		DateTimeFormatter fmt = DateTimeFormat.forPattern("yyMMddHHmmss");
		String comment_posttime = fmt.print(dt);
		comment.setComment_posttime(comment_posttime);
		System.out.println("comment_posttime : "+comment_posttime);
		
		
		//comment insert 시킴
		insert.postComment(comment);
		//redirect:/list/recipe_selected.html?id=${recipe.recipe_id}
		mav.setViewName("redirect:/mobile_List/recipe_selected.html?id="+comment.getRecipe_id());
		return mav;
	}
	 
	//댓글삭제용 메서드
	@RequestMapping(value="/mobile_Comment/delete_Comment.html", method=RequestMethod.GET)
	public ModelAndView deleteComment(String recipe_id, String user_nick, int comment_order){
		System.out.println("commentDelete에서 전달받은 recipe_id : ["+recipe_id+"]");
		System.out.println("commentDelete에서 전달받은 user_nick : ["+user_nick+"]");
		System.out.println("commentDelete에서 전달받은 comment_order : ["+comment_order+"]");
		
		//공백제거
		String rec_id = recipe_id.trim();
		String user_nk = user_nick.trim();
		
		ModelAndView mav = new ModelAndView();
		
		//댓글 delete
		Comment comment = new Comment();
		comment.setRecipe_id(rec_id);
		comment.setUser_nick(user_nk);
		comment.setComment_order(comment_order);
		
		delete.deleteComment(comment);
		
		mav.setViewName("redirect:/mobile_List/recipe_selected.html?id="+recipe_id);
		return mav;
	}

}
