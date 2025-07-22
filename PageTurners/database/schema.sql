-- PageTurners Database Schema
-- Create the database
CREATE DATABASE IF NOT EXISTS pageturners_db;
USE pageturners_db;

-- Create users table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(50),
    zip_code VARCHAR(20),
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create books table
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    category VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    description TEXT,
    stock_quantity INT DEFAULT 0,
    image_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create orders table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) DEFAULT 'PENDING',
    shipping_address VARCHAR(255) NOT NULL,
    shipping_city VARCHAR(100) NOT NULL,
    shipping_state VARCHAR(50) NOT NULL,
    shipping_zip VARCHAR(20) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Create order_items table
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

-- Insert sample books data
INSERT INTO books (title, author, isbn, category, price, description, stock_quantity, image_url) VALUES
('To Kill a Mockingbird', 'Harper Lee', '978-0-06-112008-4', 'Fiction', 12.99, 'A gripping tale of racial injustice and loss of innocence in the American South.', 25, 'mockingbird.jpg'),
('1984', 'George Orwell', '978-0-452-28423-4', 'Fiction', 13.99, 'A dystopian social science fiction novel about totalitarian control.', 30, '1984.jpg'),
('The Great Gatsby', 'F. Scott Fitzgerald', '978-0-7432-7356-5', 'Fiction', 11.99, 'A classic American novel set in the Jazz Age.', 20, 'gatsby.jpg'),
('Pride and Prejudice', 'Jane Austen', '978-0-14-143951-8', 'Fiction', 10.99, 'A romantic novel of manners set in Georgian England.', 15, 'pride.jpg'),
('The Catcher in the Rye', 'J.D. Salinger', '978-0-316-76948-0', 'Fiction', 12.50, 'A controversial novel about teenage rebellion and alienation.', 18, 'catcher.jpg'),

('A Brief History of Time', 'Stephen Hawking', '978-0-553-38016-3', 'Non-Fiction', 15.99, 'A landmark volume in science writing by one of the great minds of our time.', 12, 'hawking.jpg'),
('Sapiens', 'Yuval Noah Harari', '978-0-06-231609-7', 'Non-Fiction', 16.99, 'A brief history of humankind from the Stone Age to the present.', 22, 'sapiens.jpg'),
('The Immortal Life of Henrietta Lacks', 'Rebecca Skloot', '978-1-4000-5217-2', 'Non-Fiction', 14.99, 'The story of how one woman''s cells changed medicine forever.', 8, 'henrietta.jpg'),
('Educated', 'Tara Westover', '978-0-399-59050-4', 'Non-Fiction', 15.50, 'A memoir about a woman who grows up in a survivalist family.', 16, 'educated.jpg'),
('Becoming', 'Michelle Obama', '978-1-5247-6313-8', 'Non-Fiction', 17.99, 'An intimate, powerful, and inspiring memoir by the former First Lady.', 28, 'becoming.jpg'),

('Introduction to Algorithms', 'Thomas H. Cormen', '978-0-262-03384-8', 'Academic', 89.99, 'A comprehensive textbook on algorithms and data structures.', 10, 'algorithms.jpg'),
('Calculus: Early Transcendentals', 'James Stewart', '978-1-285-74155-0', 'Academic', 299.99, 'A widely used calculus textbook for university students.', 5, 'calculus.jpg'),
('Campbell Biology', 'Jane B. Reece', '978-0-321-55823-7', 'Academic', 349.99, 'The world''s most successful majors biology textbook.', 8, 'biology.jpg'),
('Organic Chemistry', 'Paula Yurkanis Bruice', '978-0-321-80322-1', 'Academic', 279.99, 'A comprehensive organic chemistry textbook.', 6, 'chemistry.jpg'),
('Physics for Scientists and Engineers', 'Raymond A. Serway', '978-1-133-94713-0', 'Academic', 319.99, 'A thorough introduction to physics concepts and applications.', 4, 'physics.jpg'),

('The Hobbit', 'J.R.R. Tolkien', '978-0-547-92822-7', 'Fantasy', 13.99, 'A classic fantasy adventure about Bilbo Baggins.', 35, 'hobbit.jpg'),
('Harry Potter and the Sorcerer''s Stone', 'J.K. Rowling', '978-0-439-70818-8', 'Fantasy', 8.99, 'The first book in the beloved Harry Potter series.', 40, 'potter.jpg'),
('Dune', 'Frank Herbert', '978-0-441-17271-9', 'Science Fiction', 16.99, 'A science fiction masterpiece set on the desert planet Arrakis.', 20, 'dune.jpg'),
('The Handmaid''s Tale', 'Margaret Atwood', '978-0-385-49081-8', 'Science Fiction', 14.99, 'A dystopian novel about a totalitarian society.', 18, 'handmaid.jpg'),
('Neuromancer', 'William Gibson', '978-0-441-56956-9', 'Science Fiction', 13.50, 'A groundbreaking cyberpunk novel that defined a genre.', 14, 'neuromancer.jpg');

-- Create indexes for better performance
CREATE INDEX idx_books_category ON books(category);
CREATE INDEX idx_books_title ON books(title);
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_orders_user_id ON orders(user_id);
CREATE INDEX idx_order_items_order_id ON order_items(order_id);