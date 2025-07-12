CREATE DATABASE IF NOT EXISTS CSD430;

USE CSD430;

CREATE USER IF NOT EXISTS 'student1'@'localhost' IDENTIFIED BY 'pass';

GRANT ALL PRIVILEGES ON CSD430.* TO 'student1'@'localhost';

CREATE TABLE trueworthy_library_data (
  BookID       int          NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Title        varchar(255) NOT NULL,
  Author       varchar(255) NOT NULL,
  Genre        varchar(255) NOT NULL,
  publish_year int          NOT NULL,
  bookFormat   varchar(255) NOT NULL,
  ISBN         varchar(13)  NOT NULL
);

INSERT INTO trueworthy_library_data (Title, Author, Genre, publish_year, bookFormat, ISBN) VALUES
(
  'Murder Your Employer', 'Rupert Holmes', 'Mystery', 2022, 'HC', '9781451648218'
),
(
  'The Instructor', 'TR Hendricks', 'Thriller', 2021, 'MM', '9781250832962'
),
(
  'From Below', 'Darcy Coates', 'Horror', 2021, 'PB', '9781728220239'
),
(
  'Grave Reservations', 'Cherie Priest', 'Mystery', 2021, 'HC', '9781982168896'
),
(
  'The New Neighbor', 'Carter Wilson', 'Thriller', 2021, 'PB', '9781728247526'
),
(
  'Girl in Ice', 'Erica Ferencik', 'Thriller', 2022, 'HC', '9781982143022'
),
(
  'The Fields', 'Erin Young', 'Crime', 2021, 'HC', '9781250799395'
),
(
  'Mickey7', 'Edward Ashton', 'Science Fiction', 2022, 'PB', '9781250875280'
),
(
  'The Silent Patient', 'Alex Michaelides', 'Thriller', 2019, 'HC', '9781250301697'
),
(
  'Moon USA National Parks Hiking', 'Jason Frye', 'Travel', 2025, 'PB', '9798886470826'
),
(
  'Where the Forest Meets the Stars', 'Glendy Vanderah', 'Fantasy', 2019, 'PB', '9781503904910'
),
(
  'Mexican Gothic', 'Silvia Moreno-Garcia', 'Horror', 2020, 'HC', '9780525620785'
),
(
  'Dessert Person: Recipes and Guidance for Baking with Confidence: A Baking Book', 'Claire Saffitz', 'Cooking', 2020, 'HC', '9781984826961'
),
(
  'The Lorax', 'Dr. Seuss', 'Kids', 1971, 'HC', '9780394823379'
),
(
  'Zen and the Art of Motorcycle Maintenance', 'Robert M Pirsig', 'Philosophy', 2006, 'MM', '9780060589462'
),
(
  'The Secret of Secrets', 'Dan Brown', 'Thriller', 2025, 'HC', '9780385546898'
),
(
  'Denver Dossier: Themed Adventures for Every Traveler', 'Kimberly Burk Cordova', 'Travel', 2024, 'LP', '9798348571825'
),
(
  'The Midnight Library', 'Matt Haig', 'Fantasy', 2020, 'HC', '9780525559474'
),
(
  'I Know Why the Caged Bird Sings', 'Maya Angelou', 'Biographies', 2009, 'PB', '9780812980028'
),
(
  'Project Hail Mary', 'Andy Weir', 'Science Fiction', 2021, 'HC', '9780593135204'
),
(
  'The Guest List', 'Lucy Fokley', 'Mystery', 2020, 'HC', '9780062868930'
),
(
  'The Cruel Prince', 'Holly Black', 'Teen & Young Adult', 2018, 'HC', '9780316310314'
),
(
  'One Piece, Vol. 1: Romance Dawn', 'Eiichiro Oda', 'Comic', 2003, 'PB', '9781569319017'
),
(
  'The Godfather', 'Mario Puzo', 'Thrillers', 1969, 'HC', '9780399103421'
),
(
  'The Cartographers', 'Peng Shepherd', 'Fantasy', 2022, 'HC', '9780062910691'
),
(
  'The Forgotten 500', 'Gregory A. Freeman', 'History', 2008, 'PB', '9780451224958'
),
(
  'It Ends With Us', 'Colleen Hoover', 'Romance', 2016, 'PB', '9781501171345'
),
(
  'Gerald''s Game', 'Stephen King', 'Horror', 1994, 'HC', '9780831727529'
),
(
  '100 Plants to Feed the Bees', 'The Xerces Society', 'Nature', 2016, 'HC', '9781612128863'
),
(
  'The Maid', 'Nita Prose', 'Mystery', 2022, 'HC', '9780593356159'
),
(
  'A Brief History of Time', 'Stephen Hawking', 'Science', 1998, 'PB', '9780553380163'
),
(
  'The Last Thing He Told Me', 'Laura Dave', 'Thriller', 2021, 'HC', '9781501171345'
),
(
  'Expiration Dates', 'Rebecca Serle', 'Romance', 2024, 'HC', '9781982166823'
),
(
  'The Lost Village', 'Camilla Sten and Alexandra Fleming', 'Thriller', 2021, 'HC', '9781250249258'
),
(
  'Dr. Seuss''s ABC', 'Dr. Seuss', 'Kids', 1991, 'HC', '9780394800301'
);

SELECT * FROM trueworthy_library_data;