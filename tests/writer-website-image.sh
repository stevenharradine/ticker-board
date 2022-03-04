# Set up workspace
rm -f webserver/images/ticker.jpeg

# Run the program
results=`bash writer.sh "hello world" > /dev/null 2>&1`

# Evaluate the test case
if [ -f webserver/images/ticker.jpeg ]; then
	echo "Pass"
else
	echo "Fail"
fi
