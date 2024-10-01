print("Hello, World!")

# Open the file in write mode (this will create the file if it doesn't exist)
with open('py-output.md', 'w') as file:
    # Write a line of text to the file
    file.write('1. This is a line of text.\n')

print("file written...")
