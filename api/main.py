import ipaddress
import subprocess
import re
import sys
from flask import Flask, request, jsonify

app = Flask(__name__)


def is_valid_ip(ip):
    """Check if the given IP address is valid."""
    try:
        ipaddress.ip_address(ip)
        return True
    except ValueError:
        return False


def traceroute(ip):
    """Perform a traceroute to the given IP address and extract only the IPs."""
    try:
        traceroute_command = ['traceroute', ip] if not sys.platform.startswith('win') else ['tracert', ip]
        result = subprocess.run(traceroute_command, capture_output=True, text=True)

        ip_pattern = re.compile(r'\b(?:[0-9]{1,3}\.){3}[0-9]{1,3}\b')
        ips = ip_pattern.findall(result.stdout)

        return ips
    except Exception as e:
        return str(e)


@app.route('/validate_ip', methods=['POST'])
def validate_ip():
    data = request.get_json()
    ip = data.get('ip', '')

    if is_valid_ip(ip):
        return jsonify({'status': 'valid'}), 200
    else:
        return jsonify({'status': 'invalid'}), 400


@app.route('/traceroute', methods=['POST'])
def perform_traceroute():
    data = request.get_json()
    ip = data.get('ip', '')

    if not is_valid_ip(ip):
        return jsonify({'error': 'Invalid IP address'}), 400

    trace_result = traceroute(ip)
    return jsonify({'traceroute': trace_result}), 200


if __name__ == '__main__':
    app.run(port=5000,host='0.0.0.0',debug=True)
