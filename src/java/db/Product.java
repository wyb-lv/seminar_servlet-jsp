package db;

import java.sql.Timestamp;

public class Product {
    private int id;
    private String name;
    private String category;
    private String artist;
    private double price;
    private String stockStatus;
    private String imageUrl;
    private Timestamp uploadDate;

    public Product() {}

    public Product(int id, String name, String category, String artist, double price,
                   String stockStatus, String imageUrl, Timestamp uploadDate) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.artist = artist;
        this.price = price;
        this.stockStatus = stockStatus;
        this.imageUrl = imageUrl;
        this.uploadDate = uploadDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getArtist() {
        return artist;
    }

    public void setArtist(String artist) {
        this.artist = artist;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getStockStatus() {
        return stockStatus;
    }

    public void setStockStatus(String stockStatus) {
        this.stockStatus = stockStatus;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public Timestamp getUploadDate() {
        return uploadDate;
    }

    public void setUploadDate(Timestamp uploadDate) {
        this.uploadDate = uploadDate;
    }

    // For backward compatibility - no discount in new schema
    public double getDiscount() {
        return 0;
    }

    public double getNewPrice() {
        return this.price;
    }
}
