import numpy as np
import sys

class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y


def hypothesis(theta_0, theta_1, point):
    return theta_0 + theta_1 * point.x

def cost(m, hyp, true):
    sigma = 0
    for i in range(0, len(true)): 
        sigma += 1/ 2*m * (hyp[i].y - true[i].y)**2

    return sigma

def main ():
    pyg.init() 
    
    theta_0 = 69420
    theta_1 = 100000
    alpha = 0.01
    tolerance = 0.0000000001
    
    points = [Point(1,2),Point(2,3),Point(3,4), Point(4,5)]
    m = len(points)

    iterations = 0

    while cost(m, [Point(point.x, hypothesis(theta_0, theta_1, point)) for point in points], points) > tolerance:
        iterations += 1
        for point in points:
            theta_0 -= 1/m * alpha*(hypothesis(theta_0, theta_1, point) - point.y)
            theta_1 -= 1/m * alpha*(hypothesis(theta_0, theta_1, point) - point.y) * point.x

    print(iterations)
    print(theta_0)
    print(theta_1)

if __name__ == "__main__":
    main()