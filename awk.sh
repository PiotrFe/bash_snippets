file_name="./reports/Feb.csv"

# AWK command structure
# BEGIN{} /pattern/{command block} END{}
# Command runs on each line of text
#

# Example 1
awk 'BEGIN{printf "mo,name,age,dept,tu\n"} {print}' "$file_name"

echo -e '\n******\n'

# Example 2
awk -v name=peter 'BEGIN{printf "Name = %s", name}'

echo -e '\n******\n'

# Example 3
cat "$file_name" | sed 's/,/ /g' |  awk '{print $1 "\t" $2 "\t" $3}' | sort -t "\t" -n -r -k 3

echo -e '\n******\n'

# Example 4 - Add header in begin, then look for pattern 'tom'
cat "$file_name" | sed 's/,/ /g' |  awk 'BEGIN { printf "Score\tName\tMo\n" } /tom/ { print $3 "\t" $2 "\t" $1 }'

echo -e '\n******\n'

# Example 5 - Count records using cnt variable; it doesn't need to be pre-declared
cat "$file_name" | sed 's/,/ /g' |  awk '{ cnt++ } END { print "Record count = ", cnt }'

echo -e '\n******\n'

# Example 6 - keep only lines longer than 18 chars; no need to add the body block since {print} is always the default
cat "$file_name" | sed 's/,/ /g' |  awk 'length($0) > 18'

echo -e '\n******\n'

# Example 7 - built-in variables

# ARGC - no of arguments
awk 'BEGIN {print "Arguments =", ARGC}' 1 2 3 4 

# ARGV - array storing command line arguments; idx 0 = awk
awk 'BEGIN {
    for (i = 0; i < ARGC - 1; i++) {
        printf "ARGV[%d] = %s\n", i, ARGV[i]
    }
}' 1 2 

# ENVIRON - environmental variables
awk 'BEGIN { print ENVIRON["USER"] }' 

# FILENAME
# awk 'END { print FILENAME }' test.txt # 

# FS - field separator (default is space)
echo "one,two,three,four,five" | awk 'BEGIN { FS = "," } { print $1"\t"$2 } END { printf "Done!\n" }'

# NF - number of fields in the current record
echo -e "one,two\nthree,four,five\nsix,seven,eight,nine" | awk 'BEGIN { FS = "," } {  print NF }'

echo -e '\n******\n'

# NR - number of the current record
echo -e "peter,hr\nmaggie,pd,80\npaul,recruiting,34,sick leave" | awk 'BEGIN { FS = ","; printf "record_no,dept,tu,absence\n" } {  print NR "," $0 }'