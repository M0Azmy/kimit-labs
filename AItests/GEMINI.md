# GEMINI.md

## Project Overview

This is a simple Python web application that serves as a DevOps challenge. The application uses the Tornado web framework and Redis for a simple counter functionality. It displays a "Hello, world!" message, the current environment (e.g., "PROD" or "DEV"), and a counter that increments on each page refresh.

The project is structured as a standard Python application with the following key components:

*   **`hello.py`**: The main application file, containing the Tornado web server and application logic.
*   **`templates/index.html`**: The HTML template for the main page.
*   **`static/`**: Contains static assets like CSS and favicons.
*   **`requirements.txt`**: Lists the Python dependencies (`redis` and `tornado`).
*   **`.env`**: Contains environment variables for configuration.
*   **`tests/test.py`**: Contains unit tests for the application.

## Building and Running

### 1. Install Dependencies

Install the required Python packages using pip:

```bash
pip install -r requirements.txt
```

### 2. Configure Environment Variables

The application requires the following environment variables to be set. A sample `.env` file is provided.

*   `ENVIRONMENT`: The application environment (e.g., `PROD` or `DEV`).
*   `HOST`: The hostname to run the application on (e.g., `localhost`).
*   `PORT`: The port to run the application on.
*   `REDIS_HOST`: The hostname of the Redis server.
*   `REDIS_PORT`: The port of the Redis server.
*   `REDIS_DB`: The Redis database to use.

### 3. Run the Application

To run the application, you need to export the environment variables from the `.env` file and then run the `hello.py` script:

```bash
export $(cat .env | xargs) && python hello.py
```

The application will be available at `http://<HOST>:<PORT>`.

### 4. Run Tests

To run the tests, execute the `test.py` script:

```bash
python tests/test.py
```

## Development Conventions

*   **Framework**: The application is built using the [Tornado](https://www.tornadoweb.org/en/stable/) web framework.
*   **Dependencies**: Python dependencies are managed with `pip` and are listed in `requirements.txt`.
*   **Configuration**: Application configuration is handled through environment variables, with default values provided in the `.env` file.
*   **Testing**: The project includes a `tests` directory with a `test.py` file for unit tests using the `unittest` module. The current tests are placeholders and should be expanded to cover the application's functionality.
*   **Static Files**: Static files such as CSS are served from the `static` directory.
*   **Templates**: HTML templates are located in the `templates` directory.
