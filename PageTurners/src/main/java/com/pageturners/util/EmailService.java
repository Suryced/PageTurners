package com.pageturners.util;

import com.azure.communication.email.EmailClient;
import com.azure.communication.email.EmailClientBuilder;
import com.azure.communication.email.models.EmailAddress;
import com.azure.communication.email.models.EmailMessage;
import com.azure.communication.email.models.EmailSendResult;
import com.azure.communication.email.models.EmailSendStatus;
import com.pageturners.model.Order;
import com.pageturners.model.User;
import com.pageturners.model.CartItem;

import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;

public class EmailService {
    private final EmailClient emailClient;
    private final String fromEmailAddress;
    private final boolean emailEnabled;
    
    // Configuration loaded from multiple sources with fallback hierarchy
    private static final String CONNECTION_STRING;
    private static final String SENDER_EMAIL;
    private static final boolean EMAIL_ENABLED;
    
    static {
        Properties props = new Properties();
        
        // Load from email.properties file first
        try (InputStream input = EmailService.class.getClassLoader().getResourceAsStream("email.properties")) {
            if (input != null) {
                props.load(input);
                System.out.println("Loaded email configuration from email.properties");
            }
        } catch (IOException e) {
            System.err.println("Warning: Could not load email.properties: " + e.getMessage());
        }
        
        // Configuration hierarchy: System Properties > Environment Variables > Properties File
        CONNECTION_STRING = System.getProperty("azure.communication.connectionstring", 
            System.getenv("AZURE_COMMUNICATION_CONNECTION_STRING") != null ? 
                System.getenv("AZURE_COMMUNICATION_CONNECTION_STRING") : 
                props.getProperty("azure.communication.connectionstring"));
                
        SENDER_EMAIL = System.getProperty("azure.communication.sender.email",
            System.getenv("AZURE_COMMUNICATION_SENDER_EMAIL") != null ?
                System.getenv("AZURE_COMMUNICATION_SENDER_EMAIL") :
                props.getProperty("azure.communication.sender.email"));
                
        EMAIL_ENABLED = Boolean.parseBoolean(System.getProperty("azure.email.enabled",
            System.getenv("AZURE_EMAIL_ENABLED") != null ?
                System.getenv("AZURE_EMAIL_ENABLED") :
                props.getProperty("azure.email.enabled", "true")));
    }
    
    public EmailService() {
        this.emailEnabled = EMAIL_ENABLED;
        
        if (!emailEnabled) {
            System.out.println("Email service is disabled via configuration");
            this.emailClient = null;
            this.fromEmailAddress = null;
            return;
        }
        
        if (CONNECTION_STRING == null || CONNECTION_STRING.isEmpty() || 
            CONNECTION_STRING.contains("your-resource.communication.azure.com")) {
            throw new IllegalStateException(
                "Azure Communication Services connection string is not configured properly. " +
                "Please update email.properties, set environment variables, or system properties.");
        }
        if (SENDER_EMAIL == null || SENDER_EMAIL.isEmpty() || 
            SENDER_EMAIL.contains("yourdomain.azurecomm.net")) {
            throw new IllegalStateException(
                "Sender email address is not configured properly. " +
                "Please update email.properties, set environment variables, or system properties.");
        }
        
        this.emailClient = new EmailClientBuilder()
            .connectionString(CONNECTION_STRING)
            .buildClient();
        this.fromEmailAddress = SENDER_EMAIL;
        
        System.out.println("Email service initialized successfully with sender: " + SENDER_EMAIL);
    }
    
