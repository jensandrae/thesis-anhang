#!/bin/bash

# Verzeichnis für die Ausgabedateien
output_dir="provider_csv_keyword_plot_cleaned"

# Vorhandenes Ausgabeverzeichnis löschen, wenn es existiert
if [ -d "$output_dir" ]; then
  rm -r "$output_dir"
  echo "Das vorhandene Ausgabeverzeichnis '$output_dir' wurde gelöscht."
fi

# Liste der Keywords in gewünschter Reihenfolge
keywords=("async-buf-cam" "async-buf-coco-1" "async-buf-coco-2" "async-buf-dle" "async-buf-nci" "syn-unbuf-cam" "syn-unbuf-coco-1" "syn-unbuf-coco-2" "syn-unbuf-dle" "syn-unbuf-nci")

# Eingabedatei
input_dir="provider_csv_keyword_plot"

# Ausgabeverzeichnis neu erstellen
mkdir -p "$output_dir"

# Schleife durch die Keywords
for keyword in "${keywords[@]}"; do
  # Schleife durch die Modi
  for mode in "testSingleShotTime" "testThroughput"; do
    # Eingabe- und Ausgabedateinamen festlegen
    input_file="${input_dir}/${keyword}-${mode}.csv"
    output_file="${output_dir}/${keyword}-${mode}.csv"

    echo "Datei '$output_file' wird erstellt und Inhalt wird bereinigt."

    # Daten aus der Eingabedatei lesen und Spalten 2, 3, 5, 7, 8 entfernen
    awk -F ';' '{print $1 ";" $4 ";" $6}' "$input_file" > "$output_file"

    echo "Inhalt der Datei '$output_file' wurde bereinigt."
  done
done


echo "Alle Dateien wurden bereinigt und sortiert. Die sortierten Dateien befinden sich im Ordner '$output_dir'."
