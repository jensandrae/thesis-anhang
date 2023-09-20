# Alle vorhandenen PNG-Dateien im Verzeichnis löschen
system("rm -f *.png")

# Alle vorhandenen PNG-Dateien im Verzeichnis löschen
system("rm -f *.tmp")

# Ausgabeformat für das Diagramm einstellen
set terminal pngcairo size 800,600

# CSV-Dateien im Ordner auflisten, die "multi" im Namen haben
file_list = system("ls *multi*.csv")

# Schleife, um das Skript für jede CSV-Datei im Ordner auszuführen
do for [filename in file_list] {
    # Den Ausgabedateinamen festlegen
    output_filename = "multi-" . filename . ".png"
    set output output_filename

    # Header der CSV-Datei auslesen, um die Provider-Namen zu erhalten
    stats filename using 1 nooutput

    # Die Daten einlesen und als Clustered Bar Graph darstellen
    set datafile separator ";"
    set style data histograms
    set style histogram cluster gap 1
    set style fill solid border -1
    set boxwidth 0.8

    # Die Legende hinzufügen
    set key top left

    # Die Farben für die Balken festlegen (dezente Grüntöne)
    green_shades = "#75DDDD #508991 #2F5E85 #004346 #09BC8A"

    # Titel auf den Namen der CSV-Datei setzen
    set title filename

    # Hier wird überprüft, ob der Dateiname "ss" oder "thrpt" enthält, und entsprechend die Achsenbeschriftungen festgelegt
    if (strstrt(filename, "testSingleShotTime") > 0) {
        set xlabel "Threads"
        set ylabel "ms/op"
    }

    if (strstrt(filename, "testThroughput") > 0) {
        set xlabel "Threads"
        set ylabel "ops/ms"
    }

    # Das Skript für die aktuelle CSV-Datei ausführen, wobei die Anbieter-Namen dynamisch aus dem Header verwendet werden
    plot for [i=2:*] filename using i:xtic(1) title columnheader(i) lc rgb word(green_shades, i-1)

    # Grafik speichern
    set output
}
