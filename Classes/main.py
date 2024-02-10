#this allows the import on line 12


from EventTracker import EventTracker
from Frame import Frame


import time
from collections import defaultdict
from ultralytics import YOLO
import cv2
import threading

print("look here!: https://blog.enterprisedna.co/python-how-to-import-a-class/ and https://www.geeksforgeeks.org/python-import-module-from-different-directory/")

dribbles = 0

#make thresholds in term of the ball
def dribbleDetector(rawFrames, threshold):
    global dribbles
    filteredFrames = rawFrames.filterNilBasketballs(howManyFrames=3)
    
    if len(filteredFrames) >= 3 and rawFrames[0].ball is not None:
        deltaY_1 = filteredFrames[0].ball.y1 - filteredFrames[1].ball.y1
        deltaY_2 =  filteredFrames[1].ball.y1 - filteredFrames[2].ball.y1

        #as far as I know this is basically acceleration? I check this to prevent dribbles from little shakes of the ball
        doubleDeltaY = deltaY_1 - deltaY_2

        
        #print("deltaY: " + str(deltaY_1) + "    double deltaY: " + str(doubleDeltaY))
        print("height: " + str(filteredFrames[0].ball.height))
        
        if (deltaY_1 < 0 and deltaY_2 >= 0 and doubleDeltaY <= threshold):
            dribbles += 1
            print("dribbles: " + str(dribbles))






poseModel = YOLO("yolov8n-pose.pt")
basketballModel = YOLO(r"C:\Users\onikh\Desktop\Projects\REPO_BasketballTrainer_2024\runs\detect\train6\weights\best.pt")

tracker = EventTracker(bufferSize=60)
sleepTime = 0.1

#create a cv2 object that takes a video frame by frame
capture = cv2.VideoCapture(r"C:\Users\onikh\Desktop\Projects\REPO_BasketballTrainer_2024\TestVideos\IMG_0 - Trim.mp4")
fps = capture.get(cv2.CAP_PROP_FPS)
print(fps)


if not capture.isOpened():
    print("No stream")
    exit()

while(True):
    ret, frame = capture.read()

    time.sleep(.5) # for debugging

    basketballResults = basketballModel.track(frame, show=False, persist=True, tracker="bytetrack.yaml", verbose=False)
    
    tracker.updateBuffer(Frame(basketballResults=basketballResults))

    dribbleDetector(tracker.buffer, -5)


    labeledFrame = basketballResults[0].plot()

    cv2.putText(labeledFrame, ("dribbles: " + str(dribbles)), (50, 50), cv2.FONT_HERSHEY_SIMPLEX, 1, (255, 0, 0), 2)


    cv2.imshow("Webcam!", labeledFrame)



        


    if not ret:
        print("No more stream")
        break

    

    if cv2.waitKey(1) == ord('q'):
        break


capture.release()
cv2.destroyAllWindows


for frame in tracker.buffer:
    
    print(frame.__dict__)

print("SEPARATOR\n\n\n")

for frame in tracker.buffer.filterNilBasketballs(howManyFrames=60):
    print(frame.__dict__)
