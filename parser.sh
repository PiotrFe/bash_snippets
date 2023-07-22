source utils.sh

report_dir="reports"
dest_dir="data"

function ask_reports_dir() {
    local dir_name 
    
    read -p "Please provide path to report folder [default: 'reports']: " dir_name 

    if [[ "$dir_name" != "" ]]
    then
        report_dir="$dir_name"
    fi
} 

function check_if_source_dir_valid() {
    if [[ "$report_dir" = "" ]] 
    then
        echo "Invalid path"
        exit 1
    elif [ ! -d $report_dir ]
    then   
        echo "Path does not exist"
        exit 1
    elif [ ! -r $report_dir ]
    then   
        echo "You don't have permission to access the folder"
        exit 1
    fi
}

function check_if_source_dir_empty() {
    local file_count=$(ls "$report_dir" | wc -l)

    if [ $file_count -eq 0 ]
    then
        echo "The source folder is empty"
        exit 1
    fi
}

function ask_dest_dir() {
    local dir_name 
    read -p "Where would you like to store the file? [default: 'data']" dir_name 

    if [[ "$dir_name" != "" ]]
    then
        dest_dir="$dir_name"
    fi
}

function check_if_report_dir_valid() {
    if [ "$dest_dir" = "" ] 
    then
        echo "Invalid path"
        exit 1
    elif [ ! -d $dest_dir ]
    then
        ask_create_dir

        local do_create=$?

        if [ $do_create -eq 0 ]
        then
            mkdir $dest_dir
        else
            exit 0
        fi
    fi
}

function display_processing_message() {
    echo "***********"
    find $report_dir -iname "*.csv" -type "f" 2>/dev/null | wc -l | xargs -I {} echo "Found {} csv files. Processing data..."
    echo "***********"
}

function parse_report_data() {
    display_processing_message
    
    today_date=$(date +"%Y-%m-%m")
    file_name="${dest_dir}/${today_date}.csv"
    header=$(ls "$report_dir/*.csv" | head -n 1 | xargs head -n 1)

    echo "$header" > "$filename"

    find $report_dir -iname "*.csv" -type "f" 2>/dev/null | xargs tail -n +2 | grep -v "==>" | sort -n -t "," -k 5 -r >> "${file_name}"
}

ask_reports_dir
check_if_source_dir_valid
check_if_source_dir_empty
ask_dest_dir
check_if_report_dir_valid
parse_report_data