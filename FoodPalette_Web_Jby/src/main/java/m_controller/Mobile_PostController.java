package m_controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import logic.CheckCatalog;
import logic.DeleteCatalog;
import logic.HeartUtil;
import logic.InsertCatalog;
import logic.RecipeInfo;
import logic.UpdateCatalog;
import logic.UploadUtil;
import utils.PostValidator;

@Controller
public class Mobile_PostController{
	
	@Autowired
	private CheckCatalog checkCatalog;
	@Autowired
	private InsertCatalog insertCatalog;
	
	@Autowired
	private UpdateCatalog updateCatalog;
	@Autowired
	private DeleteCatalog deleteCatalog;
	@Autowired
	private PostValidator postValidator;

	//////////////////각종 메서드들
	//처음파일 NULL 오류처리 메서드
	private ModelAndView findFirstNullFile(RecipeInfo recipeInfo, BindingResult br){
		if(recipeInfo.getImg_food().get(0).getOriginalFilename().equals("")) {
			//log
			System.out.println("한장의 사진도 올리지 않은 경우");
			
			//페이지전환
			ModelAndView mav = new ModelAndView("mobile_home/m_postRecipe_img");
			br.reject("error.upload.not_frist_img");
			mav.addObject(recipeInfo);
			return mav;
		}
		return null;
	}
	
	//jung 4.29
	//그림파일 아닌 경우 또는 한글파일인 경우 오류처리 메서드
	private ModelAndView findNotImgFile(RecipeInfo recipeInfo, BindingResult br){
		List<MultipartFile> img_filter = recipeInfo.getImg_food();
		Iterator filter_it = img_filter.iterator();
		
		while(filter_it.hasNext()){
			MultipartFile imgs = (MultipartFile)filter_it.next();
			String fileName = imgs.getOriginalFilename();
			boolean checkNameIfItisKoreanWord = fileName.matches(".*[ㄱ-ㅎㅏ-ㅣ가-힣]+.*");
			if(!fileName.contains(".jpg") && !fileName.contains(".gif") && !fileName.contains(".png") && !fileName.equals("") || checkNameIfItisKoreanWord){
				//log
				if(checkNameIfItisKoreanWord) System.out.println("한글파일이름 업로드 경우");
				else System.out.println("이미지타입이 아닌 파일 업로드 경우");
				
				//페이지전환
				ModelAndView mav = new ModelAndView("mobile_home/m_postRecipe_img");
				if(checkNameIfItisKoreanWord)br.reject("error.upload.is_korean_file");
				else br.reject("error.upload.not_img_file");
				recipeInfo.getImg_food().clear();
				mav.addObject(recipeInfo);
				return mav;
			}
		}
		return null;
	}
	
	//그림파일중 5.0MB이상의 그림이 있는 경우 에러 처리 메서드
	private ModelAndView findImgMoreThanMaxSize(RecipeInfo recipeInfo, BindingResult br){
		List<MultipartFile> img_filter = recipeInfo.getImg_food();
		Iterator filter_it = img_filter.iterator();
		
		while(filter_it.hasNext()){
			MultipartFile imgs = (MultipartFile)filter_it.next();
			double fileSize = imgs.getSize()/1024.0d/1024.0d;
			System.out.println("이미지 사이즈 : "+fileSize);
			if(fileSize > 5.00d){
				//log
				System.out.println("이미지 파일 중 5MB가 넘는 파일이 있는 경우");
				
				//페이지전환
				ModelAndView mav = new ModelAndView("mobile_home/m_postRecipe_img");
				br.reject("error.upload.max_size_img");
				recipeInfo.getImg_food().clear();
				mav.addObject(recipeInfo);
				return mav;
			}
		}
		return null;
	}
	
	//중간,끝에 NUll이 있는 경우 처리
	private Integer getSizeIfImgsHaveNull(RecipeInfo recipeInfo){
		//log
		System.out.println("이미지 파일 중 중간, 끝이 NULL인 경우");
	
		//이미지 배열값 계산
		List<MultipartFile> img_filter = recipeInfo.getImg_food();
		Iterator filter_it = img_filter.iterator();
		int count = 0;
		while(filter_it.hasNext()){
			MultipartFile imgs = (MultipartFile)filter_it.next();
			String fileName = imgs.getOriginalFilename();
			if(!fileName.equals("")){
				count++;
			}
		}
		
		System.out.println("이미지 배열 사이즈 : "+count);
		return count;
	}
	
