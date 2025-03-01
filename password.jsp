<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Forgot Password</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: url('forget.jpg') no-repeat center center/cover;
            background-size: cover;
            background-position: center;
        }
        .form-container {
            background: #d5d8dc;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 400px;
            height:260px;
            text-align: center;
        }
        .form-group {
            margin-bottom: 15px;
            text-align: left;
        }
        label {
            display: block;
            font-weight: bold;
        }
        input {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        button {
            width: 100%;
            padding: 10px;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background: #0056b3;
        }
        .message {
            margin-top: 10px;
            font-size: 14px;
        }
        .success {
            color: green;
        }
        .error {
            color: red;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Reset Password</h2>
        <form method="post">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="newpassword">New Password:</label>
                <input type="password" id="newpassword" name="newpassword" required>
            </div>
            <button type="submit">Reset Password</button>
        </form>

        <%
        String username = request.getParameter("username");
        String newPassword = request.getParameter("newpassword");

        if (username != null && newPassword != null) {
            Connection con = null;
            PreparedStatement ps = null;

            try {
                String url = "jdbc:mysql://localhost:3306/RegistrationForm";
                String dbUser = "root";
                String dbPass = "mysql12345";

                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(url, dbUser, dbPass);

                // Check if user exists
                String checkUserQuery = "SELECT * FROM details WHERE username=?";
                ps = con.prepareStatement(checkUserQuery);
                ps.setString(1, username);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    // Update password
                    String updateQuery = "UPDATE details SET password=? WHERE username=?";
                    ps = con.prepareStatement(updateQuery);
                    ps.setString(1, newPassword);
                    ps.setString(2, username);
                    int updated = ps.executeUpdate();

                    if (updated > 0) {
                        out.print("<p class='message success'>Password updated successfully!</p>");
                        out.print("<script>setTimeout(function(){ window.location.href='LoginForm.jsp'; }, 3000);</script>");
                    
                    } else {
                        out.print("<p class='message error'>Failed to update password.</p>");
                    }
                } else {
                    out.print("<p class='message error'>Username not found.</p>");
                }
            } catch (Exception e) {
                out.print("<p class='message error'>Error: " + e.getMessage() + "</p>");
            } finally {
                try {
                    if (ps != null) ps.close();
                    if (con != null) con.close();
                } catch (SQLException se) {
                    out.print("<p class='message error'>Error closing resources: " + se.getMessage() + "</p>");
                }
            }
        }
        %>
    </div>
</body>
</html>
