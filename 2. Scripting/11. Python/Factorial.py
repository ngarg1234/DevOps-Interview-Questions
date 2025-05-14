# Python code​​​​​​‌‌​​‌​​​​‌‌​‌‌​‌‌‌‌‌​​‌​‌ below
def factorial(n):
    # Ensure the input is a non-negative integer
    if not isinstance(n, int):
        return None
    if n < 0:
        return None
    # Base case: factorial of 0 or 1 is 1
    elif n == 0 or n == 1:
        return 1
    # Recursive case
    else:
        return n * factorial(n - 1)
    

    # OR

def factorial(n):
    if type(n) != int:
        return None
    if n < 0:
        return None
    
    fact = 1
    counter = 1
    while counter <+ n:
        fact = fact * counter
        counter = counter + 1
    return fact