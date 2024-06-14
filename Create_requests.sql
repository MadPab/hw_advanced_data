CREATE TABLE Genres (
    GenreID SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT null
);

CREATE TABLE Artists (
    ArtistID SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL
);

CREATE TABLE ArtistGenres (
    ArtistGenreID SERIAL PRIMARY KEY,
    ArtistID INT NOT NULL,
    GenreID INT NOT NULL,
    FOREIGN KEY (ArtistID) REFERENCES Artists (ArtistID) ON DELETE CASCADE,
    FOREIGN KEY (GenreID) REFERENCES Genres (GenreID) ON DELETE CASCADE
);

CREATE TABLE Albums (
    AlbumID SERIAL PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    ReleaseYear INT NOT NULL,
    CONSTRAINT check_release CHECK (ReleaseYear BETWEEN 1800 AND EXTRACT(YEAR FROM CURRENT_DATE)),
    CONSTRAINT unique_album_title UNIQUE (Title)
);

CREATE TABLE ArtistAlbums (
    ArtistAlbumID SERIAL PRIMARY KEY,
    ArtistID INT NOT NULL,
    AlbumID INT NOT NULL,
    FOREIGN KEY (ArtistID) REFERENCES Artists (ArtistID) ON DELETE CASCADE,
    FOREIGN KEY (AlbumID) REFERENCES Albums (AlbumID) ON DELETE CASCADE
);

CREATE TABLE Tracks (
    TrackID SERIAL PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Duration TIME NOT NULL,
    AlbumID INT NOT NULL,
    FOREIGN KEY (AlbumID) REFERENCES Albums (AlbumID) ON DELETE CASCADE,
    CONSTRAINT check_duration CHECK (Duration BETWEEN '00:00:30' AND '00:10:00'),
    CONSTRAINT unique_track_title UNIQUE (Title, AlbumID)
);

CREATE TABLE Collections (
    CollectionID SERIAL PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    ReleaseYear INT NOT NULL,
    CONSTRAINT check_collection CHECK (ReleaseYear BETWEEN 1800 AND EXTRACT(YEAR FROM CURRENT_DATE)),
    CONSTRAINT unique_collect_title UNIQUE (Title)
);

CREATE TABLE CollectionTracks (
    CollectionTrackID SERIAL PRIMARY KEY,
    CollectionID INT NOT NULL,
    TrackID INT NOT NULL,
    FOREIGN KEY (CollectionID) REFERENCES Collections (CollectionID) ON DELETE CASCADE,
    FOREIGN KEY (TrackID) REFERENCES Tracks (TrackID) ON DELETE CASCADE
);
