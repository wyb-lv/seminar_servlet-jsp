package db;

import utils.Hasher;

import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AccountFacade {

    public Account login(String email, String password) throws SQLException, NoSuchAlgorithmException {
        Account account = null;
        Connection con = DBContext.getConnection();
        // Query users table - login with email and password_hash
        PreparedStatement stm = con.prepareStatement(
            "SELECT * FROM users WHERE email = ? AND password_hash = ?");
        stm.setString(1, email);
        stm.setString(2, Hasher.hash(password));
        ResultSet rs = stm.executeQuery();
        if (rs.next()) {
            account = new Account();
            account.setId(rs.getInt("id"));
            account.setUsername(rs.getString("username"));
            account.setEmail(rs.getString("email"));
            account.setPasswordHash(rs.getString("password_hash"));
        }
        con.close();
        return account;
    }

    public void register(String username, String email, String password) throws SQLException, NoSuchAlgorithmException {
        Connection con = DBContext.getConnection();
        PreparedStatement stm = con.prepareStatement(
            "INSERT INTO users (username, email, password_hash) VALUES (?, ?, ?)");
        stm.setString(1, username);
        stm.setString(2, email);
        stm.setString(3, Hasher.hash(password));
        stm.executeUpdate();
        con.close();
    }
}
