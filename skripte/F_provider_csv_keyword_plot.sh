#!/bin/bash

# Verzeichnis für die Ausgabedateien
output_dir="provider_csv_keyword_plot"

# Vorhandenes Ausgabeverzeichnis löschen, wenn es existiert
if [ -d "$output_dir" ]; then
  rm -r "$output_dir"
  echo "Das vorhandene Ausgabeverzeichnis '$output_dir' wurde gelöscht."
fi

# Liste der Keywords in gewünschter Reihenfolge
keywords=("async-buf-cam" "async-buf-coco-1" "async-buf-coco-2" "async-buf-dle" "async-buf-nci" "syn-unbuf-cam" "syn-unbuf-coco-1" "syn-unbuf-coco-2" "syn-unbuf-dle" "syn-unbuf-nci")

# Reihenfolge der Keywords für die Sortierung festlegen
sort_order=("_t001" "_t002" "_t004" "_t008" "_t016" "_t032" "_t064" "_t128")

# Eingabedatei
input_file="Benchmark.csv"

# Ausgabeverzeichnis neu erstellen
mkdir -p "$output_dir"

# Schleife durch die Keywords
for keyword in "${keywords[@]}"; do
  # Schleife durch die Modi
  for mode in "testSingleShotTime" "testThroughput"; do
    # Ausgabedatei im Ausgabeverzeichnis erstellen
    output_file="${output_dir}/${keyword}-${mode}.csv"

    echo "Datei '$output_file' wird erstellt und Inhalt wird bereinigt."

    # Zeilen mit dem Keyword und Modus aus der Eingabedatei in die Ausgabedatei kopieren und den String "-sorted" entfernen
    # grep "$keyword" "$input_file" | grep "$mode" | sed 's/-sorted//' | sed 's/,1,"/;1;"/g; s/,2,"/;2;"/g; s/,3,"/;3;"/g; s/,4,"/;4;"/g; s/,5,"/;5;"/g; s/,6,"/;6;"/g; s/,7,"/;7;"/g; s/,8,"/;8;"/g; s/,9,"/;9;"/g; s/,10,"/;10;"/g; s/","/;/g; s/,"/;/g; s/",/;/g; s/"//g; s/,/./g' > "$output_file"
    grep "$keyword" "$input_file" | grep "$mode" | sed 's/-sorted//' | sed 's/,1,"/;1;"/g; s/,2,"/;2;"/g; s/,3,"/;3;"/g; s/,4,"/;4;"/g; s/,5,"/;5;"/g; s/,6,"/;6;"/g; s/,7,"/;7;"/g; s/,8,"/;8;"/g; s/,9,"/;9;"/g; s/,10,"/;10;"/g; s/","/;/g; s/,"/;/g; s/",/;/g; s/"//g; s/,/;/g' > "$output_file"
    echo "Inhalt der Datei '$output_file' wurde hinzugefügt und bereinigt."

    # Header am Ende der Datei hinzufügen
    echo "Logging-Provider;Benchmark;Mode;Threads;Samples;Score;Score Error (99,9%);Unit" >> "$output_file"
    echo "Header am Ende der Datei '$output_file' wurde hinzugefügt."
  done
done

# Alle CSV-Dateien im Ausgabeverzeichnis sortieren gemäß der sort_order
for sort_key in "${sort_order[@]}"; do
  for keyword in "${keywords[@]}"; do
    for mode in "testSingleShotTime" "testThroughput"; do
      input_file="${output_dir}/${keyword}-${mode}.csv"
      output_file="${output_dir}/${keyword}-${mode}.sorted.csv"
      grep "$sort_key" "$input_file" >> "$output_file"
    done
  done
done

# Umbenennen der sortierten Dateien, um die ursprünglichen Dateien zu ersetzen
for keyword in "${keywords[@]}"; do
  for mode in "testSingleShotTime" "testThroughput"; do
    input_file="${output_dir}/${keyword}-${mode}.sorted.csv"
    output_file="${output_dir}/${keyword}-${mode}.csv"
    mv "$input_file" "$output_file"
  done
done

echo "Alle Dateien wurden erstellt, der Inhalt wurde im Ordner '$output_dir' gemäß der Sortierreihenfolge sortiert und bereinigt."
