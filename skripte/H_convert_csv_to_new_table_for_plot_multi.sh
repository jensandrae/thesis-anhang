#!/bin/bash

# Alle Dateien mit "output" im Namen löschen
rm -f *output*.csv
rm -f *multi*.csv
rm -f *sorted*

# Schleife durch alle CSV-Dateien im aktuellen Verzeichnis
for input_file in *.csv; do

  # Prüfen, ob die Datei existiert und eine CSV-Datei ist
  if [ -f "$input_file" ] && [[ "$input_file" == *.csv ]]; then

    # Ausgabedatei mit dem Präfix "-multi.csv" erstellen
    output_file="${input_file%.csv}-multi.csv"

    # Zeilen aus der CSV-Datei lesen
    lines=$(cat "$input_file")

    # Threads initialisieren und sortieren
    threads=$(echo "$lines" | awk -F';' '{print $2}' | sort -n | uniq)

    # Header initialisieren
    header="Threads"

    # Eindeutige "Logger" Namen sammeln und zum Header hinzufügen
    loggers=$(echo "$lines" | awk -F';' '{print $1}' | sort -u)
    for logger in $loggers; do
      header+=";$logger"
    done

    # Header in die Ausgabe-Datei schreiben
    echo "$header" > "$output_file"

    # Threads und Semikolons in die erste Spalte schreiben
    for thread in $threads; do
      line="$thread"
      for logger in $loggers; do
        value=$(echo "$lines" | awk -F';' -v thread="$thread" -v logger="$logger" '$1 == logger && $2 == thread {print $3}')
        line+=";$value"
      done
      echo "$line" >> "$output_file"
    done
  fi
done
