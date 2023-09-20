#!/bin/bash

# Die Spalte, nach der sortiert werden soll (hier ersetzen durch den gewünschten Spaltennamen)
target_column="1"

# Schleife über alle Ordner im aktuellen Verzeichnis
for benchmark_folder in ./*benchmark*/; do
    if [ -d "$benchmark_folder" ]; then
       echo "Wechsel in $benchmark_folder..."

        # Wechsle in den Benchmark-Ordner
        cd "$benchmark_folder"

        # Lösche alle Dateien mit "sorted" oder "temp" im Namen im aktuellen Verzeichnis
        rm -f ./*sorted* ./*temp* ./*Benchmark* ./*benchmark* ./*plot* ./*png*

        echo "Gelöschte temporäre Dateien in $benchmark_folder."

        # Schleife über alle CSV-Dateien im aktuellen Benchmark-Ordner
        for csv_file in ./*.csv; do
            # Überprüfen, ob die Datei existiert und eine reguläre Datei ist
            if [ -f "$csv_file" ]; then
                # Extrahiere den Dateinamen ohne Erweiterung
                filename_no_extension=$(basename "$csv_file" .csv)

                # Öffne die CSV-Datei, führe Ersetzungen durch und speichere sie in einer temporären Datei
                # sed 's/\("\([^"]\+\),\([^"]\+\)"\)/\1.\2/g; s/_t1"/_t001"/g; s/_t2"/_t002"/g; s/_t4"/_t004"/g; s/_t8"/_t008"/g; s/_t16"/_t016"/g; s/_t32"/_t032"/g; s/_t64"/_t064"/g' "$csv_file" > "$filename_no_extension-temp.csv"
                sed 's/_t1"/_t001"/g; s/_t2"/_t002"/g; s/_t4"/_t004"/g; s/_t8"/_t008"/g; s/_t16"/_t016"/g; s/_t32"/_t032"/g; s/_t64"/_t064"/g' "$csv_file" > "$filename_no_extension-temp.csv"

                # Sortiere die CSV-Datei nach der angegebenen Spalte und speichere sie in eine temporäre Datei
                sort -t, -k"$target_column" -o "$filename_no_extension-sorted.csv" "$filename_no_extension-temp.csv"

                # sed 's/,1,"/;1;"/g; s/,2,"/;2;"/g; s/,3,"/;3;"/g; s/,4,"/;4;"/g; s/,5,"/;5;"/g; s/,6,"/;6;"/g; s/,7,"/;7;"/g; s/,8,"/;8;"/g; s/,9,"/;9;"/g; s/,10,"/;10;"/g; s/","/;/g; s/,"/;/g; s/",/;/g; s/"//g; s/,/./g; ' "$filename_no_extension-sorted.csv" > "$filename_no_extension-plot.csv"
                sed 's/,1,"/;1;"/g; s/,2,"/;2;"/g; s/,3,"/;3;"/g; s/,4,"/;4;"/g; s/,5,"/;5;"/g; s/,6,"/;6;"/g; s/,7,"/;7;"/g; s/,8,"/;8;"/g; s/,9,"/;9;"/g; s/,10,"/;10;"/g; s/","/;/g; s/,"/;/g; s/",/;/g; s/"//g; s/,/;/g; ' "$filename_no_extension-sorted.csv" > "$filename_no_extension-plot.csv"

                # Optional: Verschiebe die sortierte Datei zurück in das aktuelle Verzeichnis
                # mv "$filename_no_extension-sorted.csv" ./
            fi
        done

        echo "Sortieren und Speichern in $benchmark_folder abgeschlossen."

        # Die Ausgabedatei, in die alle CSV-Daten zusammengeführt werden
        output_file="Benchmark.csv"

        # Lösche die Ausgabedatei, falls sie bereits existiert
        rm -f "$output_file"

        # Schleife über alle CSV-Dateien im Verzeichnis, die "sorted" im Namen haben
        for csv_file in ./*sorted*.csv; do
            # Überprüfen, ob die Datei existiert und eine reguläre Datei ist
            if [ -f "$csv_file" ]; then
                # Extrahiere den Dateinamen ohne Erweiterung
                filename_no_extension=$(basename "$csv_file" .csv)

                # Füge den Dateinamen als Präfix zu jedem Datensatz hinzu und füge sie in die Ausgabedatei ein
                awk -v prefix="$filename_no_extension" -F ',' '{print prefix "," $0}' "$csv_file" >> "$output_file"
            fi
        done

        echo "CSV-Dateien in $benchmark_folder wurden zu $output_file zusammengeführt und Ersetzungen vorgenommen."

        # Lösche alle Dateien mit "sorted" oder "temp" im Namen im aktuellen Verzeichnis
        rm -f ./*temp*

        echo "Gelöschte temporäre Dateien in $benchmark_folder."

        # Wechsle zurück zum übergeordneten Verzeichnis
        cd ..
    fi
done

echo "Alle CSV-Dateien in Unterordnern mit 'Benchmark' im Namen wurden verarbeitet."
