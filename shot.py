import math

def main():
    print("Input the distance from the rim:")
    distance = float(input())
    print("Input the height of your shot:")
    height = float(input())
    print("Input what the angel of your shot was:")
    angle = int(input())
    angleOffBy(angle, distance, height)

def optimalShotAngle(distance, height):
    d = distance
    h = 10 - height
    angle = -math.atan(2*(-d-h)/d + 1) * (180/math.pi)
    return angle

def angleOffBy(angle, distance, height):
    notGoodAngle = True

    if  angle - int(optimalShotAngle(distance, height)) < -1:
        print("Your shot is too low, raise it up by " + str(-(angle - int(optimalShotAngle(distance, height)))) + " degrees.")
        notGoodAngle = False

    if angle - int(optimalShotAngle(distance, height)) > 1:
        print("Your shot is too high, lower it by " + str(angle - int(optimalShotAngle(distance, height))) + " degrees.")
        notGoodAngle = False

    if notGoodAngle:
        print("Correct angle, good job.")
    
def get_shot_feedback():
    print("Input the distance from the rim:")
    distance = float(input())
    print("Input the height of your shot:")
    height = float(input())
    print("Input what the angle of your shot was:")
    angle = int(input())
    angleOffBy(angle, distance, height)