	//해쉬태그, 레시피 내용 에러(null)처리 메서드
	private ModelAndView findRecipeContentAndHashtagIsNull(RecipeInfo recipeInfo,BindingResult br, String flag){
		//데이터 저장
		String recipe_content = recipeInfo.getRecipe_content().trim();
		String recipe_hashtag = recipeInfo.getRecipe_hashtag().trim();
	
		//레시피내용, 해쉬태그 에러 처리
		if(recipe_content.equals("") || recipe_hashtag.equals("") || recipe_hashtag.equals("#")){
					
			System.out.println("해쉬태그 오류 : "+recipe_hashtag);
			
			//에러발생
			if(recipe_content.equals("") && recipe_hashtag.equals("")) br.reject("error.upload.all_input_null");
			else if(recipe_hashtag.equals("")) br.reject("error.upload.recipe_hashtag_null");
			else if(recipe_content.equals("")) br.reject("error.upload.recipe_content_null");
			else if(recipe_hashtag.equals("#")) br.reject("error.upload.recipe_hashtag_null");
			
			//화면전환	
			ModelAndView mav = new ModelAndView();
			mav.addObject(recipeInfo);
			System.out.println("오류 검출 후 img1 : "+recipeInfo.getRecipe_img1());

			//이미지 배열에 저장
			String[] fileName = new String[recipeInfo.getRecipe_img_order()];
			fileName = saveImgToArray(recipeInfo, "error");
			mav.addObject("IMGS", fileName);
			System.out.println("오류 검출 후 img1 배열값 : "+fileName[0]);

			
			if(flag.equals("upload")) mav.setViewName("mobile_home/m_postRecipe_content");
			else if(flag.equals("modify")) mav.setViewName("mobile_home/m_modifyRecipe_content");
			return mav;
		}
		return null;
	}
	
	//이미지 파일명 배열 저장 메서드
	private String[] saveImgToArray(RecipeInfo recipeInfo, String flag){
		String[] img_name = new String[recipeInfo.getRecipe_img_order()];
		System.out.println("수정할 이미지 파일명 "+recipeInfo.getRecipe_img1());
		int start = 0; if(flag.equals("upload")) start=24; 
		if(recipeInfo.getRecipe_img1()!=null) img_name[0] = (recipeInfo.getRecipe_img1().substring(start,recipeInfo.getRecipe_img1().length()));
		if(recipeInfo.getRecipe_img2()!=null) img_name[1] = (recipeInfo.getRecipe_img2().substring(start,recipeInfo.getRecipe_img2().length()));
		if(recipeInfo.getRecipe_img3()!=null) img_name[2] = (recipeInfo.getRecipe_img3().substring(start,recipeInfo.getRecipe_img3().length()));
		if(recipeInfo.getRecipe_img4()!=null) img_name[3] = (recipeInfo.getRecipe_img4().substring(start,recipeInfo.getRecipe_img4().length()));
		if(recipeInfo.getRecipe_img5()!=null) img_name[4] = (recipeInfo.getRecipe_img5().substring(start,recipeInfo.getRecipe_img5().length()));
		if(recipeInfo.getRecipe_img6()!=null) img_name[5] = (recipeInfo.getRecipe_img6().substring(start,recipeInfo.getRecipe_img6().length()));
		if(recipeInfo.getRecipe_img7()!=null) img_name[6] = (recipeInfo.getRecipe_img7().substring(start,recipeInfo.getRecipe_img7().length()));
		if(recipeInfo.getRecipe_img8()!=null) img_name[7] = (recipeInfo.getRecipe_img8().substring(start,recipeInfo.getRecipe_img8().length()));
		if(recipeInfo.getRecipe_img9()!=null) img_name[8] = (recipeInfo.getRecipe_img9().substring(start,recipeInfo.getRecipe_img9().length()));
		if(recipeInfo.getRecipe_img10()!=null) img_name[9] = (recipeInfo.getRecipe_img10().substring(start,recipeInfo.getRecipe_img10().length()));
		return img_name;
	}
	
