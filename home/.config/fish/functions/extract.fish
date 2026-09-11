# Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

function extract --description 'Extract an archive based on its extension' --argument file
    if not test -f "$file"
        echo "extract: '$file' is not a valid file" >&2
        return 1
    end

    switch (string lower -- $file)
        case '*.tar.bz2' '*.tbz2'
            tar xvjf $file
        case '*.tar.gz' '*.tgz'
            tar xvzf $file
        case '*.tar.xz' '*.txz'
            tar xvJf $file
        case '*.tar'
            tar xvf $file
        case '*.bz2'
            bunzip2 $file
        case '*.rar'
            unrar x $file
        case '*.gz'
            gunzip $file
        case '*.zip'
            unzip $file
        case '*.7z'
            7z x $file
        case '*'
            echo "extract: don't know how to extract '$file'" >&2
            return 1
    end
end
