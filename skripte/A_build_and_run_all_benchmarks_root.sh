#!/bin/bash

# Hauptmodule und gültige Präfixe
main_modules=("bench-slf4j-xnop" "bench-slf4j-jul" "bench-slf4j-logback" "bench-slf4j-tinylog-2" "bench-slf4j-log4j-2")
# valid_prefixes=("tinylog")
valid_prefixes=("log4j" "jul" "logback" "tinylog" "xno")

# Option zur Steuerung der JAR-Ausführung
enable_jar_execution=true

# Option zur Steuerung des "Bench Modes"
# us - Ultra Short  - je App ca. 10 sekunden
# s  - Short        - je App ca. 5 Minuten
# n  - Normal       - je App ca. 1 Stunde
bench_mode="s"

# Funktion zur Bereinigung des Benchmarks-Ordners
bench_folder_cleanup() {
  echo "============================================"
  echo "Benchmarks (.csv) werden in einen eigenen Ordner verschoben."

  # Erstelle einen Ordner mit Datum und Uhrzeit
  timestamp=$(date "+%d-%m-%Y-@%H-%M-%S")
  folder_name="old_benchmarks_$timestamp"
  mkdir "$folder_name"

  # Kopiere alle CSV-Dateien in den erstellten Ordner
  find . -name "*.csv" -exec mv {} "$folder_name" \;
  echo "Benchmarks (.csv) wurden verschoben."
}

# Benchmarks-Ordner aufräumen
bench_folder_cleanup

# Funktion zur Verarbeitung von Unterordnern
process_subfolder() {
  echo "============================================"
  local folder="$1"
  for subfolder in "$folder"/*; do
    if [ -d "$subfolder" ]; then
      local subfolder_name="$(basename "$subfolder")"
      local prefix="${subfolder_name%%-*}" # Extrahiert das Präfix

      if [[ " ${valid_prefixes[*]} " =~ ${prefix} ]]; then
        echo "Verarbeite Untermodul: $subfolder"

        # mvn clean package für den Unterordner ausführen
        (cd "$subfolder" && mvn clean package -Dmaven.test.skip=true)
        # (cd "$subfolder" && mvn clean package)

        # Überprüfen, ob es einen 'target'-Ordner gibt
        if [ -d "$subfolder/target" ]; then
          cd "$subfolder/target" || { echo "Kein 'target'-Ordner in $subfolder gefunden."; continue; }

          # Alle JAR-Dateien ohne 'original' im Namen ausführen
          for jar_file in *.jar; do
            if [[ "$jar_file" != *original* ]] && [ "$enable_jar_execution" = true ]; then
              echo "JAR-Datei namens $jar_file gefunden."
              echo "Führe JAR-Datei aus: $jar_file"
              java -jar "$jar_file" "$bench_mode" "$subfolder"
              break # Nur die erste passende JAR-Datei ausführen
            fi
          done

          # Zurück zum vorherigen Verzeichnis
          cd - > /dev/null
        else
          echo "'target'-Ordner nicht in $subfolder vorhanden."
        fi
      fi
    fi
  done
}

# Hauptmodule durchlaufen
for main_module in "${main_modules[@]}"; do
  if [ -d "$main_module" ]; then
    echo "============================================"
    echo "===== In Modul: $main_module ====="

    # In das Hauptmodul wechseln
    cd "$main_module" || { echo "Hauptmodul $main_module nicht gefunden."; continue; }

    # Unterordner im Hauptmodul verarbeiten
    process_subfolder "."

    # Zurück zum übergeordneten Verzeichnis
    cd ..
  else
    echo "Hauptmodul $main_module nicht gefunden."
  fi
done

# Benchmarks-Ordner aufräumen
bench_folder_cleanup

# Abschluss
echo "============================================"
echo "Done."
