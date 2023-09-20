package org.dcache.oncrpc4j.benchmarks;

import org.openjdk.jmh.results.format.ResultFormatType;
import org.openjdk.jmh.runner.Runner;
import org.openjdk.jmh.runner.RunnerException;
import org.openjdk.jmh.runner.options.Options;
import org.openjdk.jmh.runner.options.OptionsBuilder;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

public class BenchMarkRunnerCSV {

    public static void main(String[] args) throws RunnerException, IOException {
        List<String> benchmarkClasses = Arrays.asList(
                RpcPing.class.getSimpleName(),
                TlsOverhead.class.getSimpleName(),
                XdrBenchmark.class.getSimpleName()
        );

        Options opt = new OptionsBuilder()
                .include(Arrays.toString(benchmarkClasses.stream().toArray(String[]::new)))
                .resultFormat(ResultFormatType.CSV)
                .result("oncrpc4j-master-logback-async-buf-cam-console.csv")
                .forks(2)
                .build();

        new Runner(opt).run();
    }
}
