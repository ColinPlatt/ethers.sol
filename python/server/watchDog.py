import os
import time
from subprocess import call
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler
from dotenv import load_dotenv

load_dotenv()

# Local path to the html file to be served
HTML_OUTPUT_FILE = os.getenv('HTML_OUTPUT_FILE')

# Adding this as you may not want to always run all tests when a file changes
FORGE_TEST_CMD = os.getenv('FORGE_TEST_CMD')

# Absolute path to your src directory (where your .sol files are)
ABSOLUTE_SRC_DIR_PATH = os.getenv('ABSOLUTE_SRC_DIR_PATH')

class MyHandler(FileSystemEventHandler):
    def on_modified(self, event):
        self.process(event)

    def on_created(self, event):
        self.process(event)

    def on_moved(self, event):
        self.process(event)

    def process(self, event):
        print(f'Event type: {event.event_type}  path : {event.src_path}')
        if event.src_path.endswith('.sol'):
            self.recompile_and_reload()

    def recompile_and_reload(self):
        # Run the 'forge test' command
        print('Recompiling and reloading...')
        call(FORGE_TEST_CMD, shell=True)

if __name__ == "__main__":
    event_handler = MyHandler()
    observer = Observer()

    # Watch the 'src' directory for changes
    observer.schedule(event_handler, path=ABSOLUTE_SRC_DIR_PATH, recursive=True)

    observer.start()
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()