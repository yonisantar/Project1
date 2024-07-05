# Flask IP Validation and Traceroute API

This Flask API provides two main functionalities:

1. **IP Validation**: Checks if the provided IP address is valid.
2. **Traceroute**: Performs a traceroute to the specified IP address and returns the IP addresses encountered during the route.

## Requirements

- Python 3.x
- Flask
- ipaddress
- subprocess
- re
- sys

## Installation

1. Clone the repository or download the code.

2. Create a virtual environment and activate it:

    ```bash
    python3 -m venv venv
    source venv/bin/activate  # On Windows use `venv\Scripts\activate`
    ```

3. Install the required packages:

    ```bash
    pip install Flask
    ```

## Usage

1. Run the Flask application:

    ```bash
    python app.py
    ```

2. The application will be available at `http://127.0.0.1:5000`.

### Endpoints

#### 1. Validate IP

- **URL**: `/validate_ip`
- **Method**: `POST`
- **Description**: Validates if the provided IP address is valid.
- **Request Body**: JSON object containing the IP address.

    ```json
    {
        "ip": "8.8.8.8"
    }
    ```

- **Response**: JSON object indicating whether the IP address is valid.

    - Valid IP:

        ```json
        {
            "status": "valid"
        }
        ```

    - Invalid IP:

        ```json
        {
            "status": "invalid"
        }
        ```

#### 2. Perform Traceroute

- **URL**: `/traceroute`
- **Method**: `POST`
- **Description**: Performs a traceroute to the specified IP address and returns the IP addresses encountered.
- **Request Body**: JSON object containing the IP address.

    ```json
    {
        "ip": "8.8.8.8"
    }
    ```

- **Response**: JSON object with the IP addresses encountered during the traceroute.

    ```json
    {
        "traceroute": [
            "192.168.1.1",
            "10.0.0.1",
            "8.8.8.8"
        ]
    }
    ```
