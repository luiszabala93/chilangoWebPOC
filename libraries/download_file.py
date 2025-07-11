import os
import time
from pathlib import Path
from robot.api.deco import keyword

@keyword("Wait For Any Download")
def wait_for_any_download(directory, timeout=30, min_size_kb=1):
    folder = Path(directory)
    temp_exts = {'.crdownload', '.part', '.download'}
    end_time = time.time() + timeout

    while time.time() < end_time:
        files = [f for f in folder.iterdir() if f.is_file()]
        complete_files = [
            f for f in files
            if f.suffix.lower() not in temp_exts and f.stat().st_size >= min_size_kb * 1024
        ]

        if complete_files:
            latest_file = max(complete_files, key=lambda f: f.stat().st_mtime)
            return str(latest_file.resolve())

        time.sleep(0.5)

    raise TimeoutError(f"No se descargó ningún archivo válido en {directory} dentro de {timeout}s.")
