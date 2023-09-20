#!/bin/bash

# Funktion zum Verschieben von PNG-Dateien in den Zielordner
move_png_files() {
    # Zielordner definieren
    target_folder="gnuplot_png"

    # Prüfen, ob der Zielordner bereits existiert
    if [ -d "$target_folder" ]; then
        echo "Der Zielordner '$target_folder' existiert bereits."
    else
        # Den Zielordner erstellen, wenn er nicht existiert
        mkdir "$target_folder"
        echo "Der Zielordner '$target_folder' wurde erstellt."
    fi

    # Überprüfen, ob .png-Dateien vorhanden sind
    if ls *.png 1>/dev/null 2>&1; then
        # .png-Dateien vorhanden, verschieben
        mv *.png "$target_folder/"
        echo "Alle .png-Dateien wurden in den Zielordner '$target_folder' verschoben."
    else
        # Keine .png-Dateien gefunden
        echo "Keine .png-Dateien im aktuellen Verzeichnis vorhanden."
    fi
}

# Verzeichnisliste aller Unterordner mit "benchmark" im Namen
benchmark_folders=$(find . -maxdepth 1 -type d -name '*benchmark*')

# Überprüfen, ob Unterordner gefunden wurden
if [ -z "$benchmark_folders" ]; then
    echo "Keine Ordner mit 'benchmark' im Namen gefunden."
else
    # Schleife über jeden gefundenen Ordner
    for folder in $benchmark_folders; do
        # In den Ordner wechseln
        cd "$folder"
        echo "Wechsel in $folder"

        # PNG-Dateien in den Zielordner verschieben
        move_png_files

        # Zurück zum übergeordneten Ordner
        cd ..
        echo "Wechsel zurück in übergeordnetes Verzeichnis."
    done
fi
