#!/bin/bash
#Workflow: Example Workflow

#Step 1: Say Hello 

echo "Hello, world!"

#Step 2: Create a directory and a file 

mkdir -p output
echo "Data generated" > output/data.txt
echo "Reading the file: "
cat output/data.txt

#Step 3: List files 

echo "Listing files:"
ls -la
