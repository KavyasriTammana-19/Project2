<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: url('login.jpg') no-repeat center center/cover;
        }
        .form-container {
            background: rgba(255, 255, 255, 0.2);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: center;
            backdrop-filter: blur(10px);
        }
        h2 {
            color: white;
            margin-bottom: 15px;
        }
        input {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: none;
            border-radius: 5px;
            background: rgba(255, 255, 255, 0.5);
            color: black;
        }
        button {
            width: 100%;
            padding: 10px;
            background: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background: #218838;
        }
        .links {
            margin-top: 10px;
        }
        .links a {
            color: white;
            text-decoration: underline;
            margin: 0 10px;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Welcome</h2>
        <form method="post">
            <input type="text" id="username" name="username" placeholder="Username" required>
            <input type="password" id="password" name="password" placeholder="Password" required>
            <button type="submit">Login</button>
        </form>
        <div class="links">
            <a href="password.jsp">Forget Password</a> | <a href="RegistrationForm.jsp">Register</a>
        </div>
        
        <%
        String inputUsername = request.getParameter("username");
        String inputPassword = request.getParameter("password");

        if (inputUsername != null && inputPassword != null) {
            String url = "jdbc:mysql://localhost:3306/RegistrationForm";
            String dbUsername = "root"; 
            String dbPassword = "mysql12345";
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(url, dbUsername, dbPassword);

                String query = "SELECT password FROM details WHERE username=?";
                ps = con.prepareStatement(query);
                ps.setString(1, inputUsername);
                rs = ps.executeQuery();

                if (rs.next()) {
                    String storedPassword = rs.getString("password").trim(); 
                    if (storedPassword.equals(inputPassword)) {
                        session.setAttribute("username", inputUsername);
                        response.sendRedirect("dashboard.jsp");
                    } else {
                        out.print("<p class='error-message'>Invalid username or password!</p>");
                    }
                } else {
                    out.print("<p class='error-message'>Invalid username or password!</p>");
                }
            } catch (Exception e) {
                out.print("<p class='error-message'>Error: " + e.getMessage() + "</p>");
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (ps != null) ps.close();
                    if (con != null) con.close();
                } catch (SQLException se) {
                    out.print("<p class='error-message'>Error closing resources: " + se.getMessage() + "</p>");
                }
            }
        }
        %>
    </div>
</body>
</html>









