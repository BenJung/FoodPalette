package m_controller;

import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import logic.CheckCatalog;
import logic.DeleteCatalog;
import logic.InsertCatalog;
import logic.RecipeBook;
import logic.RecipeBookUtil;


@Controller
public class Mobile_RecipebookController {
	@Autowired
	private CheckCatalog checkCatalog;
	@Autowired
	private InsertCatalog insertCatalog;
	@Autowired
	private DeleteCatalog deleteCatalog;
	
	//레시피 스크랩 하기 메서드
	@ResponseBody
	@RequestMapping(value="/mobile_Recipebook/m_clip_recipe.html", method=RequestMethod.GET)
	public String cilpRecipe(String recipe_id, HttpSession session){
		//log
		System.out.println("레시피 스크랩 하기 메서드");
		
		//clip_user 생성
		String clip_user = (String)session.getAttribute("user_nick");
		
		
		//clip_order 생성
		Integer clip_order = checkCatalog.getMaxCilpOrder(clip_user);
		if(clip_order == null){
			clip_order = 1;
		}else{
			clip_order++;
		}
		
		//log
		System.out.println("recipe_id : "+recipe_id);
		System.out.println("clip_user : "+clip_user);
		System.out.println("clip_order : "+clip_order);
		
		
		//VO저장
		RecipeBook recipeBook = new RecipeBook();
		recipeBook.setClip_order(clip_order);
		recipeBook.setClip_user(clip_user);
		recipeBook.setRecipe_id(recipe_id);
	
		//DB연동
		this.insertCatalog.postRecipeBook(recipeBook);
		
		System.out.println("스크랩 DB 연동 완료");
		
		return "clip ok";
	}

	
	//레시피 스크랩 삭제 메서드
	@ResponseBody
	@RequestMapping(value="mobile_Recipebook/m_delete_clip_recipe",method=RequestMethod.GET)
	public String deleteClip(String recipe_id, HttpSession session){
		//clip_user 가져오기
		String clip_user = (String)session.getAttribute("user_nick");
		
		//VO 저장
		RecipeBookUtil recipeBookUtil = new RecipeBookUtil();
		recipeBookUtil.setClip_user(clip_user);
		recipeBookUtil.setRecipe_id(recipe_id);
		
		
		//DB연동
		Integer result = this.deleteCatalog.deleteRecipeBook(recipeBookUtil);
		
		if(result>0) System.out.println("스크랩한 레시피 삭제 완료");
		
		return "del ok";
	}
	
	
	@RequestMapping(value="/mobile_Recipebook/m_my_clip_list.html",method=RequestMethod.GET)
	public ModelAndView myClipRecipeShow(HttpSession session){
		String clip_user = (String)session.getAttribute("user_nick");
		
		//리스트 초기 작업
		int maxClip = this.checkCatalog.getMaxClipByUser(clip_user);
		
		//행값(tr) 생성
		int[] tr_index = new int[(maxClip/3+1)];
		int max = maxClip/3+1;
		for(int i=1; i<=max; i++){
			tr_index[i-1] = i;
		}
		
		//스크랩 리스트 가져오기
		List<RecipeBookUtil> rbu = this.checkCatalog.getClipImgByUser(clip_user);
		Iterator it = rbu.iterator();
		String[] firstImg = new String[rbu.size()];
		int cnt = 0;
		while(it.hasNext()){
			RecipeBookUtil image = (RecipeBookUtil)it.next();
			System.out.println("스크랩 여부 이미지값:"+image.getRecipe_img1());
			System.out.println("스크랩 여부 레시피ID값:"+image.getRecipe_id());
			firstImg[cnt] = image.getRecipe_img1();
			cnt++;
		}
		
		ModelAndView mav = new ModelAndView("mobile_home/m_recipeBook");
		mav.addObject("MAX",max);
		mav.addObject("TR_INDEX",tr_index);
		mav.addObject("FIRST_IMGS",firstImg);
		mav.addObject("LIST",rbu);
		return mav;
	}
	
	
}
