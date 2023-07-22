function ask_create_dir {
    local create_dir=""

    read -p "Directory does not exist. Create? (y/n) " create_dir

    while true
    do
        if [[ "$create_dir" != [Yy] && "$create_dir" != [Nn] ]]
        then
            read -p "Directory does not exist. Create? (y/n) " create_dir
        elif [[ "$create_dir" == [Nn] ]]
        then
            return 1
        elif [[ "$create_dir" == [Yy] ]]
        then
            return 0
        fi
    done
}

