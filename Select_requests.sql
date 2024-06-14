-- Количество исполнителей в каждом жанре.
SELECT g.Name AS GenreName, COUNT(ag.ArtistID) AS ArtistCount
FROM Genres g
JOIN ArtistGenres ag ON g.GenreID = ag.GenreID
GROUP BY g.Name;

-- Количество треков, вошедших в альбомы 2019–2020 годов.
SELECT COUNT(t.TrackID) AS TrackCount
FROM Tracks t
JOIN Albums a ON t.AlbumID = a.AlbumID
WHERE a.ReleaseYear BETWEEN 2019 AND 2020;

-- Средняя продолжительность треков по каждому альбому.
SELECT a.Title AS AlbumTitle, AVG(EXTRACT(EPOCH FROM t.Duration)) AS AverageDurationInSeconds
FROM Tracks t
JOIN Albums a ON t.AlbumID = a.AlbumID
GROUP BY a.Title;

-- Все исполнители, которые не выпустили альбомы в 2020 году.
SELECT a.Name
FROM Artists a
WHERE a.ArtistID NOT IN (
    SELECT aa.ArtistID
    FROM ArtistAlbums aa
    JOIN Albums al ON aa.AlbumID = al.AlbumID
    WHERE al.ReleaseYear = 2020
);

-- Названия сборников, в которых присутствует конкретный исполнитель.
SELECT DISTINCT c.Title AS CollectionTitle
FROM Collections c
JOIN CollectionTracks ct ON c.CollectionID = ct.CollectionID
JOIN Tracks t ON ct.TrackID = t.TrackID
JOIN Albums a ON t.AlbumID = a.AlbumID
JOIN ArtistAlbums aa ON a.AlbumID = aa.AlbumID
JOIN Artists ar ON aa.ArtistID = ar.ArtistID
WHERE ar.Name = 'Ширан Эд';

-- Названия альбомов, в которых присутствуют исполнители более чем одного жанра.
SELECT DISTINCT a.Title AS AlbumTitle
FROM Albums a
JOIN ArtistAlbums aa ON a.AlbumID = aa.AlbumID
JOIN Artists ar ON aa.ArtistID = ar.ArtistID
JOIN ArtistGenres ag ON ar.ArtistID = ag.ArtistID
GROUP BY a.AlbumID, a.Title
HAVING COUNT(DISTINCT ag.GenreID) > 1;

-- Наименования треков, которые не входят в сборники.
SELECT t.Title AS TrackTitle
FROM Tracks t
LEFT JOIN CollectionTracks ct ON t.TrackID = ct.TrackID
WHERE ct.CollectionID IS NULL;

-- Исполнитель или исполнители, написавшие самый короткий по продолжительности трек, — теоретически таких треков может быть несколько.
SELECT t.TrackID, t.Title, t.Duration
FROM Tracks t
WHERE t.Duration = (SELECT MIN(Duration) FROM Tracks);

-- Названия альбомов, содержащих наименьшее количество треков.

WITH AlbumTrackCounts AS (
    SELECT a.AlbumID, a.Title, COUNT(t.TrackID) AS TrackCount
    FROM Albums a
    LEFT JOIN Tracks t ON a.AlbumID = t.AlbumID
    GROUP BY a.AlbumID, a.Title
)
SELECT Title AS AlbumTitle
FROM AlbumTrackCounts
WHERE TrackCount = (SELECT MIN(TrackCount) FROM AlbumTrackCounts);
