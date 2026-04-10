package com.adilhanney.no_more_background;

import androidx.annotation.Keep;
import androidx.annotation.NonNull;
import androidx.core.util.Pair;

import com.topjohnwu.superuser.Shell;

@Keep
public abstract class RootShellUtil {
    @SuppressWarnings("unused")
    public static boolean isRooted() {
        final var result = run("su echo hello world");
        return result.first == 0;
    }

    @NonNull
    public static Pair<Integer, String> run(@NonNull String command) {
        final Shell.Result result = Shell.cmd(command).exec();
        final var code = result.getCode();
        return new Pair<>(code, join(code == 0 ? result.getOut() : result.getErr()));
    }

    @NonNull
    private static String join(@NonNull java.util.List<String> strings) {
        return String.join("\n", strings);
    }
}
