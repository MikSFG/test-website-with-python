# import pymysql
# import json
#
# conn = pymysql.connect(
#     host='34.118.64.48',
#     user='root',
#     password='changeme',
#     db='website-db',
#     charset='utf8mb4',
#     cursorclass=pymysql.cursors.DictCursor
# )
#
#
# def write_userpass(username, password):
#     try:
#         with conn.cursor() as cursor:
#             # Create a new record
#             sql = "INSERT INTO `users` (`username`, `password`) VALUES (%s, %s)"
#             cursor.execute(sql, (username, password))
#
#         # Commit changes
#         conn.commit()
#
#         print("Record inserted successfully")
#     finally:
#         conn.close()
#         print("Record inserted successfully 2")
#
#
# def get_userpass(username, password):
#     try:
#         with conn.cursor() as cursor:
#             # Read data from database
#             sql = "select username, password  from users where username = " + "'" + username + "'" + "AND password = " + "'" + password + "'"
#             cursor.execute(sql)
#
#             # Fetch the needed row and convert it to JSON
#             row = cursor.fetchall()
#             row = str(row)
#             row = row.replace("'", '"')
#             row = json.loads(row)
#             # Print the result
#             if username == (row[0]['username']):
#                 print("It\'s normal")
#             else:
#                 print("It\' not normal")
#
#     except json.decoder.JSONDecodeError:
#         print("Invalid Username/Password")
#
#     finally:
#         conn.close()
#         print("Success!")
