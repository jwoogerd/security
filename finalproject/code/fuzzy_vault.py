# Jayme Woogerd
# Comp 116 - Security
# December 12, 2014

# to run: python

#from sys import argv

def get_coefficients(word):
    n = len(word) / 5   # degree 4 polynomial functions
    if n < 1: n = 1
    substrings = [word[i:i + n] for i in range(0, len(word), n)] 
    coeffs = [sum(ord(char) for char in substr) for substr in substrings]
    return coeffs

def p_x(x, coeffs):
    y = 0
    degree = len(coeffs) - 1

    for coeff in coeffs:
        y += x**degree * coeff
        degree -= 1

    return y

def lock(secret, template):
    vault = []
    coeffs = get_coefficients(secret)

    # calculate genuine points
    for point in template:
        vault.append([point, p_x(point, coeffs)])

    #add chaff points...how many?
    return vault

def unlock(template, vault):
    return template

def main():
    print lock("test a long secret", [0, 4, 1.232, 4.32, -1])

if __name__ == '__main__':
    main()

# with open(argv[1], 'r') as f:
#     lines = f.readlines()
