import sys

if len(sys.argv)!=2:
    print "Insufficient arguments"
    print "Usage : python comapre_voice.py <file_name>"
    sys.exit(0)

file_voice = open(str(sys.argv[1])).read().split("\n")
found_flag=False
max_val = 0
user_name =""
for lines in file_voice:
    if not lines:
        break
    compare_val = lines.split(" ")[4]
    if float(compare_val) > 0.3:
        found_flag=True
        if max_val < compare_val:
            max_val = compare_val
            user_name = str(lines.split(" ")[1])

if not found_flag:
    print "You are not authenticated"
else:
    print "Welcome " + str(user_name) 
