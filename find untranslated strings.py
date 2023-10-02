import os

def process_file(file_path):
    found = False
    with open(file_path, 'r', encoding='utf-8') as file:
        for line in file:
            line = line.strip()
            if not line.startswith("#") and line and line.endswith("="):
                if not found:
                    found = True
                    print("Found in:", file_path)
                print(line)

def find_and_process_files(directory):
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith(".de.tr"):
                full_file_path = os.path.join(root, file)
                #print("Found in:", os.path.abspath(root))
                process_file(full_file_path)

def find_missing_locale_directories(directory):
    for root, dirs, files in os.walk(directory):
        if "locale" in dirs:
            locale_dir = os.path.join(root, "locale")
            locale_files = [f for f in os.listdir(locale_dir) if f.endswith(".de.tr")]
            if not locale_files:
                print("Missing *.de.tr file in:", os.path.abspath(locale_dir))

# Start the search from the current directory
current_directory = os.getcwd()
find_and_process_files(current_directory)
find_missing_locale_directories(current_directory)