	//이미지 파일 VO저장 매서드
	private RecipeInfo saveImgInValueObject(RecipeInfo recipeInfo){
		int start = 24;
		if(recipeInfo.getRecipe_img1()!=null) recipeInfo.setRecipe_img1(recipeInfo.getRecipe_img1().substring(start,recipeInfo.getRecipe_img1().length()));
		if(recipeInfo.getRecipe_img2()!=null) recipeInfo.setRecipe_img2(recipeInfo.getRecipe_img2().substring(start,recipeInfo.getRecipe_img2().length()));
		if(recipeInfo.getRecipe_img3()!=null) recipeInfo.setRecipe_img3(recipeInfo.getRecipe_img3().substring(start,recipeInfo.getRecipe_img3().length()));
		if(recipeInfo.getRecipe_img4()!=null) recipeInfo.setRecipe_img4(recipeInfo.getRecipe_img4().substring(start,recipeInfo.getRecipe_img4().length()));
		if(recipeInfo.getRecipe_img5()!=null) recipeInfo.setRecipe_img5(recipeInfo.getRecipe_img5().substring(start,recipeInfo.getRecipe_img5().length()));
		if(recipeInfo.getRecipe_img6()!=null) recipeInfo.setRecipe_img6(recipeInfo.getRecipe_img6().substring(start,recipeInfo.getRecipe_img6().length()));
		if(recipeInfo.getRecipe_img7()!=null) recipeInfo.setRecipe_img7(recipeInfo.getRecipe_img7().substring(start,recipeInfo.getRecipe_img7().length()));
		if(recipeInfo.getRecipe_img8()!=null) recipeInfo.setRecipe_img8(recipeInfo.getRecipe_img8().substring(start,recipeInfo.getRecipe_img8().length()));
		if(recipeInfo.getRecipe_img9()!=null) recipeInfo.setRecipe_img9(recipeInfo.getRecipe_img9().substring(start,recipeInfo.getRecipe_img9().length()));
		if(recipeInfo.getRecipe_img10()!=null) recipeInfo.setRecipe_img10(recipeInfo.getRecipe_img10().substring(start,recipeInfo.getRecipe_img10().length()));
		return recipeInfo;
	}

	
	////맵핑메서드////////////////////////////////////////////////////////////////////////
	//레시피 업로드 페이지 시작
	@RequestMapping(value="/mobile_Post/m_upload_start.html", method=RequestMethod.GET)
	public ModelAndView m_create_model(){
		//log
		System.out.println("RecipeInfo 객체 생성");
		
		//객체생성
		ModelAndView mav = new ModelAndView("mobile_home/m_postRecipe_img");
		mav.addObject(new RecipeInfo());
		return mav;
	}
	
