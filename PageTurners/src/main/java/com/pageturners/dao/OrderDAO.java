package com.pageturners.dao;

import com.pageturners.model.Order;
import com.pageturners.model.CartItem;
import com.pageturners.model.Book;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
    private Connection getConnection() throws SQLException {
        Connection conn = DriverManager.getConnection("jdbc:h2:~/pageturners", "sa", "");
        createTablesIfNotExist(conn);
        return conn;
    }

    private void createTablesIfNotExist(Connection conn) throws SQLException {
        // Create orders table if it doesn't exist
        String createOrdersTable = """
            CREATE TABLE IF NOT EXISTS orders (
                order_id INT AUTO_INCREMENT PRIMARY KEY,
                user_id INT NOT NULL,
                order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                total_amount DECIMAL(10, 2) NOT NULL,
                status VARCHAR(50) DEFAULT 'PENDING',
                shipping_address VARCHAR(255) NOT NULL,
                shipping_city VARCHAR(100) NOT NULL,
                shipping_state VARCHAR(50) NOT NULL,
                shipping_zip VARCHAR(20) NOT NULL
            )
            """;
        
        // Create order_items table if it doesn't exist
        String createOrderItemsTable = """
            CREATE TABLE IF NOT EXISTS order_items (
                order_item_id INT AUTO_INCREMENT PRIMARY KEY,
                order_id INT NOT NULL,
                book_id INT NOT NULL,
                quantity INT NOT NULL,
                price DECIMAL(10, 2) NOT NULL,
                FOREIGN KEY (order_id) REFERENCES orders(order_id)
            )
            """;
        
        try (Statement stmt = conn.createStatement()) {
            stmt.execute(createOrdersTable);
            stmt.execute(createOrderItemsTable);
        }
    }

    public int saveOrder(Order order) throws SQLException {
        String sql = "INSERT INTO orders (user_id, order_date, total_amount, status, shipping_address, shipping_city, shipping_state, shipping_zip) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        int generatedOrderId = 0;
        
        try (Connection conn = getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, order.getUserId());
            ps.setTimestamp(2, Timestamp.valueOf(order.getOrderDate()));
            ps.setBigDecimal(3, order.getTotalAmount());
            ps.setString(4, order.getStatus());
            ps.setString(5, order.getShippingAddress());
            ps.setString(6, order.getShippingCity());
            ps.setString(7, order.getShippingState());
            ps.setString(8, order.getShippingZip());
            ps.executeUpdate();
            
            // Get the generated order ID
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    generatedOrderId = rs.getInt(1);
                    order.setOrderId(generatedOrderId);
                }
            }
        }
        
        // Save order items
        String itemSql = "INSERT INTO order_items (order_id, book_id, quantity, price) VALUES (?, ?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(itemSql)) {
            for (CartItem item : order.getOrderItems()) {
                ps.setInt(1, generatedOrderId);
                ps.setInt(2, item.getBook().getBookId());
                ps.setInt(3, item.getQuantity());
                ps.setBigDecimal(4, item.getBook().getPrice());
                ps.addBatch();
            }
            ps.executeBatch();
        }
        
        return generatedOrderId;
    }

    public List<Order> getOrdersByUserId(int userId) throws SQLException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setOrderId(rs.getInt("order_id"));
                    order.setUserId(rs.getInt("user_id"));
                    order.setOrderDate(rs.getTimestamp("order_date").toLocalDateTime());
                    order.setTotalAmount(rs.getBigDecimal("total_amount"));
                    order.setStatus(rs.getString("status"));
                    order.setShippingAddress(rs.getString("shipping_address"));
                    order.setShippingCity(rs.getString("shipping_city"));
                    order.setShippingState(rs.getString("shipping_state"));
                    order.setShippingZip(rs.getString("shipping_zip"));
                    order.setOrderItems(getOrderItems(order.getOrderId()));
                    orders.add(order);
                }
            }
        }
        return orders;
    }

    private List<CartItem> getOrderItems(int orderId) throws SQLException {
        List<CartItem> items = new ArrayList<>();
        String sql = "SELECT * FROM order_items WHERE order_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CartItem item = new CartItem();
                    Book book = new Book();
                    book.setBookId(rs.getInt("book_id"));
                    book.setPrice(rs.getBigDecimal("price"));
                    item.setBook(book);
                    item.setQuantity(rs.getInt("quantity"));
                    items.add(item);
                }
            }
        }
        return items;
    }
}