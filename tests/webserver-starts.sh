# Set up workspace

# Run the program
node webserver > /dev/null 2>&1 &
pid=$!

sleep 3 # give the server a chance to start

result=`curl --silent --head localhost:8000 | head -n 1`

# Evaluate the test case
if [[ $result == *"200 OK"* ]]; then
	echo "Pass"
else
	echo "Fail"
fi

kill $pid