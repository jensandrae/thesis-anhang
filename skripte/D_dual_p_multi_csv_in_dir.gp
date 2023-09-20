# Löscht alle PNG-Dateien im aktuellen Verzeichnis
system("rm *.png")
print "Alle PNG-Dateien im aktuellen Verzeichnis wurden gelöscht."

# Setzt das Ausgabeformat auf PNG (oder ein anderes Format deiner Wahl)
set terminal pngcairo enhanced font "arial,10" size 800,600

# Definiert die Datenquelle und das Trennzeichen im CSV-Dateiformat
set datafile separator ';'

# Suche nach CSV-Dateien mit "plot" im Dateinamen
file_list = system("ls | grep plot")
file_count = words(file_list)

# Wenn mindestens eine CSV-Datei gefunden wurde
if (file_count > 0) {
    print "Folgende CSV-Dateien wurden im aktuellen Verzeichnis gefunden:"

    # Schleife über jede gefundene CSV-Datei
    do for [i = 1:file_count] {
        datafile = word(file_list, i)

        # Extrahiere den Dateinamen ohne Erweiterung
        filename = system("basename " . datafile . " .csv")

        print 'Starte Bearbeitung von ' . datafile

        # --------------------------------------------------------------------------------------------
        # --------------------- Plotten: Style & Vorbereitung X-Achse - Threads  ---------------------

        set boxwidth 0.7 absolute

        # Setzt die Fillstyle-Einstellung auf "solid" mit einer grünen Füllung.
        set style fill solid 0.1 border lc rgb "#000000"

        # Ändert die Linienfarbe für den Rand der Balken auf Schwarz.
        set style line 1 lc rgb "#00CC00"

        # Setzt die X-Achsen-Beschriftungen
        set xtics ("1" 1, "2" 2, "4" 3, "8" 4, "16" 5, "32" 6, "64" 7, "128" 8) nomirror
        set xlabel "Threads"

        # --------------------------------------------------------------------------------
        # --------------------- Plotten: Tabelle Teil 1 - ss - ms/op ---------------------

        # Setzt den Titel des Diagramms
        set title filename . ' testSingleShotTime'

        # Setzt den Ausgabepfad und Dateinamen für das PNG für Zeilen 2-9
        set output filename . '-ss.png'

        # Setzt die Y-Achsen-Beschriftung auf "ms/op"
        set ylabel "ms/op"

        # Plotte das Balkendiagramm für Zeilen 2-9
        plot datafile every ::1::8 using ($0+1):5 with boxes notitle, '' every ::1::8 using ($0+1):5:5 with labels offset 0,1 rotate by 0 notitle

        print filename . '-ss.png - Wurde erstellt.'

        # ------------------------------------------------------------------------------------
        # --------------------- Plotten: Tabelle Teil 2 - thrpt - ops/ms ---------------------

        # Setzt den Titel des Diagramms
        set title filename . ' testThroughput'

        # Setzt den Ausgabepfad und Dateinamen für das PNG für Zeilen 10-17
        set output filename . '-thrpt.png'

        # Setzt die Y-Achsen-Beschriftung auf "ops/ms"
        set ylabel "ops/ms"

        # Plotte das Balkendiagramm für Zeilen 10-17
        plot datafile every ::9::16 using ($0+1):5 with boxes notitle, '' every ::9::16 using ($0+1):5:5 with labels offset 0,1 rotate by 0 notitle

        print filename . '-thrpt.png - Wurde erstellt.'

        # ------------------------------------------------------------------------------------

        print 'Bearbeitung von ' . datafile . ' abgeschlossen'
        print '------------------------------------------------'
    }
} else {
    print 'Keine passenden CSV-Dateien im aktuellen Verzeichnis gefunden.'
}

# Beende die Gnuplot-Ausgabe
unset output
