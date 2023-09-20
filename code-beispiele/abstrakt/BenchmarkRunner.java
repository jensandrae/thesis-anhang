package com.andrae;

import org.openjdk.jmh.results.format.ResultFormatType;
import org.openjdk.jmh.runner.Runner;
import org.openjdk.jmh.runner.RunnerException;
import org.openjdk.jmh.runner.options.ChainedOptionsBuilder;
import org.openjdk.jmh.runner.options.Options;
import org.openjdk.jmh.runner.options.OptionsBuilder;

public class BenchmarkRunner {

    public static void main(String[] args) throws RunnerException {
        String benchmarkClassName;
        String benchmarkName = "benchmark"; // Standardwert für benchmarkName

        // Überprüfe die Argumente und setze den Benchmark-Klassennamen und benchmarkName entsprechend
        if (args.length > 0) {
            String argument = args[0];
            switch (argument) {
                case "s":
                    benchmarkClassName = "BenchmarkShort";
                    break;
                case "us":
                    benchmarkClassName = "BenchmarkUltraShort";
                    break;
                case "n":
                    benchmarkClassName = "BenchmarkNormal";
                    break;
                default:
                    // Ausgabe einer Fehlermeldung für ungültiges Argument
                    System.err.println("Ungültiges Argument. Verwenden Sie 's' für Short, 'us' für UltraShort oder 'n' für Normal.");
                    return;
            }

            // Wenn das zweite Argument (benchmarkName) vorhanden ist, setzen Sie den benchmarkName entsprechend
            if (args.length > 1) {
                benchmarkName = args[1];
            }
        } else {
            benchmarkClassName = "BenchmarkUltraShort"; // Standardauswahl, wenn keine Argumente vorhanden sind
        }

        // Erzeuge den vollständigen Pfad zur ausgewählten Benchmark-Klasse
        String benchmarkClassPath = "com.andrae.benchmarks." + benchmarkClassName;

        // Entsprechend des ausgewählten Benchmarks die Anzahl der Forks einstellen
        int forkCount =  1;
        if ("BenchmarkNormal".equals(benchmarkClassName)) {
            forkCount = 5;
        } else if ("BenchmarkShort".equals(benchmarkClassName)) {
            forkCount = 2;
        }

        // Konfiguriere JMH-Optionen für die Benchmarks
        ChainedOptionsBuilder optionsBuilder = new OptionsBuilder()
                .include(".*" + benchmarkClassPath + ".*")
                // Verwenden Sie benchmarkName für den Dateinamen des Ergebnisses
                .resultFormat(ResultFormatType.CSV)
                .result(benchmarkName + ".csv")
                .forks(forkCount);

        Options options = optionsBuilder.build();

        // Gib den Namen des ausgeführten Benchmarks auf der Konsole aus
        System.out.println("-----------------------------------------------");
        System.out.println("Führe Benchmark aus: " + benchmarkClassName);
        System.out.println("Benchmark Name: " + benchmarkName);
        System.out.println("-----------------------------------------------");

        // Führe die ausgewählten Benchmarks aus
        new Runner(options).run();
    }
}
