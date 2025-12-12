package db;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductFacade {

    private Product mapResultSetToProduct(ResultSet rs) throws SQLException{
        Product product = new Product();
        product.setId(rs.getInt("id"));
        product.setName(rs.getString("name"));
        product.setCategory(rs.getString("category"));
        product.setArtist(rs.getString("artist"));
        product.setPrice(rs.getDouble("price"));
        product.setStockStatus(rs.getString("stock_status"));
        product.setImageUrl(rs.getString("image_url"));
        product.setUploadDate(rs.getTimestamp("upload_date"));
        return product;
    }

    public List<Product> readAll() throws SQLException {
        List<Product> list = new ArrayList<>();
        Connection con = DBContext.getConnection();
        // PostgreSQL uses LIMIT and OFFSET
        PreparedStatement stm = con.prepareStatement(
            "SELECT * FROM product ORDER BY id");
        ResultSet rs = stm.executeQuery();
        while (rs.next()) {
            list.add(mapResultSetToProduct(rs));
        }
        con.close();
        return list;
    }

    public void create(Product product) throws SQLException {
        Connection con = DBContext.getConnection();
        PreparedStatement stm = con.prepareStatement(
            "INSERT INTO product (id, name, category, artist, price, stock_status, image_url, upload_date) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
        stm.setInt(1, product.getId());
        stm.setString(2, product.getName());
        stm.setString(3, product.getCategory());
        stm.setString(4, product.getArtist());
        stm.setDouble(5, product.getPrice());
        stm.setString(6, product.getStockStatus());
        stm.setString(7, product.getImageUrl());
        stm.setTimestamp(8, product.getUploadDate());
        stm.executeUpdate();
        con.close();
    }

    public void delete(int id) throws SQLException {
        //Tạo connection để kết nối vào db
        Connection con = DBContext.getConnection();
        //Tạo đối tượng PrepareStatement dể thực hiện lệnh sql có tham số
        PreparedStatement stm = con.prepareStatement("DELETE FROM product WHERE id = ?");
        stm.setInt(1, id);
        //thực hiện lệnh sql
        int count = stm.executeUpdate();
        //Đóng kết nối từ ứng dụng vào db để giải phóng tải nguyên
        con.close();
    }

    public void update(Product product) throws SQLException {
        //Tạo connection để kết nối vào db
        Connection con = DBContext.getConnection();
        PreparedStatement stm = con.prepareStatement("UPDATE product SET name = ?, category = ?, artist = ?, price = ?, stock_status = ?, image_url = ?, upload_date = ? WHERE id = ?");
        stm.setString(1, product.getName());
        stm.setString(2, product.getCategory());
        stm.setString(3, product.getArtist());
        stm.setDouble(4, product.getPrice());
        stm.setString(5, product.getStockStatus());
        stm.setString(6, product.getImageUrl());
        stm.setTimestamp(7, product.getUploadDate());
        stm.setInt(8, product.getId());
        //thực hiện lệnh sql
        int count = stm.executeUpdate();
        //Đóng kết nối từ ứng dụng vào db để giải phóng tải nguyên
        con.close();
    }

    public Product getProduct(int id) throws SQLException {
        Connection con = DBContext.getConnection();
        PreparedStatement stm = con.prepareStatement("SELECT * FROM product WHERE id = ?");
        stm.setInt(1, id);
        ResultSet rs = stm.executeQuery();
        Product product = null;
        if (rs.next()) {
            product = mapResultSetToProduct(rs);
        }
        con.close();
        return product;
    }
    
    public List<Product> getProductByName(String name) throws SQLException {
        Connection con = DBContext.getConnection();
        PreparedStatement stm = con.prepareStatement("SELECT * FROM product WHERE LOWER(name) LIKE LOWER(?) ORDER BY id");
        stm.setString(1, "%" + name + "%");
        ResultSet rs = stm.executeQuery();
        List<Product> products = new ArrayList<>();
        while (rs.next()) {
            products.add(mapResultSetToProduct(rs));
        }
        con.close();
        return products;
    }
}
