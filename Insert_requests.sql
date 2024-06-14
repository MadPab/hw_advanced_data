-- Сначала добавлял по одному, смотря id добавленных строк

insert into artists (Name) 
values ('Ширан Эд');

insert into albums (title, releaseyear)
values ('No.6 Collaborations Project', 2019);

insert into tracks (title, duration, albumid)
values ('Happier', '00:03:27', 10);

insert into genres (name)
values ('Фолк');

insert into artistgenres (artistid, genreid)
values (9, 7);

insert into artistalbums (artistid, albumid)
values (9, 10);

insert into collections (title, releaseyear)
values ('Slumdon Bridge', 2019);

insert into collectiontracks (collectionid, trackid)
values (4, 21);


-- Затем прочитал про RETURNING и CURRVAL, решил использовать RETURNING ... INTO ... + добавил временную таблицу для переменных

DO $$ 
DECLARE
    artist_id INT;
    album_id INT;
    track_id INT;
    genre_id INT;
    collection_id INT;
BEGIN

	INSERT INTO artists (Name)
	VALUES ('Инкин Павел')
	RETURNING artistid INTO artist_id;
	
	INSERT INTO albums (Title, ReleaseYear)
	VALUES ('Netology Project', 2024)
	RETURNING albumid INTO album_id;
	
	INSERT INTO tracks (Title, Duration, AlbumID)
	VALUES ('HomeWork', '00:03:20', album_id)
	RETURNING trackid INTO track_id;
	
	INSERT INTO genres (Name)
	VALUES ('Фолк')
	RETURNING GenreID INTO genre_id;
	
	INSERT INTO artistgenres (artistid, genreid)
	VALUES (artist_id, genre_id);
	
	INSERT INTO artistalbums (artistid, albumid)
	VALUES (artist_id, album_id);
	
	INSERT INTO collections (title, releaseyear)
	VALUES ('Netology Cool', 2019)
	RETURNING collectionid INTO collection_id;
	
	INSERT INTO collectiontracks (collectionid, trackid)
	VALUES (collection_id, track_id);

END $$;
