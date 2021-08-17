import os
import glob
import psycopg2
import pandas as pd
from sql_queries import *


def process_song_file(cur, filepath):
    """
    Extracts data from song json file and load into DB tables.
    Convert Json into pandas dataframe and insert into songs table and artists table.
    """
    # open song file
    df = pd.read_json(filepath, lines=True)

    # insert song record
    song_data = df[['artist_id', 'song_id', 'title', 'year', 'duration']].drop_duplicates().values
    try:
        cur.execute(song_table_insert, tuple(song_data[0]))
    except psycopg2.Error as e:
        print("error fund:", e)
    
    # insert artist record
    artist_data = df[['artist_id', 'artist_name', 'artist_location',\
                          'artist_latitude', 'artist_longitude' ]].drop_duplicates().values
    try:
        cur.execute(artist_table_insert, tuple(artist_data[0]))
    except psycopg2.Error as e:
        print("error fund:", e)


def process_log_file(cur, filepath):
    """
    Extracts data from log json file and load into DB tables.
    Convert Json into pandas dataframe and insert into time, users and songplays table.
    """
    # open log file
    df = pd.read_json(filepath, lines=True)

    # filter by NextSong action
    df = df[df['page']=='NextSong']

    # convert timestamp column to datetime
    t = pd.to_datetime(df['ts'], unit='ms')
    df['start_time'] = pd.to_datetime(df['ts'], unit='ms')
    
    # insert time data records
    df['hour'] = t.dt.hour
    df['day'] = t.dt.day
    df['week'] = t.dt.week
    df['month'] = t.dt.month
    df['year'] = t.dt.year
    df['weekday'] = t.dt.weekday

    time_df = df[['start_time','hour','day','week','month','year','weekday']].drop_duplicates()

    for i, row in time_df.iterrows():
        try:
            cur.execute(time_table_insert, list(row))
        except psycopg2.Error as e:
            print("error fund:", e)

    # load user table
    user_df = df[['userId','firstName','lastName','gender','level']].drop_duplicates()

    # insert user records
    for i, row in user_df.iterrows():
        try:
            cur.execute(user_table_insert, row)
        except psycopg2.Error as e:
            print("error fund:", e)

    # insert songplay records
    for index, row in df.iterrows():
        
        # get songid and artistid from song and artist tables
        cur.execute(song_select, (row.song, row.artist, row.length))
        results = cur.fetchone()
        
        if results:
            songid, artistid = results
        else:
            songid, artistid = None, None

        # insert songplay record
        songplay_data = (row.start_time, row.userId, row.level, songid, 
                         artistid,row.sessionId, row.location, row.userAgent)
        try:
            cur.execute(songplay_table_insert, songplay_data)
        except psycopg2.Error as e:
            print("error fund:", e)


def process_data(cur, conn, filepath, func):
    """
    Gets all files matching extension from directory
    process all files to load data into DB
    """
    all_files = []
    for root, dirs, files in os.walk(filepath):
        files = glob.glob(os.path.join(root,'*.json'))
        for f in files :
            all_files.append(os.path.abspath(f))
    all_files = [i for i in all_files if '.ipynb_checkpoints' not in i]
    
    # get total number of files found
    num_files = len(all_files)
    print('{} files found in {}'.format(num_files, filepath))

    # iterate over files and process
    for i, datafile in enumerate(all_files, 1):
        func(cur, datafile)
        conn.commit()
        print('{}/{} files processed.'.format(i, num_files))


def main():
    conn = psycopg2.connect("host=127.0.0.1 dbname=sparkifydb user=student password=student")
    cur = conn.cursor()
    conn.set_session(autocommit=True)
    
    process_data(cur, conn, filepath='data/song_data', func=process_song_file)
    process_data(cur, conn, filepath='data/log_data', func=process_log_file)
 

    conn.close()


if __name__ == "__main__":
    main()