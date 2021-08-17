# DROP TABLES

songplay_table_drop = "DROP TABLE IF EXISTS songplays "
user_table_drop = "DROP TABLE IF EXISTS users"
song_table_drop = "DROP TABLE IF EXISTS songs"
artist_table_drop = "DROP TABLE IF EXISTS artists"
time_table_drop = "DROP TABLE IF EXISTS time"

# CREATE TABLES

songplay_table_create = ("CREATE TABLE IF NOT EXISTS songplays \
            (songplay_id serial PRIMARY KEY, start_time TIMESTAMP NOT NULL, \
            user_id Varchar NOT NULL, level Varchar,\
            song_id Varchar, artist_id Varchar, session_id Varchar NOT NULL, location Varchar,\
            user_agent text)")

user_table_create = ("CREATE TABLE IF NOT EXISTS users\
            (user_id Varchar PRIMARY KEY, first_name Varchar, last_name Varchar, gender Varchar,\
                       level Varchar)")

song_table_create = ("CREATE TABLE IF NOT EXISTS songs \
        (song_id Varchar PRIMARY KEY, title Varchar NOT NULL, artist_id Varchar NOT NULL, \
        year int, duration FLOAT)")

artist_table_create = ("CREATE TABLE IF NOT EXISTS artists\
            (artist_id Varchar PRIMARY KEY, name Varchar NOT NULL, \
            location Varchar, latitude FLOAT,longitude FLOAT)")

time_table_create = ("CREATE TABLE IF NOT EXISTS time \
            (start_time Varchar PRIMARY KEY, hour int, day int, week int,\
            month int, year int, weekday int)")


# INSERT RECORDS

songplay_table_insert = ("INSERT INTO songplays (start_time, user_id, level, song_id,  \
                        artist_id, session_id ,location, user_agent)\
                        VALUES (%s, %s, %s, %s, %s, %s, %s, %s)")

user_table_insert = ("INSERT INTO users (user_id, first_name,last_name, gender,level )\
                    VALUES (%s, %s, %s, %s, %s)\
                    ON CONFLICT (user_id) DO UPDATE SET level = EXCLUDED.level")

song_table_insert = ("INSERT INTO songs (artist_id, song_id, title, year, duration )\
                    VALUES (%s, %s, %s, %s, %s)\
                    ON CONFLICT (song_id) DO UPDATE SET duration = EXCLUDED.duration")

artist_table_insert = ("INSERT INTO artists (artist_id, name, location,latitude, longitude)\
                    VALUES (%s, %s, %s, %s, %s)\
                    ON CONFLICT (artist_id) DO UPDATE SET location = excluded.location")


time_table_insert = ("INSERT INTO time (start_time, hour, day, week, month, year, weekday)\
                    VALUES (%s, %s, %s, %s, %s, %s, %s)")

# FIND SONGS

song_select = ("SELECT s.song_id, s.artist_id FROM songs s\
                FULL JOIN artists a ON s.artist_id = a.artist_id\
                WHERE s.title = %s\
                AND a.name = %s\
                AND s.duration = %s")
# QUERY LISTS

create_table_queries = [songplay_table_create, user_table_create, song_table_create, artist_table_create, time_table_create]
drop_table_queries = [songplay_table_drop, user_table_drop, song_table_drop, artist_table_drop, time_table_drop]