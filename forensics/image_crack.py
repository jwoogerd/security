# Jayme Woogerd

from sys import argv
from subprocess import call

def main():
    with open(argv[1], 'r') as f:
        lines = f.readlines()

    for word in lines:
	word = word.strip(' \t\n\r')
	print word
        call(["steghide", "extract", "-sf", "b.jpg", "-p", word])

if __name__ == '__main__':
    main()
