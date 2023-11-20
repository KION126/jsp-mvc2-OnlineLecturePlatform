package UserService;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import CommandHandler.CommandHandler;
import User.UserDAO;

public class LoginConfirmService implements CommandHandler{

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException, SQLException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		//입력한 ID, Password 데이터 저장
		String userID = null;
		String userPassword = null;
		
		if (request.getParameter("userID") != null) {
			userID = request.getParameter("userID");
		}

		if (request.getParameter("userPassword") != null) {
			userPassword = request.getParameter("userPassword");
		}

		//입력된 데이터가 없으면 alert출력
		if (userID == null || userPassword == null) {
			PrintWriter script = response.getWriter();
			script.print("<script>");
			script.print("alert('입력이 안 된 사항이 있습니다.');");
			script.print("history.back();");
			script.print("</script>");
			script.close();
		}
		
		//ID중복 체크
		UserDAO DAO = new UserDAO();
		int result = DAO.login(userID, userPassword);
		String nextPage = null;
		
		if (result == 1) {
			nextPage = "index";
			request.setAttribute("userID", userID);
		} else if(result == 0){
			PrintWriter script = response.getWriter();
			script.print("<script>");
		    script.print("alert('비밀번호가 틀립니다.');");
		    script.print("history.back();");
		    script.print("</script>");
			script.close();
		} else if(result == -1){
			PrintWriter script = response.getWriter();
			script.print("<script>");
		    script.print("alert('존재하지 않는 아이디입니다.');");
		    script.print("history.back();");
		    script.print("</script>");
			script.close();
		} else if(result == -2){
			PrintWriter script = response.getWriter();
			script.print("<script>");
		    script.print("alert('데이터베이스 오류입니다.');");
		    script.print("history.back();");
		    script.print("</script>");
			script.close();
		}
		return nextPage;
	}
	
}
