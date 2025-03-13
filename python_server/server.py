from flask import Flask, request, jsonify
import mysql.connector
import bcrypt
app = Flask(__name__)

db_config = {
    'host': 'localhost',
    'user': 'root',        # Your MySQL user
    'password': 'root',# Your MySQL password
    'database': 'wubrg'       # The database name you created
}

@app.route('/create-user', methods=['POST'])
def create_user():
    data = request.get_json()
    username = data.get('username')
    password = data.get('password')

    # Basic validation
    if not username or not password:
        return jsonify({'error': 'Missing username or password'}), 400

    # Hash the password using bcrypt
    # bcrypt requires bytes, so we encode the password string
    hashed_password = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())

    try:
        # Connect to the database
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()

        # Insert into the "users" table with a column named "password_hash"
        query = "INSERT INTO users (username, password) VALUES (%s, %s)"
        cursor.execute(query, (username, hashed_password.decode('utf-8')))
        conn.commit()

        cursor.close()
        conn.close()

        return jsonify({'message': 'User created successfully!'}), 200
    except mysql.connector.Error as err:
        # In production, you’d want to log errors and avoid exposing them directly
        return jsonify({'error': str(err)}), 500

if __name__ == '__main__':
    # Listen on port 3000, adjust if needed
    app.run(host='0.0.0.0', port=3000, debug=True)
