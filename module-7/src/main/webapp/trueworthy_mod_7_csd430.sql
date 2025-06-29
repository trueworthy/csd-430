CREATE DATABASE IF NOT EXISTS CSD430;

USE CSD430;

CREATE USER IF NOT EXISTS 'student1'@'localhost' IDENTIFIED BY 'pass';

GRANT ALL PRIVILEGES ON csd430.* TO 'student1'@'localhost';

CREATE TABLE lea_library_data (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(255),
    genre VARCHAR(100),
    publication_year INT
);

INSERT INTO lea_library_data (title, author, genre, publication_year) VALUES
('Murder Your Employer', 'Rupert Holmes', 'Mystery', 2023),
('The Instructor', 'TR Hendricks', 'Thriller', 2023),
('From Below', 'Darcy Coates', 'Horror', 2022),
('Grave Reservations', 'Cherie Priest', 'Mystery', 2021),
('The Lost Village', 'Camilla Sten and Alexandra Fleming', 'Horror', 2021),
('The New Neighbor', 'Carter Wilson', 'Suspense', 2022),
('The Cartographers', 'Peng Shepherd', 'Fantasy', 2022),
('Girl in Ice', 'Erica Ferencik', 'Thriller', 2022),
('The Fields', 'Erin Young', 'Mystery', 2022),
('Mickey7', 'Edward Ashton', 'Science Fiction', 2022);

SELECT * FROM lea_library_data;
