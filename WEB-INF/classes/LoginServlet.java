import java.io.*;
import java.lang.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class LoginServlet extends HttpServlet
{
public void doGet(HttpServletRequest req,HttpServletResponse res) throws IOException, ServletException
{
res.setContentType("text/html");
PrintWriter pw=res.getWriter();
String name=req.getParameter("Username");
String password=req.getParameter("Password");
pw.println("<html>");
pw.println("<body>");
pw.println("Thanks Miss:" +  "+name+" + "for visiting" + "<br>");
pw.println("Now you can see your password." + "+password+" + "<br>");
pw.println("</body></html>");
}
}