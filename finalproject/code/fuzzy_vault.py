# Jayme Woogerd
# Comp 116 - Security
# December 12, 2014

# to run: python

#from sys import argv
from random import uniform
import numpy

degree = 4 # degree 4 polynomial
t = 10     # number of features
r = 40     # number of chaff points

def get_coefficients(word):
    word = word.upper()
    n = len(word) / degree
    if n < 1: n = 1
    substrings = [word[i:i + n] for i in range(0, len(word), n)] 
    coeffs = []
    for substr in substrings:
        num = 0
        for x, char in enumerate(substr):
            num += ord(char) * 100**x
        coeffs.append(num**(1/3.0))
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

    #add chaff points
    max_x = max(template)
    for i in range(t, r):
        x_i = uniform(0, max_x * 1.1)
        y_i = uniform(0, p_x(max_x, coeffs) * 1.1)
        vault.append([x_i, y_i])

    return vault

def approx_equal(a, b, epsilon):
    return abs(a - b) < epsilon

def unlock(template, vault):
    def project(x):
        for point in vault:
            if (approx_equal(x, point[0], 0.001)):
                return [x, point[1]]
        return None

    Q = zip(*[project(point) for point in template if project(point) != None])
    try:
        return numpy.polyfit(Q[0], Q[1], deg=degree)
    except IndexError:
        return None

def decode(coeffs):
    s = ""
    for c in coeffs:
        num = int(round(c**3))
        if num == 0: continue
        while num > 0:
            s += str(unichr(num % 100)).lower()
            num /= 100
    return s

def main():
    test = lock("this is a test", [0, 4, 1.232, 4.32, -1, .11, 3.2, .932, 1.2, -3.3])
    coeffs = unlock([0.1, 3.9, 1.332, 4.12, -1.1, .01, 3.1, .832, 1.3, -3.4], test)
    print decode(coeffs)

if __name__ == '__main__':
    main()

# with open(argv[1], 'r') as f:
#     lines = f.readlines()
