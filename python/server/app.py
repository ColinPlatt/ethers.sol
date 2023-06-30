import os
import subprocess
from flask import Flask, send_from_directory
from dotenv import load_dotenv

load_dotenv() 

ABSOLUTE_OUTPUT_DIR_PATH = os.getenv('ABSOLUTE_OUTPUT_DIR_PATH')
HTML_OUTPUT_FILE = os.getenv('HTML_OUTPUT_FILE')

current_file_path = os.path.abspath(__file__)
watchdog_script_path = os.path.join(os.path.dirname(current_file_path), 'watchDog.py')

# Start the watchDog.py script as a separate process
watchdog_process = subprocess.Popen(['python', watchdog_script_path])

#use absolute path to avoid issues with running from different directories
app = Flask(__name__, static_folder=ABSOLUTE_OUTPUT_DIR_PATH)

@app.route('/')
def home():
    return send_from_directory(app.static_folder, 'renderedSite.html')

if __name__ == "__main__":
    app.run(port=8000, debug=True)