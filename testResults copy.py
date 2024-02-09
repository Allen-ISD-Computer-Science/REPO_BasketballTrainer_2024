from Classes.Frame import Frame
from collections import defaultdict
from ultralytics import YOLO
import cv2
import threading










basketballModel = YOLO(r"C:\Users\onikh\Desktop\Projects\REPO_BasketballTrainer_2024\runs\detect\train6\weights\best.pt")



#create a cv2 object that takes a video frame by frame
capture = cv2.VideoCapture(0)
fps = capture.get(cv2.CAP_PROP_FPS)
print(fps)


if not capture.isOpened():
    print("No stream")
    exit()

while(True):
    ret, frame = capture.read()

    

    basketballResults = basketballModel.track(frame, show=False, persist=True, tracker="bytetrack.yaml", verbose=False, conf= 0.5)
    labeledFrame = basketballResults[0].plot()
    cv2.imshow("tracker", labeledFrame)

    dataFrame = Frame(basketballResults=basketballResults)
    print(dataFrame.XCoord)

        




        


    if not ret:
        print("No more stream")
        break

    

    if cv2.waitKey(1) == ord('q'):
        break

capture.release()
cv2.destroyAllWindows





