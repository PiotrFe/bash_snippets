function check_if_file_exists {
    local file_name=$1
    local message_to_display=$2

    if [ -z "$file_name" ]
    then
        echo "Usage: Check for file existence"
        return 1
    fi

    if [ ! -f "$file_name" ]
    then
        if [ ! -z "$message_to_display" ]
        then
            echo "$message_to_display"
        fi

        return 1
    fi

    return 0
}

function check_if_file_can_be_read {
    local file_name=$1
    local message_to_display=$2

    if [ ! -r "$file_name" ]
    then
        if [ ! -z "$message_to_display" ]
        then
            echo "$message_to_display"
        fi

        return 1    
    fi

    return 0
}

function exit_if_error {
    if [ $? -eq 1 ] 
    then
        exit 1
    fi
}