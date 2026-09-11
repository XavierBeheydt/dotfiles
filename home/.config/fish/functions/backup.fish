# Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

function backup --description 'Copy a file to <file>.bak' --argument filename
    cp $filename $filename.bak
end