	//레시피 업로드 이미지 정렬 페이지
	@RequestMapping(value="/mobile_Post/m_upload_img.html", method=RequestMethod.POST)
	public ModelAndView m_sort_img(RecipeInfo recipeInfo, BindingResult br, HttpServletRequest request, HttpSession session){
		//log
		System.out.println("파일업로드 메서드 통과");
		

		//처음파일 NULL 처리
		ModelAndView findFirstNullFileResult = findFirstNullFile(recipeInfo,br);
		if(findFirstNullFileResult!=null) return findFirstNullFileResult;
		
		//그림파일 아닌 경우 처리
		ModelAndView findNotImgFileResult = findNotImgFile(recipeInfo,br);
		if(findNotImgFileResult!=null) return findNotImgFileResult;
		
		//5MB이상 파일인 경우 처리
		ModelAndView findImgMoreThanMaxSizeResult = findImgMoreThanMaxSize(recipeInfo,br);
		if(findImgMoreThanMaxSizeResult!=null) return findImgMoreThanMaxSizeResult;
		
		//세션 가져오기
		String user_nick = (String)session.getAttribute("user_nick");
			
		//리스트 가져오기
		List<MultipartFile> img_list = recipeInfo.getImg_food();
		System.out.println("리스트 사이즈 : "+img_list.size());
		Iterator it = img_list.iterator();
		OutputStream out = null;
		String[] fileNames = new String[getSizeIfImgsHaveNull(recipeInfo)];
		int cnt = 0;

		//서버에 파일 저장
		while(it.hasNext()){
			MultipartFile imgs = (MultipartFile)it.next();
			String fileName = imgs.getOriginalFilename();
			
			System.out.println("처음파일 이름 : "+fileName);
			
			if(!fileName.equals("")){//중간,마지막파일 NULL 처리
				//파일이름 재생성
				DateTime dt = new DateTime();
				DateTimeFormatter fmt = DateTimeFormat.forPattern("yyMMddHHmmss");
				String upload_time = fmt.print(dt);	
				fileName = upload_time +"_"+user_nick+"_"+fileName;
								
				//파일 저장
				String path = request.getSession().getServletContext().getRealPath("/upload/"+fileName);
					
				fileNames[cnt] = fileName;
				cnt++;
				System.out.println("경로 : "+path);
				File file = new File(path);	
				try{
					out = new FileOutputStream(path);
					BufferedInputStream bis = new BufferedInputStream(imgs.getInputStream());
					byte[] buffer = new byte[8106];
					int read = 0;
					while((read=bis.read(buffer))>0){//읽은 내용 無 : -1
						out.write(buffer, 0, read);
					}//파일로 출력
					if(out != null) out.close();
				}catch(Exception e){
					e.printStackTrace();
				}
			}
		}
		
		//페이지전환
		ModelAndView mav = new ModelAndView("mobile_home/m_postRecipe_sort");
		mav.addObject(recipeInfo);
		mav.addObject("IMG_NAME",fileNames);
		return mav;
	}
	
	//레시피 업로드 내용
	@RequestMapping(value="/mobile_Post/m_upload_content.html", method=RequestMethod.POST)
	public ModelAndView m_upload_content(RecipeInfo recipeInfo, BindingResult br, HttpSession session){
		//log
		System.out.println("레시피 업로드 내용 통과");		
				
		//이미지 배열에 저장
		String[] fileName = new String[recipeInfo.getRecipe_img_order()];
		fileName = saveImgToArray(recipeInfo,"page");
		
		//화면전환
		ModelAndView mav = new ModelAndView("mobile_home/m_postRecipe_content");
		mav.addObject("IMGS", fileName);
		mav.addObject(recipeInfo);
		return mav;
	}
	
