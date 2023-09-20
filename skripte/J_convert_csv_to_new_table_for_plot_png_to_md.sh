#!/bin/bash

# README.md-Datei erstellen
readme_datei="multi_plots.md"  # Hier setzen Sie den Dateinamen in eine Variable
echo "## Multi-PNG-Dateien" > "$readme_datei"
echo "" >> "$readme_datei"

# Gibt es PNG-Dateien mit "multi" im Namen?
dateien=$(find . -type f -name "*multi*.png")

# Anzahl der gefundenen Dateien
anzahl_dateien=$(echo "$dateien" | wc -l)

# Schleife durch die gefundenen Dateien, jeweils zwei nebeneinander in README.md schreiben
i=1
while [ $i -le $anzahl_dateien ]; do
  datei1=$(echo "$dateien" | sed -n "${i}p")
  datei2=$(echo "$dateien" | sed -n "$((i+1))p")

  if [ -n "$datei1" ]; then
    echo "![$datei1]($datei1) " >> "$readme_datei"
  fi

  if [ -n "$datei2" ]; then
    echo "![$datei2]($datei2)" >> "$readme_datei"
  fi

  echo "" >> "$readme_datei"

  i=$((i+2))
done

echo "Die README.md-Datei wurde erstellt: $readme_datei"
