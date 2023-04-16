import pymysql
import json

conn = pymysql.connect(
    host='34.122.138.172',
    user='root',
    password='admin',
    db='website',
    charset='utf8mb4',
    cursorclass=pymysql.cursors.DictCursor
)

def write_userpass(new_username, new_password):
    try:
        with conn.cursor() as cursor:
            # Create a new record
            sql = "INSERT INTO `users` (`username`, `password`) VALUES (%s, %s)"
            cursor.execute(sql, (new_username, new_password))

        # Commit changes
        conn.commit()

        print("Record inserted successfully")
    finally:
        conn.close()

def get_userpass(new_username, new_password):
    try:
        with conn.cursor() as cursor:
            # Read data from database
            sql = "select username, password  from users where username = " + "'" + new_username + "'" + "AND password = " + "'" + new_password + "'"
            cursor.execute(sql)

            # Fetch all rows
            row = cursor.fetchall()
            row = str(row)
            row = row.replace("'", '"')
            row = json.loads(row)
            # Print results
            if new_username == (row[0]['username']):
               print("It\'s normal")
            else:
               print("It\' not normal")
    except json.decoder.JSONDecodeError:
        print("Invalid Userpass")

    finally:
        conn.close()

#write_userpass(new_username="newuser", new_password="newpass")
get_userpass(new_username="root", new_password="admi")