	//레시피 업로드
	@RequestMapping(value="/mobile_Post/m_upload_all.html", method=RequestMethod.POST)
	public ModelAndView upload_all(RecipeInfo recipeInfo, BindingResult br, HttpSession session){
		//log
		System.out.println("레시피 업로드 메서드 통과");		
		
		
		//정보가져오기
		String recipe_content = recipeInfo.getRecipe_content().trim();
		String recipe_hashtag = recipeInfo.getRecipe_hashtag().trim();
		Integer recipe_img_order = recipeInfo.getRecipe_img_order();
		
		//세션가져오기
		String user_nick = (String)session.getAttribute("user_nick");
		
		
		
		//해쉬태그, 레시피 내용 에러처리
		ModelAndView find = findRecipeContentAndHashtagIsNull(recipeInfo, br, "upload");
		if(find!=null) return find;
	
		//Textarea 한칸 띄우기 처리
	    //recipe_content = recipe_content.replace("\r\n", "<br/>");

		//recipe_hastag 정렬(해쉬태그 문자열 처리)
		String temp_hashtag = recipe_hashtag.replace("#", " ");
		boolean firstWordIsNotHashtag = false;
		char[] fix = temp_hashtag.toCharArray();
		if(fix[0] != ' ')  firstWordIsNotHashtag = true; //첫문자 '#'인지 여부		
		for(int i=0;i<fix.length;i++){
			if(i!=0 && fix[i]!=' ' && fix[i-1]==' '){//단어의 시작인 경우
				fix[i-1] = '#';
			}
		}
		if(firstWordIsNotHashtag){//첫문자가 '#' 아닌 경우
			temp_hashtag = "#"+String.valueOf(fix).trim();
		}else{//첫문자가 '#' 인 경우
			temp_hashtag = String.valueOf(fix).trim();
		}
		recipe_hashtag = temp_hashtag;
			
				
		//Recipe_id 생성
		List<String> allRecipeIdByNick = checkCatalog.checkRecipeIdCount(user_nick);
		String recipe_id="";
		if(allRecipeIdByNick.size() == 0){
			System.out.println("recipeId NULL");
			recipe_id = user_nick+"_"+"1";
		}else{	
			System.out.println("recipeId NOT NULL");	
			Integer myCount[] = new Integer[allRecipeIdByNick.size()];
			Iterator it = allRecipeIdByNick.iterator();
			int cnt = 0;
	 		while(it.hasNext()){
				UploadUtil uu = (UploadUtil)it.next();
				String id = uu.getSelect_recipe_id();
				myCount[cnt] = Integer.valueOf(id.substring(id.indexOf("_")+1, id.length()));
				cnt++;			
			}
	 		
	 		Arrays.sort(myCount);
	 		Integer myMaxCount = myCount[myCount.length-1];		
			recipe_id = user_nick+"_"+(myMaxCount+1);
			}		
		
		//Recipe_count 생성
		Integer recipe_count = checkCatalog.checkRecipeCountMax();
		if(recipe_count == null) recipe_count = 1;
		else recipe_count++;
		
		//Recipe_posttime 생성
		DateTime dt = new DateTime();
		DateTimeFormatter fmt = DateTimeFormat.forPattern("yyMMddHHmmss");
		String recipe_posttime = fmt.print(dt);	
		
	
		//log
		System.out.println("recipe_id : "+recipe_id);
		System.out.println("Recipe_posttime : " +recipe_posttime);
		System.out.println("recipe_count : " + recipe_count);
		System.out.println("recipe_content : "+recipe_content);
		System.out.println("recipe_hashtag : "+recipe_hashtag);
		System.out.println("recipe_img_order : "+recipe_img_order);
		System.out.println("recipe_img1 : "+recipeInfo.getRecipe_img1());
		
		//VO 저장(이미지는 이전 페이지에서 저장함)
		recipeInfo.setRecipe_id(recipe_id);
		recipeInfo.setRecipe_count(recipe_count);
		recipeInfo.setRecipe_content(recipe_content);
		recipeInfo.setRecipe_hashtag(recipe_hashtag);
		recipeInfo.setRecipe_posttime(recipe_posttime);
		recipeInfo.setUser_nick(user_nick);
		recipeInfo.setRecipe_img_order(recipe_img_order);
		
		//이미지 VO저장
		recipeInfo = saveImgInValueObject(recipeInfo);
			
		
		//업로드 DB연동
		this.insertCatalog.postRecipe(recipeInfo);
		
		//하트 생성 + DB연동
		HeartUtil util = new HeartUtil();
		util.setHeart(0);
		util.setRecipe_id(recipe_id);
		this.insertCatalog.postHeart(util);
		
		//컨트롤러 이동(레시피 목록)
		return new ModelAndView("redirect:/mobile_List/recipe_list.html");
	}
	
	
	//레시피 이미지 수정 메서드
	@RequestMapping(value="/mobile_Post/m_modify_img.html", method=RequestMethod.GET)
	public ModelAndView modify_content(String recipe_id, String TOTAL, HttpSession session){
		//DB연동
		RecipeInfo recipeInfo = this.checkCatalog.getRecipeTobeModify(recipe_id);
			
		//이미지 배열에 저장
		String fileNames[] = this.saveImgToArray(recipeInfo,"modify");
		
		//log
		System.out.println("수정할 recipe_id : "+recipeInfo.getRecipe_id());
		System.out.println("수정할 img1 : " +fileNames[0]);
		System.out.println("수정할 recipe_hashtag: "+recipeInfo.getRecipe_hashtag());
		System.out.println("수정할 TOTAL :"+TOTAL);
		
		//화면전환
		ModelAndView mav = new ModelAndView("mobile_home/m_modifyRecipe_sort");
		mav.addObject(recipeInfo); //기존내용 객체
		mav.addObject("IMG_NAME",fileNames); // 이미지파일용
		mav.addObject("TOTAL",TOTAL); // 토탈 vs 상세
		return mav;
	}
	
