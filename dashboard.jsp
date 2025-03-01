<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: url('dash') no-repeat center center/cover;
        }
        .dashboard-container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 300px;
            backdrop-filter: blur(100px);
        }
        h2 {
            margin-bottom: 15px;
        }
        .logout-button {
            padding: 10px;
            background: #dc3545;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .logout-button:hover {
            background: #c82333;
        }
         table{
 backdrop-filter: blur(300px);
color:white;
border-color:"#a79dd0";
         }
           
       
    </style>
</head>
<body>
 <center>
        <h2>List of candidates registered</h2>
        <table border="1" cellpadding="10" cellspacing="0">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Phone</th>
                <th>Email</th>
                <th>Address</th>
                <th>Username</th>
            </tr>


            <%
            Connection connection = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                
                String connectionURL = "jdbc:mysql://localhost:3306/RegistrationForm";
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(connectionURL, "root", "mysql12345");
                stmt = connection.createStatement();

                String query = "SELECT id,name,phone,email,address,username FROM details";
                rs = stmt.executeQuery(query);

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    String phone = rs.getString("phone");
                    String email = rs.getString("email");
                    String address = rs.getString("address");
                    String username = rs.getString("username");
                    %>
                    <tr>
                        <td><%= id %></td>
                        <td><%= name %></td>
                        <td><%= phone %></td>
                        <td><%= email %></td>
                        <td><%= address %></td>
                        <td><%= username %></td>
                        
                    </tr>
                    <%
                }
            } catch (Exception e) {
                out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (connection != null) connection.close();
                } catch (SQLException se) {
                    out.println("<p style='color: red;'>Error closing resources: " + se.getMessage() + "</p>");
                }
            }
            %>
            </table><br><br><br>
    <div class="dashboard-container">
        <h2>Welcome to Your Dashboard</h2>
        <p>You are successfully logged in!</p>
        <form action="LoginForm.jsp" method="post">
            <button type="submit" class="logout-button">Logout</button>
        </form>
    </div>
</body>
</html>