<%@page import="java.sql.*"%>
<%@page import="java.security.MessageDigest"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Registration Form</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: url('abstract.jpg') no-repeat center center/cover;
        }

        .form-container {
            background: rgba(255, 255, 255, 0.2);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.2);
            width: 300px;
            backdrop-filter: blur(100px);
        }

        .form-group {
            margin-bottom: 25px;
        }

        label {
            display: block;
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 5px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        button {
            width: 100%;
            padding: 10px;
            background: #2da449;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        button:hover {
            background: #0cd237;
        }

        .error-message {
            color: red;
        }

        .success-message {
            color: green;
        }
    </style>

    <script>
        function validateForm() {
            var password = document.getElementById("password").value;
            var confirmPassword = document.getElementById("confirm_password").value;
            var errorMsg = document.getElementById("error-message");

            if (password !== confirmPassword) {
                errorMsg.innerHTML = "Passwords do not match!";
                return false;
            }
            errorMsg.innerHTML = "";
            return true;
        }
    </script>
</head>

<body>
    <div class="form-container">
        <h2>Register Here</h2>
        <form name="fm1" method="post" action="RegistrationForm.jsp" onSubmit="return validate(this)">
            <input type="hidden" value="register" name="action">

            <div class="form-group">
                <label for="name">Full Name:</label>
                <input type="text" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="phone">Phone Number:</label>
                <input type="text" id="phone" name="phone" required>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="address">Address:</label>
                <input type="text" id="address" name="address" required>
            </div>
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group">
                <label for="confirm_password">Confirm Password:</label>
                <input type="password" id="confirm_password" name="confirm_password" required>
                <p class="error-message" id="error-message"></p>
            </div>
            <button type="submit">Register</button>

            <h4>Already have an account <a href="LoginForm.jsp">Login</a></h4>
        </form>

        <%
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            String connectionURL = "jdbc:mysql://localhost:3306/RegistrationForm";
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(connectionURL, "root", "mysql12345");

            if ("register".equals(request.getParameter("action"))) {
                String name = request.getParameter("name");
                String phone = request.getParameter("phone");
                String email = request.getParameter("email");
                String address = request.getParameter("address");
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String confirmPassword = request.getParameter("confirm_password");

                if (!password.equals(confirmPassword)) {
                    out.print("<p class='error-message'>Error: Passwords do not match!</p>");
                } else {
                    // Hash the password using SHA-256
                    MessageDigest md = MessageDigest.getInstance("SHA-256");
                    md.update(password.getBytes());
                    byte[] hashedBytes = md.digest();
                    StringBuilder sb = new StringBuilder();
                    for (byte b : hashedBytes) {
                        sb.append(String.format("%02x", b));
                    }
                    String hashedPassword = sb.toString();

                    // SQL Insert Query
                    String query = "INSERT INTO details(name, phone, email, address, username, password) VALUES (?, ?, ?, ?, ?, ?)";
                    ps = con.prepareStatement(query);
                    ps.setString(1, name);
                    ps.setString(2, phone);
                    ps.setString(3, email);
                    ps.setString(4, address);
                    ps.setString(5, username);
                    ps.setString(6, password);

                    // Execute the insert
                    int result = ps.executeUpdate();

                    if (result > 0) {
                        out.print("<p> Registered successfully! </p>");
                        out.print("<script>setTimeout(function(){ window.location.href='LoginForm.jsp'; }, 3000);</script>");
                    
                       
                    } else {
                        out.print("<p> Registration failed. Try again! </p>");
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.print("<p class='error-message'>Error: " + e.getMessage() + "</p>");
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException se) {
                out.print("<p class='error-message'>Error closing resources: " + se.getMessage() + "</p>");
            }
        }
        %>

 </div>
</body>
</html>  