source cleaner_utils.sh

no_file_msg="File does not exist"
no_read_msg="You don't have permission to read the file"

read -p "Provide path to file: " file_path

check_if_file_exists "$file_path" "$no_file_msg"
exit_if_error

check_if_file_can_be_read "$file_path" "$no_read_msg"
exit_if_error

cat "$file_path" | sed 's/^ *//g' | sed 's/ \{2,\}/ /g'
