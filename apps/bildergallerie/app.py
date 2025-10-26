from flask import Flask, render_template, send_file, request
import os
from pathlib import Path

app = Flask(__name__)
IMAGE_FOLDER = os.environ.get('IMAGE_FOLDER', '/pictures')  # Aus Umgebungsvariable
GALLERY_TITLE = os.environ.get('GALLERY_TITLE', 'Gallery')  # Titel aus Umgebungsvariable
ALLOWED_EXTENSIONS = {'.jpg', '.jpeg', '.png', '.gif', '.webp', '.bmp'}

# Prüfe ob der Bildordner existiert
if not os.path.exists(IMAGE_FOLDER):
    print(f"WARNUNG: Bildordner '{IMAGE_FOLDER}' nicht gefunden!")
    print("Setze die Umgebungsvariable IMAGE_FOLDER oder stelle sicher, dass der Ordner existiert.")
else:
    print(f"Bildordner: {IMAGE_FOLDER}")

def get_images(folder):
    images = []
    for root, dirs, files in os.walk(folder):
        for file in files:
            if Path(file).suffix.lower() in ALLOWED_EXTENSIONS:
                rel_path = os.path.relpath(os.path.join(root, file), IMAGE_FOLDER)
                images.append(rel_path.replace('\\', '/'))
    return sorted(images)

def sort_items(items, _current_path, sort_by):
    """Sortiert Bilder und Ordner nach Namen auf- oder absteigend"""
    def get_sort_key(item):
        return item.lower()

    return sorted(items, key=get_sort_key, reverse=(sort_by == 'name_desc'))

@app.route('/')
@app.route('/<path:subfolder>')
def gallery(subfolder=''):
    sort_by = request.args.get('sort', 'name_asc')  # Standard: nach Name aufsteigend
    if sort_by not in {'name_asc', 'name_desc'}:
        sort_by = 'name_asc'

    current_path = os.path.join(IMAGE_FOLDER, subfolder)
    if not os.path.exists(current_path):
        return "Ordner nicht gefunden", 404

    # Bilder im aktuellen Ordner
    images = []
    subfolders = []

    try:
        for item in os.listdir(current_path):
            item_path = os.path.join(current_path, item)
            if os.path.isdir(item_path):
                subfolders.append(item)
            elif Path(item).suffix.lower() in ALLOWED_EXTENSIONS:
                images.append(os.path.join(subfolder, item).replace('\\', '/') if subfolder else item)
    except PermissionError:
        return "Keine Berechtigung", 403

    # Sortieren
    images = sort_items([img.split('/')[-1] for img in images], subfolder, sort_by)
    images = [os.path.join(subfolder, img).replace('\\', '/') if subfolder else img for img in images]

    subfolders = sort_items(subfolders, subfolder, sort_by)

    return render_template('gallery.html',
                         images=images,
                         subfolders=subfolders,
                         current_path=subfolder,
                         current_sort=sort_by,
                         gallery_title=GALLERY_TITLE,
                         parent_path='/'.join(subfolder.split('/')[:-1]) if subfolder and '/' in subfolder else '' if subfolder else None)

@app.route('/image/<path:filename>')
def serve_image(filename):
    return send_file(os.path.join(IMAGE_FOLDER, filename))

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080, debug=True)
