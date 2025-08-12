package com.pageturners.util;

import com.pageturners.model.User;
import com.pageturners.model.Order;
import com.pageturners.model.Book;
import com.pageturners.model.CartItem;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Arrays;

/**
 * Utility class for testing email functionality
 */
public class EmailTester {
    
    public static void main(String[] args) {
        System.out.println("Testing PageTurners Email Service...");
        System.out.println("====================================");
        
        try {
            // Create test user
            User testUser = createTestUser();
            
            // Create test order
            Order testOrder = createTestOrder();
            
            // Test email service
            EmailService emailService = new EmailService();
            System.out.println("Attempting to send test email to: " + testUser.getEmail());
            
            boolean emailSent = emailService.sendOrderConfirmationEmail(testUser, testOrder);
            
            if (emailSent) {
                System.out.println("✅ Email sent successfully!");
                System.out.println("Check the recipient's inbox for the order confirmation email.");
            } else {
                System.out.println("❌ Email failed to send. Check the console for error details.");
            }
            
        } catch (Exception e) {
            System.err.println("❌ Error during email test: " + e.getMessage());
            e.printStackTrace();
            
            // Check common issues
            System.out.println("\nTroubleshooting checklist:");
            System.out.println("1. Verify AZURE_COMMUNICATION_CONNECTION_STRING environment variable is set");
            System.out.println("2. Verify AZURE_COMMUNICATION_SENDER_EMAIL environment variable is set");
            System.out.println("3. Ensure Azure Communication Services resource is properly configured");
            System.out.println("4. Check that the sender email matches your Azure domain configuration");
        }
    }
    
    private static User createTestUser() {
        User user = new User();
        user.setUserId(1);
        user.setFirstName("Test");
        user.setLastName("User");
        user.setEmail("cyruswang2017@gmail.com"); // Change this to your actual email
        user.setUsername("testuser");
        return user;
    }
    
    private static Order createTestOrder() {
        Order order = new Order();
        order.setOrderId(12345);
        order.setUserId(1);
        order.setOrderDate(LocalDateTime.now());
        order.setStatus("Confirmed");
        order.setTotalAmount(new BigDecimal("29.97"));
        order.setShippingAddress("123 Test Street");
        order.setShippingCity("Test City");
        order.setShippingState("TS");
        order.setShippingZip("12345");
        
        // Create test books and cart items
        Book book1 = new Book();
        book1.setBookId(1);
        book1.setTitle("The Great Gatsby");
        book1.setAuthor("F. Scott Fitzgerald");
        book1.setPrice(new BigDecimal("12.99"));
        book1.setStockQuantity(10);
        
        Book book2 = new Book();
        book2.setBookId(2);
        book2.setTitle("To Kill a Mockingbird");
        book2.setAuthor("Harper Lee");
        book2.setPrice(new BigDecimal("16.98"));
        book2.setStockQuantity(5);
        
        CartItem item1 = new CartItem();
        item1.setBook(book1);
        item1.setQuantity(1);
        
        CartItem item2 = new CartItem();
        item2.setBook(book2);
        item2.setQuantity(1);
        
        order.setOrderItems(Arrays.asList(item1, item2));
        
        return order;
    }
}