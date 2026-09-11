# Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

function mkcd --description 'Create a directory (and parents) then cd into it' --argument dir
    if test -z "$dir"
        echo "usage: mkcd <directory>" >&2
        return 1
    end
    mkdir -p -- $dir; and cd -- $dir
end
