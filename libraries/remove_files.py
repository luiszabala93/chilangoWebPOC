import glob
import os

file = 'results'
pattern = os.path.join(file, '*.png')
pattern2 = os.path.join(file, '*.webm')  

def remove_files():
    for filename in glob.glob(pattern):
        try:
            os.remove(filename)
            print(f"Removed file: {filename}")
        except Exception as e:
            print(f"Error removing file {filename}: {e}")

    for filename in glob.glob(pattern2):
        try:
            os.remove(filename)
            print(f"Removed file: {filename}")
        except Exception as e:
            print(f"Error removing file {filename}: {e}")