	//레시피 내용 수정 메서드
	@RequestMapping(value="/mobile_Post/m_modify_content.html", method=RequestMethod.POST)
	public ModelAndView m_modify_content(RecipeInfo recipeInfo, String TOTAL, HttpSession session){
		//log
		System.out.println("레시피 업로드 내용 통과");		
		
		//log
		System.out.println("레시피 이미지 길이 : " +recipeInfo.getRecipe_img_order());
		System.out.println("이미지 1 : "+recipeInfo.getRecipe_img1());
		System.out.println("수정할 내용 :"+recipeInfo.getRecipe_content());
		System.out.println("수정할 해쉬태그 : "+recipeInfo.getRecipe_hashtag());
		System.out.println("토탈 or 상세 : "+TOTAL);
		
		//이미지 배열에 저장
		String[] fileName = new String[recipeInfo.getRecipe_img_order()];
		fileName = saveImgToArray(recipeInfo,"modify");
		
		//화면전환
		ModelAndView mav = new ModelAndView("mobile_home/m_modifyRecipe_content");
		mav.addObject("IMGS", fileName); //이미지 배열
		mav.addObject("TOTAL", TOTAL); //토탈 or 상세
		mav.addObject(recipeInfo);
		return mav;
	}
	
	
	//레시피 수정 업로드 메서드
	@RequestMapping(value="/mobile_Post/m_modify_upload.html",method=RequestMethod.POST)
	public ModelAndView modify_upload(RecipeInfo recipeInfo, BindingResult br, String TOTALS, HttpSession session){
		//log
		System.out.println("토탈 or 상세? : "+TOTALS);
		System.out.println("레시피 아디 : "+recipeInfo.getRecipe_id());
		System.out.println("수정된 내용 : "+recipeInfo.getRecipe_content());
		System.out.println("수정된 해쉬태그 :"+recipeInfo.getRecipe_hashtag());
		System.out.println("수정된 이미지 내용 : "+recipeInfo.getRecipe_img1());
		System.out.println("레시피 이미지 순서 : "+recipeInfo.getRecipe_img_order());
		
		
		//해쉬태그, 레시피 내용 에러처리
		ModelAndView find = findRecipeContentAndHashtagIsNull(recipeInfo, br, "modify");
		if(find!=null){
			//이미지 배열에 저장
			String[] fileName = new String[recipeInfo.getRecipe_img_order()];
			fileName = saveImgToArray(recipeInfo,"modify");
			find.addObject("TOTAL",TOTALS); //목록 vs 상세
			find.addObject("IMGS", fileName); //이미지 배열
			return find;
		}
		
		//DB연동
		int update_result = this.updateCatalog.updateRecipeInfo(this.saveImgInValueObject(recipeInfo));
		if(update_result>0)System.out.println("레시피 업데이트 성공");
			
		//리스트로 화면 전환
		if(TOTALS.equals("YES")) return new ModelAndView("redirect:/mobile_List/recipe_list.html");	
		else return new ModelAndView("redirect:/mobile_List/recipe_selected.html?id="+recipeInfo.getRecipe_id());
	}

	
	
	//레시피 삭제 매서드(목록/상세)
	@RequestMapping(value="/mobile_Post/m_delete_recipe.html",method=RequestMethod.GET)
	public ModelAndView deleteRecipe(String recipe_id){
		//log
		System.out.println("레시피 삭제(토탈) 메서드");
		System.out.println("삭제레시피아이디 : "+recipe_id);
		
		//DB연동
		int delete_result = this.deleteCatalog.deleteRcipe(recipe_id);
		if(delete_result>0) System.out.println("레시피 삭제 성공");
		
		//리스트로 화면전환
		return new ModelAndView("redirect:/mobile_List/recipe_list.html");
	}	

}
