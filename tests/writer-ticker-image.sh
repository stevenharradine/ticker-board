# Set up workspace
rm -f ticker.ppm

# Run the program
results=`bash writer.sh "hello world" > /dev/null 2>&1`

# Evaluate the test case
if [ -f ticker.ppm ]; then
	echo "Pass"
else
	echo "Fail"
fi
