# Set up workspace
echo "hello world" > tests/workspace/file1.txt

# Run the program
results=`cat tests/workspace/file1.txt`

# Evaluate the test case
if [ "$results" == "hello world" ]; then
	echo "Pass"
else
	echo "Fail"
fi
