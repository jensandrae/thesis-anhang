#!/bin/bash

# Schleife über alle Ordner im aktuellen Verzeichnis
for benchmark_folder in ./*benchmark*/; do
    if [ -d "$benchmark_folder" ]; then
       echo "Wechsel in $benchmark_folder..."

        # Wechsle in den Benchmark-Ordner
        cd "$benchmark_folder"

        # Lösche alle Dateien mit "sorted" oder "temp" im Namen im aktuellen Verzeichnis
        rm -f ./*sorted* ./*temp* ./*Benchmark* ./*benchmark* ./*png* ./*plot*

        echo "Gelöschte temporäre Dateien in $benchmark_folder."

        # Wechsle zurück zum übergeordneten Verzeichnis
        cd ..
    fi
done

echo "Alle Dateien in Unterordnern mit './*sorted* ./*temp* ./*Benchmark* ./*benchmark* ./*png*' im Namen wurden gelöscht."