    /**
     * Send order confirmation email to customer
     */
    public boolean sendOrderConfirmationEmail(User user, Order order) {
        if (!emailEnabled) {
            System.out.println("Email service is disabled - skipping email send");
            return true; // Return true so order processing continues
        }
        
        try {
            String subject = "Order Confirmation - PageTurners #" + order.getOrderId();
            String htmlContent = generateOrderConfirmationHtml(user, order);
            String plainTextContent = generateOrderConfirmationText(user, order);
            
            return sendEmail(user.getEmail(), subject, htmlContent, plainTextContent);
        } catch (Exception e) {
            System.err.println("Failed to send order confirmation email: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Send email using Azure Communication Services
     */
    private boolean sendEmail(String toEmail, String subject, String htmlContent, String plainTextContent) {
        try {
            EmailMessage emailMessage = new EmailMessage()
                .setSenderAddress(fromEmailAddress)
                .setToRecipients(Arrays.asList(new EmailAddress(toEmail)))
                .setSubject(subject)
                .setBodyPlainText(plainTextContent)
                .setBodyHtml(htmlContent);
            
            EmailSendResult result = emailClient.beginSend(emailMessage).getFinalResult();
            
            if (result.getStatus() == EmailSendStatus.SUCCEEDED) {
                System.out.println("Email sent successfully to: " + toEmail);
                return true;
            } else {
                System.err.println("Failed to send email. Status: " + result.getStatus());
                return false;
            }
        } catch (Exception e) {
            System.err.println("Error sending email: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Generate HTML content for order confirmation email
     */
    private String generateOrderConfirmationHtml(User user, Order order) {
        StringBuilder html = new StringBuilder();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMMM dd, yyyy 'at' HH:mm");
        
        html.append("<!DOCTYPE html>");
        html.append("<html><head>");
        html.append("<meta charset='UTF-8'>");
        html.append("<style>");
        html.append("body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }");
        html.append(".container { max-width: 600px; margin: 0 auto; padding: 20px; }");
        html.append(".header { background-color: #2c3e50; color: white; padding: 20px; text-align: center; }");
        html.append(".content { padding: 20px; background-color: #f9f9f9; }");
        html.append(".order-details { background-color: white; padding: 15px; margin: 15px 0; border-radius: 5px; }");
        html.append(".item { border-bottom: 1px solid #eee; padding: 10px 0; }");
        html.append(".total { font-weight: bold; font-size: 18px; color: #2c3e50; }");
        html.append(".footer { text-align: center; padding: 20px; color: #666; }");
        html.append("</style>");
        html.append("</head><body>");
        
        html.append("<div class='container'>");
        html.append("<div class='header'>");
        html.append("<h1>📚 PageTurners</h1>");
        html.append("<h2>Order Confirmation</h2>");
        html.append("</div>");
        
        html.append("<div class='content'>");
        html.append("<h3>Thank you for your order, ").append(user.getFirstName()).append("!</h3>");
        html.append("<p>We've received your order and are preparing it for shipment.</p>");
        
        html.append("<div class='order-details'>");
        html.append("<h4>Order Details</h4>");
        html.append("<p><strong>Order #:</strong> ").append(order.getOrderId()).append("</p>");
        html.append("<p><strong>Order Date:</strong> ").append(order.getOrderDate().format(formatter)).append("</p>");
        html.append("<p><strong>Status:</strong> ").append(order.getStatus()).append("</p>");
        html.append("</div>");
        
        html.append("<div class='order-details'>");
        html.append("<h4>Shipping Address</h4>");
        html.append("<p>").append(order.getShippingAddress()).append("<br>");
        html.append(order.getShippingCity()).append(", ").append(order.getShippingState()).append(" ").append(order.getShippingZip());
        html.append("</p>");
        html.append("</div>");
        
        if (order.getOrderItems() != null && !order.getOrderItems().isEmpty()) {
            html.append("<div class='order-details'>");
            html.append("<h4>Items Ordered</h4>");
            
            for (CartItem item : order.getOrderItems()) {
                html.append("<div class='item'>");
                html.append("<strong>").append(item.getBook().getTitle()).append("</strong><br>");
                html.append("by ").append(item.getBook().getAuthor()).append("<br>");
                html.append("Quantity: ").append(item.getQuantity());
                html.append(" × $").append(item.getBook().getPrice());
                html.append(" = $").append(item.getBook().getPrice().multiply(BigDecimal.valueOf(item.getQuantity())));
                html.append("</div>");
            }
            
            html.append("<div class='total'>");
            html.append("Total: $").append(order.getTotalAmount());
            html.append("</div>");
            html.append("</div>");
        }
        
        html.append("<p>You can track your order status by logging into your account on our website.</p>");
        html.append("</div>");
        
        html.append("<div class='footer'>");
        html.append("<p>Thank you for choosing PageTurners!</p>");
        html.append("<p>If you have any questions, please contact us at support@pageturners.com</p>");
        html.append("</div>");
        
        html.append("</div>");
        html.append("</body></html>");
        
        return html.toString();
    }
    
    /**
     * Generate plain text content for order confirmation email
     */
    private String generateOrderConfirmationText(User user, Order order) {
        StringBuilder text = new StringBuilder();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMMM dd, yyyy 'at' HH:mm");
        
        text.append("PageTurners - Order Confirmation\n");
        text.append("================================\n\n");
        
        text.append("Thank you for your order, ").append(user.getFirstName()).append("!\n\n");
        text.append("We've received your order and are preparing it for shipment.\n\n");
        
        text.append("Order Details:\n");
        text.append("Order #: ").append(order.getOrderId()).append("\n");
        text.append("Order Date: ").append(order.getOrderDate().format(formatter)).append("\n");
        text.append("Status: ").append(order.getStatus()).append("\n\n");
        
        text.append("Shipping Address:\n");
        text.append(order.getShippingAddress()).append("\n");
        text.append(order.getShippingCity()).append(", ").append(order.getShippingState()).append(" ").append(order.getShippingZip()).append("\n\n");
        
        if (order.getOrderItems() != null && !order.getOrderItems().isEmpty()) {
            text.append("Items Ordered:\n");
            text.append("--------------\n");
            
            for (CartItem item : order.getOrderItems()) {
                text.append(item.getBook().getTitle()).append("\n");
                text.append("by ").append(item.getBook().getAuthor()).append("\n");
                text.append("Quantity: ").append(item.getQuantity());
                text.append(" × $").append(item.getBook().getPrice());
                text.append(" = $").append(item.getBook().getPrice().multiply(BigDecimal.valueOf(item.getQuantity()))).append("\n\n");
            }
            
            text.append("Total: $").append(order.getTotalAmount()).append("\n\n");
        }
        
        text.append("You can track your order status by logging into your account on our website.\n\n");
        text.append("Thank you for choosing PageTurners!\n");
        text.append("If you have any questions, please contact us at support@pageturners.com\n");
        
        return text.toString();
    }
}
