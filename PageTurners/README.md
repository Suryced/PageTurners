# PageTurners Online Bookstore

A comprehensive web application built with JSP and Servlets demonstrating key concepts of web development including session tracking, dynamic content, input validation, and the Model-View-Controller (MVC) architecture.

## Features

### Core Functionality
- **User Registration & Authentication**: Secure user registration and login with password encryption
- **Book Browsing**: Browse books by category (Fiction, Non-Fiction, Academic, Fantasy, Science Fiction)
- **Search Functionality**: Search books by title, author, or description
- **Shopping Cart**: Session-based cart that persists as users navigate
- **Secure Checkout**: SSL-enabled checkout process with order confirmation
- **Order Management**: Complete order processing with confirmation display

### Technical Features
- **MVC Architecture**: Clean separation of Model, View, and Controller components
- **Session Management**: Robust session tracking for cart and user state
- **Input Validation**: Server-side validation with user-friendly error messages
- **Security**: BCrypt password hashing and secure session management
- **Responsive Design**: Mobile-friendly CSS styling
- **Database Integration**: MySQL database with proper indexing

## Project Structure

```
PageTurners/
├── src/main/
│   ├── java/com/pageturners/
│   │   ├── dao/                    # Data Access Objects
│   │   │   ├── BookDAO.java
│   │   │   └── UserDAO.java
│   │   ├── model/                  # Domain Models
│   │   │   ├── Book.java
│   │   │   ├── CartItem.java
│   │   │   ├── Order.java
│   │   │   └── User.java
│   │   ├── servlet/                # Controllers
│   │   │   ├── AuthServlet.java
│   │   │   ├── BookServlet.java
│   │   │   ├── CartServlet.java
│   │   │   ├── CheckoutServlet.java
│   │   │   ├── HomeServlet.java
│   │   │   └── OrderConfirmationServlet.java
│   │   └── util/
│   │       └── DatabaseConnection.java
│   └── webapp/
│       ├── WEB-INF/
│       │   ├── views/              # JSP Views
│       │   │   ├── books.jsp
│       │   │   ├── cart.jsp
│       │   │   ├── checkout.jsp
│       │   │   ├── home.jsp
│       │   │   ├── login.jsp
│       │   │   ├── order-confirmation.jsp
│       │   │   └── register.jsp
│       │   └── web.xml
│       └── index.jsp
├── database/
│   └── schema.sql                  # Database setup script
└── pom.xml                        # Maven configuration
```

## Setup Instructions

### Prerequisites
- Java 21 or higher
- Apache Tomcat 10.x
- MySQL 8.0 or higher
- Maven 3.6 or higher

### Database Setup
1. Install MySQL and start the service
2. Create the database and tables:
   ```bash
   mysql -u root -p < database/schema.sql
   ```
3. Update database credentials in `DatabaseConnection.java`:
   ```java
   private static final String URL = "jdbc:mysql://localhost:3306/pageturners_db";
   private static final String USERNAME = "your_username";
   private static final String PASSWORD = "your_password";
   ```

### Application Deployment
1. Clone the project
2. Update database configuration
3. Build the project:
   ```bash
   mvn clean package
   ```
4. Deploy the WAR file to Tomcat:
   - Copy `target/PageTurners-0.0.1-SNAPSHOT.war` to Tomcat's `webapps` directory
   - Rename to `PageTurners.war`
5. Start Tomcat
6. Access the application at `http://localhost:8080/PageTurners`

## Usage Guide

### For Customers
1. **Browse Books**: Visit the homepage to see featured books or browse by category
2. **Search**: Use the search bar to find specific books
3. **Register/Login**: Create an account or login to existing account
4. **Shopping**: Add books to cart, update quantities, or remove items
5. **Checkout**: Complete secure checkout with shipping information
6. **Order Confirmation**: Receive order confirmation with details

### Sample Data
The database includes 20 sample books across various categories:
- **Fiction**: Classic novels like "To Kill a Mockingbird", "1984", "The Great Gatsby"
- **Non-Fiction**: Popular titles like "Sapiens", "Educated", "Becoming"
- **Academic**: Textbooks for computer science, math, biology, chemistry, physics
- **Fantasy/Sci-Fi**: "The Hobbit", "Harry Potter", "Dune", "Neuromancer"

## Technical Implementation

### MVC Architecture
- **Model**: Domain objects (User, Book, Order, CartItem) with database operations via DAOs
- **View**: JSP pages with JSTL for dynamic content rendering
- **Controller**: Servlets handling HTTP requests and business logic

### Session Management
- User authentication state maintained in HttpSession
- Shopping cart persisted across browser sessions
- Secure session invalidation on logout

### Security Features
- Password hashing using BCrypt
- Input validation on all forms
- SQL injection prevention with prepared statements
- Session-based authentication

### Database Design
- Normalized relational database design
- Proper indexing for performance
- Foreign key constraints for data integrity

## Course Requirements Fulfilled

### ✅ Web Application Development with JSP and Servlets
- Complete JSP/Servlet implementation
- Proper use of JSP directives, scriptlets, and JSTL
- Servlet-based request handling and response generation

### ✅ Session Tracking
- HttpSession for user authentication
- Session-based shopping cart implementation
- Session timeout configuration

### ✅ Dynamic Content
- Dynamic book listings with database integration
- Real-time cart updates
- Conditional rendering based on user state

### ✅ Input Validation
- Server-side form validation
- User-friendly error messages
- Data sanitization and security checks

### ✅ MVC Architecture
- Clear separation of concerns
- Model classes for data representation
- Controller servlets for business logic
- View JSPs for presentation

### ✅ Additional Features
- Multiple navigation options at each step
- User profile data pre-filling during checkout
- Uniform, responsive user interface
- SSL checkout simulation
- Order confirmation system

## Future Enhancements
- Admin panel for book management
- User order history
- Book reviews and ratings
- Payment gateway integration
- Email notifications
- Inventory management
- Advanced search filters

## License
This project is developed for educational purposes as part of the Web Application Development with JSP and Servlets course.