from flask import Flask, jsonify
import time
import math

app = Flask(__name__)

def calculate_values():
    # Розрахунок значень тригонометричних функцій
    values = [math.sin(i) for i in range(1, 100000)]
    start_time = time.time()
    sorted_values = sorted(values)
    elapsed_time = time.time() - start_time
    return sorted_values, elapsed_time

@app.route('/calculate', methods=['GET'])
def calculate():
    values, elapsed_time = calculate_values()
    return jsonify({
        'sorted_values': values[:10],  # Повернення лише перших 10 для тесту
        'elapsed_time': elapsed_time
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
