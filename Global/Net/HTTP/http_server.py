from flask import Flask, jsonify

app = Flask(__name__)

# Dữ liệu mẫu
player_data = {
    "id": 1,
    "name": "Minh",
    "score": 9999,
    "level": 50,
    "items": ["sword", "shield", "potion"]
}

@app.route("/api/player", methods=["GET"])
def get_player():
    return jsonify(player_data)

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000)