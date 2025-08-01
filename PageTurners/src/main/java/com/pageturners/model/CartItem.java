package com.pageturners.model;

import java.math.BigDecimal;

public class CartItem {
    private Book book;
    private int quantity;
    
    public CartItem() {}
    
    public CartItem(Book book, int quantity) {
        this.book = book;
        this.quantity = quantity;
    }
    
    public Book getBook() { return book; }
    public void setBook(Book book) { this.book = book; }
    
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    
    public BigDecimal getSubtotal() {
        if (book != null && book.getPrice() != null) {
            return book.getPrice().multiply(new BigDecimal(quantity));
        }
        return BigDecimal.ZERO;
    }
}