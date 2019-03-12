create table author (
id bigint primary key,
name varchar(10),
birthday smallint

);

create table books (
id BIGINT PRIMARY KEY,
title VARCHAR(10)

);

CREATE table author_books (
  author_id BIGINT ,
  books_id BIGINT ,
  PRIMARY KEY (author_id, books_id)
);

alter table author_books add constraint FK_author_books_author FOREIGN KEY (author_id) REFERENCES author (id);
alter table author_books add constraint FK_author_books_books FOREIGN KEY (books_id) REFERENCES books (id);

create table genre (
  id bigint primary key,
  type VARCHAR(10)

);

CREATE TABLE  books_genre (
  books_id BIGINT,
  genre_id BIGINT,
  PRIMARY KEY  (books_id, genre_id)

);

alter table books_genre add constraint FK_books_genre_books FOREIGN KEY  (books_id) REFERENCES books (id);
alter table books_genre add constraint FK_books_genre_genre FOREIGN KEY  (genre_id) REFERENCES genre (id);

INSERT INTO author VALUES (1, 'Alex', '1992');
INSERT INTO author VALUES (2, 'Den', '1989');
INSERT INTO author VALUES (3, 'Rob', '1984');
INSERT INTO author VALUES (4, 'John', '1990');

INSERT INTO books VALUES (1, 'a' );
INSERT INTO books VALUES (2, 'b' );
INSERT INTO books VALUES (3, 'c');
INSERT INTO books VALUES (4, 'd');
INSERT INTO books VALUES (5, 'e');
INSERT INTO books VALUES (6, 'f');
INSERT INTO books VALUES (7, 'g');

INSERT INTO genre VALUES (1, 'fantasy' );
INSERT INTO genre VALUES (2, 'history' );
INSERT INTO genre VALUES (3, 'comedy');
INSERT INTO genre VALUES (4, 'horror');

INSERT INTO author_books VALUES (1, 2 );
INSERT INTO author_books VALUES (1, 6 );
INSERT INTO author_books VALUES (2, 1 );
INSERT INTO author_books VALUES (2, 4 );
INSERT INTO author_books VALUES (2, 5 );
INSERT INTO author_books VALUES (3, 3 );
INSERT INTO author_books VALUES (3, 7 );
INSERT INTO author_books VALUES (4, 1 );

INSERT INTO books_genre VALUES (1, 1 );
INSERT INTO books_genre VALUES (2, 2 );
INSERT INTO books_genre VALUES (3, 3 );
INSERT INTO books_genre VALUES (4, 1 );
INSERT INTO books_genre VALUES (5, 1 );
INSERT INTO books_genre VALUES (6, 2 );
INSERT INTO books_genre VALUES (7, 3 );



select * from author ORDER BY birthday ASC, name DESC;

select * from books
union
select * from genre;

select books.title, genre.type from books
left join books_genre on books_genre.books_id = books.id
left join genre on books_genre.genre_id = genre.id
where genre.type = 'fantasy';

select books.title from author
left join author_books on author_books.author_id = author.id
left join books on author_books.books_id = books.id
where author.name = 'Alex';

select genre.type from books
left join books_genre on books_genre.books_id = books.id
left join genre on books_genre.genre_id = genre.id
left join author_books on author_books.books_id = books.id
left join author on author_books.author_id = author.id
where author.name = 'Den';

select max (type) from genre
left join books_genre on books_genre.genre_id = genre.id
left join books on books_genre.books_id = books.id
left join author_books on author_books.books_id = books.id
left join author on author_books.author_id = author.id
group by genre; -- Какой самый популярный жанр


select author.name, count(books.title) from author
left join author_books on author_books.author_id = author.id
left join books on author_books.books_id = books.id
left join books_genre on books_genre.books_id = books.id
left join genre on books_genre.genre_id = genre.id
GROUP BY  author.name -- У какого автора больше всего книг

select genre.type, books.title from genre -- Найти жанры в которых не написано ни одной книги
left join books_genre on books_genre.genre_id = genre.id
left join books on books_genre.books_id = books.id
where books.title is null;



-- Выбрать авторов, моложе 27 лет у которых написана только одна книга в жанре история
-- Выбрать авторов,  у которых написана только одна книга в жанре история
-- Выбрать авторов, у которых написана только одна книга

select author.name, count (books.title) as cnt from author
left join author_books on author_books.author_id = author.id
left join books on author_books.books_id = books.id
left join books_genre on books_genre.books_id = books.id
left join genre on books_genre.genre_id = genre.id
where genre.type = 'fantasy' and author.birthday >= 1990
group by author.name having count (books.title) = 1;







