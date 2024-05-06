import sys

def square(x):
    return x * x

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: square.py <number>")
        sys.exit(1)
    
    num = int(sys.argv[1])
    result = square(num)
    print(f"The square of {num} is {result}")