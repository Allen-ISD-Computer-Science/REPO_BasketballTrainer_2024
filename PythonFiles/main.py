import os
import sys
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))



from collections import defaultdict
from ultralytics import YOLO
import cv2
import threading
from Classes.FrameBuffer import FrameBuffer

poseModel = YOLO("yolov8n-pose.pt")
basketballModel = YOLO(r"C:\Users\onikh\Desktop\Projects\REPO_BasketballTrainer_2024\runs\detect\train6\weights\best.pt")

basketballTracker = FrameBuffer(size=2)

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
    poseResults = poseModel.track(frame, show=False, persist=True, tracker="bytetrack.yaml", verbose=False)


    labeledFrame = basketballResults[0].plot()

    #for result in basketballResults:
     #   boxes = result.boxes.cpu().numpy()
      #  boxCoordinates = boxes.xyxy

       # for rectangle in boxCoordinates:
        #    cv2.rectangle(labeledFrame, (int(rectangle[0]), int(rectangle[1])), (int(rectangle[2]), int(rectangle[3])), (0, 255, 0))


    cv2.imshow("Webcam!", labeledFrame)



        


    if not ret:
        print("No more stream")
        break

    

    if cv2.waitKey(1) == ord('q'):
        break

capture.release()
cv2.destroyAllWindows


