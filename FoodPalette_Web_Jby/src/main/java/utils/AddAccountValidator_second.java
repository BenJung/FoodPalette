package utils;

import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import logic.UserInfo;

@Service
public class AddAccountValidator_second implements Validator{

	public boolean supports(Class<?> arg0) {
		return User.class.isAssignableFrom(arg0);
	}
	
	public void validate(Object arg0, Errors arg1) {
		//회원가입 2번째페이지 질문과답변이 비어있을경우 띄워줄 오류문
		UserInfo user = (UserInfo)arg0;
		if(!StringUtils.hasLength(user.getUser_question())){
			arg1.rejectValue("user_question", "error.required");
		}
		if(!StringUtils.hasLength(user.getUser_answer())){
			arg1.rejectValue("user_answer", "error.required");
		}
	}
}
