#!/bin/bash
echo "Enter a number:"
read num
rev_num=0

while [ $num -gt 0 ]
do
    digit=$((num % 10))  # Extract last digit
    rev_num=$((rev_num * 10 + digit))  # Append to reversed number
    num=$((num / 10))  # Remove last digit
done