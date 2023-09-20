package org.dcache.oncrpc4j.benchmarks;

import org.dcache.oncrpc4j.rpc.*;
import org.dcache.oncrpc4j.rpc.net.IpProtocolType;
import org.dcache.oncrpc4j.xdr.XdrAble;
import org.dcache.oncrpc4j.xdr.XdrVoid;
import org.openjdk.jmh.annotations.*;
import org.openjdk.jmh.runner.Runner;
import org.openjdk.jmh.runner.RunnerException;
import org.openjdk.jmh.runner.options.Options;
import org.openjdk.jmh.runner.options.OptionsBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeUnit;

@State(Scope.Benchmark)
@BenchmarkMode(Mode.Throughput)
public class RpcPing {

    private final Logger logger = LoggerFactory.getLogger(RpcPing.class);
    private static final int PROG_NUMBER = 100017;
    private static final int PROG_VERS = 1;
    private static final OncRpcProgram prog = new OncRpcProgram(PROG_NUMBER, PROG_VERS);

    private OncRpcSvc svc;
    private OncRpcClient rpcClient;
    private RpcCall call;

    @Setup
    public void setUp() throws IOException {

        svc = new OncRpcSvcBuilder()
                .withTCP()
                .withoutAutoPublish()
                .withPort(0)
                .withSameThreadIoStrategy()
                .withRpcService(prog, call -> {
                    logger.debug("NFS PING client: {}", call.getTransport().getRemoteSocketAddress());
                    call.reply(XdrVoid.XDR_VOID);
                })
                .build();

        svc.start();

        InetSocketAddress socketAddress = svc.getInetSocketAddress(IpProtocolType.TCP);
        rpcClient = new OncRpcClient(socketAddress, IpProtocolType.TCP);
        RpcTransport transport = rpcClient.connect();
        call = new RpcCall(prog.getNumber(), prog.getVersion(), new RpcAuthTypeNone(), transport);
    }

    @Benchmark
    @Threads(1)
    @Warmup(iterations = 0)
    @Measurement(iterations = 2, time = 2, timeUnit = TimeUnit.SECONDS)
    public XdrAble rpcPingSingle_t001() throws IOException, ExecutionException, InterruptedException {
        return call.call(0, XdrVoid.XDR_VOID, XdrVoid.class).get();
    }

    @Benchmark
    @Threads(2)
    @Warmup(iterations = 0)
    @Measurement(iterations = 2, time = 2, timeUnit = TimeUnit.SECONDS)
    public XdrAble rpcPingSingle_t002() throws IOException, ExecutionException, InterruptedException {
        return call.call(0, XdrVoid.XDR_VOID, XdrVoid.class).get();
    }

    @Benchmark
    @Threads(4)
    @Warmup(iterations = 0)
    @Measurement(iterations = 2, time = 2, timeUnit = TimeUnit.SECONDS)
    public XdrAble rpcPingSingle_t004() throws IOException, ExecutionException, InterruptedException {
        return call.call(0, XdrVoid.XDR_VOID, XdrVoid.class).get();
    }

    @Benchmark
    @Threads(8)
    @Warmup(iterations = 0)
    @Measurement(iterations = 2, time = 2, timeUnit = TimeUnit.SECONDS)
    public XdrAble rpcPingSingle_t008() throws IOException, ExecutionException, InterruptedException {
        return call.call(0, XdrVoid.XDR_VOID, XdrVoid.class).get();
    }

    @Benchmark
    @Threads(16)
    @Warmup(iterations = 0)
    @Measurement(iterations = 2, time = 2, timeUnit = TimeUnit.SECONDS)
    public XdrAble rpcPingSingle_t016() throws IOException, ExecutionException, InterruptedException {
        return call.call(0, XdrVoid.XDR_VOID, XdrVoid.class).get();
    }

    @Benchmark
    @Threads(32)
    @Warmup(iterations = 0)
    @Measurement(iterations = 2, time = 2, timeUnit = TimeUnit.SECONDS)
    public XdrAble rpcPingSingle_t032() throws IOException, ExecutionException, InterruptedException {
        return call.call(0, XdrVoid.XDR_VOID, XdrVoid.class).get();
    }

    @Benchmark
    @Threads(64)
    @Warmup(iterations = 0)
    @Measurement(iterations = 2, time = 2, timeUnit = TimeUnit.SECONDS)
    public XdrAble rpcPingSingle_t064() throws IOException, ExecutionException, InterruptedException {
        return call.call(0, XdrVoid.XDR_VOID, XdrVoid.class).get();
    }

    @Benchmark
    @Threads(128)
    @Warmup(iterations = 0)
    @Measurement(iterations = 2, time = 2, timeUnit = TimeUnit.SECONDS)
    public XdrAble rpcPingSingle_t128() throws IOException, ExecutionException, InterruptedException {
        return call.call(0, XdrVoid.XDR_VOID, XdrVoid.class).get();
    }

    @TearDown
    public void tearDown() throws IOException {
        rpcClient.close();
        svc.stop();
    }

    public static void main(String[] args) throws RunnerException {
        Options opt = new OptionsBuilder()
                .include(RpcPing.class.getSimpleName())
                .build();

        new Runner(opt).run();
    }
}
