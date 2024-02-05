from collections import defaultdict
from ultralytics import YOLO
import cv2
import threading

poseModel = YOLO("yolov8n-pose.pt")
basketballModel = YOLO(r"./bball.pt")

capture = cv2.VideoCapture(r"C:\Users\onikh\Desktop\Projects\REPO_BasketballTrainer_2024\drills.mp4")
fps = capture.get(cv2.CAP_PROP_FPS)
print(fps)


if not capture.isOpened():
    print("No stream")
    exit()

while(True):
    ret, frame = capture.read()

    results = basketballModel.track(frame, show=False, persist=True, tracker="bytetrack.yaml", verbose=False)
    labeledFrame = results[0].plot()
    cv2.imshow("Webcam!", labeledFrame)

    for result in results:
        boxes = result.boxes.cpu().numpy()
        

        boxCoordinates = boxes.xyxy

        


    if not ret:
        print("No more stream")
        break

    

    if cv2.waitKey(1) == ord('q'):
        break

capture.release()
cv2.destroyAllWindows


