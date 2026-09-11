# Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

function copy --description 'cp, but trims a trailing slash on a directory source (cp DIR1/ DIR2 copies contents, not DIR1 itself)'
    set -l count (count $argv)
    if test "$count" = 2; and test -d "$argv[1]"
        set -l from (string trim-right -c / -- $argv[1])
        set -l to $argv[2]
        command cp -r $from $to
    else
        command cp $argv
    end
end
