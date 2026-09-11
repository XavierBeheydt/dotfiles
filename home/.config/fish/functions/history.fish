# Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

function history --description 'Fish history with pager and colored, timestamped output'
    set -l cmd search
    set -l known_cmds search delete merge save clear clear-session append
    if set -q argv[1]; and contains -- $argv[1] $known_cmds
        set cmd $argv[1]
        set -e argv[1]
    end

    switch $cmd
        case search
            if isatty stdout
                builtin history search --show-time='%F %T ' --color=always $argv | eval (__fish_anypager) -R
            else
                builtin history search --show-time='%F %T ' $argv
            end
        case '*'
            builtin history $cmd $argv
    end
end
