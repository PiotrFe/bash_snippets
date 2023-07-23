file_name="./reports/Feb.csv"

# AWK command structure
# BEGIN {} /pattern/ command block{} END {}
# Command runs on each line of text
#

############
# Example 1
############
awk 'BEGIN{printf "mo,name,age,dept,tu\n"} {print}' "$file_name"

echo -e '\n******\n'

############
# Example 2
############
awk -v name=peter 'BEGIN{printf "Name = %s", name}'

echo -e '\n******\n'

############
# Example 3
############
cat "$file_name" | sed 's/,/ /g' |  awk '{print $1 "\t" $2 "\t" $3}' | sort -t "\t" -n -r -k 3

echo -e '\n******\n'

############
# Example 4 - Add header in begin, then look for pattern 'tom'
############
cat "$file_name" | sed 's/,/ /g' |  awk 'BEGIN { printf "Score\tName\tMo\n" } /tom/ { print $3 "\t" $2 "\t" $1 }'

echo -e '\n******\n'

############
# Example 5 - Count records using cnt variable; it doesn't need to be pre-declared
############
cat "$file_name" | sed 's/,/ /g' |  awk '{ cnt++ } END { print "Record count = ", cnt }'

echo -e '\n******\n'

############
# Example 6 - keep only lines longer than 18 chars; no need to add the body block since {print} is always the default
############
cat "$file_name" | sed 's/,/ /g' |  awk 'length($0) > 18'

echo -e '\n******\n'

############
# Example 7 - built-in variables
############

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

# FNR - same as NR, but relative to the current files

# OMFT - output format number; default value is %.6g
awk 'BEGIN { print "OMFT = " OMFT }' 

# OFS - output field separator; default value is space
awk 'BEGIN {print "OFS = " OFS}' | cat -vte

# ORS - output record separator; default value is new line
awk 'BEGIN {print "ORS = " ORS}' | cat -vte

# RLENGTH - represents the length of the string matched by match function
awk 'BEGIN { if (match("One Two Three", "re")) { print RLENGTH } }'

# RS - input record separator; default value is new line
awk 'BEGIN {print "RS = " RS}' | cat -vte

# RSTART -  first position in the string matched by match function.
awk 'BEGIN { if (match("One Two Three", "Thre")) { print RSTART } }'

############
# Example 8 - Operators
############

echo -e '\n******\n'
echo -e 'Arithmetic operators:\n'

awk 'BEGIN { a = 50; b = 20; print "(a + b) =", (a+b) }'
awk 'BEGIN { a = 50; b = 20; print "(a - b) =", (a-b) }'
awk 'BEGIN { a = 50; b = 20; print "(a * b) =", (a*b) }'
awk 'BEGIN { a = 50; b = 20; print "(a / b) =", (a/b) }'
awk 'BEGIN { a = 50; b = 20; print "(a % b) =", (a%b) }'

echo -e '\n******\n'
echo -e 'Increment and decrement operators:\n'

awk 'BEGIN { a = 10; b = ++a; printf "a = %d, b = %d\n", a, b }'
awk 'BEGIN { a = 10; b = --a; printf "a = %d, b = %d\n", a, b }'
awk 'BEGIN { a = 10; b = a++; printf "a = %d, b = %d\n", a, b }'
awk 'BEGIN { a = 10; b = a--; printf "a = %d, b = %d\n", a, b }'

echo -e '\n******\n'
echo -e 'Assignment operators:\n'

awk 'BEGIN { name = "Jerry"; print "My name is", name }'
awk 'BEGIN { c = 10; c += 10; print "Counter = ", c }'
awk 'BEGIN { c = 10; c -= 10; print "Counter = ", c }'
awk 'BEGIN { c = 10; c *= 10; print "Counter = ", c }'
awk 'BEGIN { c = 10; c /= 10; print "Counter = ", c }'
awk 'BEGIN { c = 10; c %= 10; print "Counter = ", c }'

echo -e '\n******\n'
echo -e 'Relational operators:\n'

awk 'BEGIN { a = 10; b = 10; if (a == b) print "a == b" }'
awk 'BEGIN { a = 10; b = 20; if (a != b) print "a != b" }'
awk 'BEGIN { a = 10; b = 20; if (a < b) print "a < b" }'
awk 'BEGIN { a = 20; b = 10; if (a > b) print "a < b" }'

echo -e '\n******\n'
echo -e 'Logical operators:\n'

awk 'BEGIN { num = 5; if (num > 0 && num < 7) printf "%d is within bounds\n", num }'
awk 'BEGIN { num = 5; if (num > 0 || num < 7) printf "%d is within bounds\n", num }'
awk 'BEGIN { name = ""; if (!length(name)) print "name is empty" }'

echo -e '\n******\n'
echo -e 'Ternary operator:\n'

awk 'BEGIN { a = 5; b = 10; (a > b) ? max = a : max = b; print "Max = ", max }'

echo -e '\n******\n'
echo -e 'Strong concatenation operator:\n'

awk 'BEGIN { str1 = "Hello"; str2 = "World"; str3 = str1 " " str2; print str3 }'

echo -e '\n******\n'
echo -e 'Array membership operator:\n'

awk 'BEGIN { arr[0] = 1; arr[1] = 2; arr[2] = 3; for (i in arr) printf "arr[%d] = %d\n", i, arr[i] }'

############
# Example 9 - Regex
############

echo -e '\n******\n'
echo -e 'Regex:\n'

echo -e "cat\nbat\nfun\nfin\nfan" | awk /f.n/

############
# Example 10 - Control flow
############

echo -e '\n******\n'
echo -e 'Control flow:\n'

awk 'BEGIN { num = 1; if (num % 2 == 0) printf "%d is an even number\n", num; else printf "%d is an odd number\n", num }'

############
# Example 11 - Loops
############

echo -e '\n******\n'
echo -e 'Loops:\n'

awk 'BEGIN { for (i = 1; i <= 5; i++) print i }'
awk 'BEGIN { i = 0; do { print i; i++ } while (i < 6) }'
