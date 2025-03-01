import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.sql.*;
import java.lang.*;

@WebServlet("/TestCon")
public class TestCon extends HttpServlet
{
private static final long serialVersionUID=1L;
protected void doGet(HttpServletRequest req,HttpServletResponse res) throws IOException, ServletException
{
res.setContentType("text/html");
PrintWriter pw=res.getWriter();
String connectionURL="jdbc:mysql://localhost/demobase"; 
try
{
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con=DriverManager.getConnection(connectionURL,"root","omSAI6281#");
pw.println("connection success");
}
catch(Exception ex)
{
pw.println(ex);
}}}