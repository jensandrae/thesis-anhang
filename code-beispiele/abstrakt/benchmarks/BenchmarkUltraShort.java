package com.andrae.benchmarks;

import org.openjdk.jmh.annotations.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.concurrent.TimeUnit;

@State(Scope.Thread)
@OutputTimeUnit(TimeUnit.SECONDS)
public class BenchmarkUltraShort {

    private final Logger logger = LoggerFactory.getLogger(Benchmark.class);

    private final int MAGIC_NUMBER = 42;

    @Setup
    public void setup() {
        // Set up any necessary initialization here
        
    }

    @TearDown
    public void teardown() {
        // Clean up resources if needed
    }

    @Benchmark
    @Threads(1)
    @Warmup(iterations = 0)
    @BenchmarkMode(Mode.Throughput)
    @Measurement(iterations = 2, time = 2, timeUnit = TimeUnit.SECONDS)
    public void testThroughput_t1() {
        logger.info("Hello {}!", MAGIC_NUMBER);
    }

    @Benchmark
    @Threads(1)
    @Warmup(iterations = 0)
    @BenchmarkMode(Mode.SingleShotTime)
    @Measurement(iterations = 2, time = 2, timeUnit = TimeUnit.SECONDS)
    public void testSingleShotTime_t1() {
        logger.info("Hello {}!", MAGIC_NUMBER);
    }

    @Benchmark
    @Threads(2)
    @Warmup(iterations = 0)
    @BenchmarkMode(Mode.Throughput)
    @Measurement(iterations = 2, time = 2, timeUnit = TimeUnit.SECONDS)
    public void testThroughput_t2() {
        logger.info("Hello {}!", MAGIC_NUMBER);
    }

    @Benchmark
    @Threads(2)
    @Warmup(iterations = 0)
    @BenchmarkMode(Mode.SingleShotTime)
    @Measurement(iterations = 2, time = 2, timeUnit = TimeUnit.SECONDS)
    public void testSingleShotTime_t2() {
        logger.info("Hello {}!", MAGIC_NUMBER);
    }

    @Benchmark
    @Threads(4)
    @Warmup(iterations = 0)
    @BenchmarkMode(Mode.Throughput)
    @Measurement(iterations = 2, time = 2, timeUnit = TimeUnit.SECONDS)
    public void testThroughput_t4() {
        logger.info("Hello {}!", MAGIC_NUMBER);
    }

    @Benchmark
    @Threads(4)
    @Warmup(iterations = 0)
    @BenchmarkMode(Mode.SingleShotTime)
    @Measurement(iterations = 2, time = 2, timeUnit = TimeUnit.SECONDS)
    public void testSingleShotTime_t4() {
        logger.info("Hello {}!", MAGIC_NUMBER);
    }

    @Benchmark
    @Threads(8)
    @Warmup(iterations = 0)
    @BenchmarkMode(Mode.Throughput)
    @Measurement(iterations = 2, time = 2, timeUnit = TimeUnit.SECONDS)
    public void testThroughput_t8() {
        logger.info("Hello {}!", MAGIC_NUMBER);
    }

    @Benchmark
    @Threads(8)
    @Warmup(iterations = 0)
    @BenchmarkMode(Mode.SingleShotTime)
    @Measurement(iterations = 2, time = 2, timeUnit = TimeUnit.SECONDS)
    public void testSingleShotTime_t8() {
        logger.info("Hello {}!", MAGIC_NUMBER);
    }

    @Benchmark
    @Threads(16)
    @Warmup(iterations = 0)
    @BenchmarkMode(Mode.Throughput)
    @Measurement(iterations = 2, time = 2, timeUnit = TimeUnit.SECONDS)
    public void testThroughput_t16() {
        logger.info("Hello {}!", MAGIC_NUMBER);
    }

    @Benchmark
    @Threads(16)
    @Warmup(iterations = 0)
    @BenchmarkMode(Mode.SingleShotTime)
    @Measurement(iterations = 2, time = 2, timeUnit = TimeUnit.SECONDS)
    public void testSingleShotTime_t16() {
        logger.info("Hello {}!", MAGIC_NUMBER);
    }

    @Benchmark
    @Threads(32)
    @Warmup(iterations = 0)
    @BenchmarkMode(Mode.Throughput)
    @Measurement(iterations = 2, time = 2, timeUnit = TimeUnit.SECONDS)
    public void testThroughput_t32() {
        logger.info("Hello {}!", MAGIC_NUMBER);
    }

    @Benchmark
    @Threads(32)
    @Warmup(iterations = 0)
    @BenchmarkMode(Mode.SingleShotTime)
    @Measurement(iterations = 2, time = 2, timeUnit = TimeUnit.SECONDS)
    public void testSingleShotTime_t32() {
        logger.info("Hello {}!", MAGIC_NUMBER);
    }

    @Benchmark
    @Threads(64)
    @Warmup(iterations = 0)
    @BenchmarkMode(Mode.Throughput)
    @Measurement(iterations = 2, time = 2, timeUnit = TimeUnit.SECONDS)
    public void testThroughput_t64() {
        logger.info("Hello {}!", MAGIC_NUMBER);
    }

    @Benchmark
    @Threads(64)
    @Warmup(iterations = 0)
    @BenchmarkMode(Mode.SingleShotTime)
    @Measurement(iterations = 2, time = 2, timeUnit = TimeUnit.SECONDS)
    public void testSingleShotTime_t64() {
        logger.info("Hello {}!", MAGIC_NUMBER);
    }

    @Benchmark
    @Threads(128)
    @Warmup(iterations = 0)
    @BenchmarkMode(Mode.Throughput)
    @Measurement(iterations = 2, time = 2, timeUnit = TimeUnit.SECONDS)
    public void testThroughput_t128() {
        logger.info("Hello {}!", MAGIC_NUMBER);
    }

    @Benchmark
    @Threads(128)
    @Warmup(iterations = 0)
    @BenchmarkMode(Mode.SingleShotTime)
    @Measurement(iterations = 2, time = 2, timeUnit = TimeUnit.SECONDS)
    public void testSingleShotTime_t128() {
        logger.info("Hello {}!", MAGIC_NUMBER);
    }
}
