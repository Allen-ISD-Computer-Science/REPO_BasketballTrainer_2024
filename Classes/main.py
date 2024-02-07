#this allows the import on line 12


from EventTracker import EventTracker



from collections import defaultdict
from ultralytics import YOLO
import cv2
import threading

print("look here!: https://blog.enterprisedna.co/python-how-to-import-a-class/ and https://www.geeksforgeeks.org/python-import-module-from-different-directory/")








poseModel = YOLO("yolov8n-pose.pt")
basketballModel = YOLO(r"C:\Users\onikh\Desktop\Projects\REPO_BasketballTrainer_2024\runs\detect\train6\weights\best.pt")

tracker = EventTracker(bufferSize=60)

#create a cv2 object that takes a video frame by frame
capture = cv2.VideoCapture(r"C:\Users\onikh\Desktop\Projects\REPO_BasketballTrainer_2024\KyrieVSTatum.mp4")
fps = capture.get(cv2.CAP_PROP_FPS)
print(fps)


if not capture.isOpened():
    print("No stream")
    exit()

while(True):
    ret, frame = capture.read()

    

    basketballResults = basketballModel.track(frame, show=False, persist=True, tracker="bytetrack.yaml", verbose=False)
    
    tracker.updateBuffer(basketballResults)


    labeledFrame = basketballResults[0].plot()

    print(basketballResults)


    cv2.imshow("Webcam!", labeledFrame)



        


    if not ret:
        print("No more stream")
        break

    

    if cv2.waitKey(1) == ord('q'):
        break

capture.release()
cv2.destroyAllWindows



for results in tracker.buffer.buffer:
    print(results)
