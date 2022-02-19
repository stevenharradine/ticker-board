# Set up workspace
# no file set up needed

# Run the program
results=`echo "hello world"`

# Evaluate the test case
if [ "$results" == "hello world" ]; then
	echo "Pass"
else
	echo "Fail"
fi
