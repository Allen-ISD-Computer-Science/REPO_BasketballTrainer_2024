from collections import defaultdict
from ultralytics import YOLO
import cv2
import threading

poseModel = YOLO("yolov8n-pose.pt")
basketballModel = YOLO(r"C:\Users\onikh\Desktop\Projects\REPO_BasketballTrainer_2024\runs\detect\train6\weights\best.pt")


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


    labeledFrame = poseResults[0].plot()

    for result in basketballResults:
        boxes = result.boxes.cpu().numpy()
        boxCoordinates = boxes.xyxy

        for rectangle in boxCoordinates:
            cv2.rectangle(labeledFrame, (int(rectangle[0]), int(rectangle[1])), (int(rectangle[2]), int(rectangle[3])), (0, 255, 0))


    font = cv2.FONT_HERSHEY_SIMPLEX 

    cv2.putText(labeledFrame,  
                str(capture.get(cv2.CAP_PROP_FPS)),  
                (50, 50),  
                font, 1,  
                (0, 255, 255),  
                2,  
                cv2.LINE_4) 

    cv2.imshow("Webcam!", labeledFrame)



        


    if not ret:
        print("No more stream")
        break

    

    if cv2.waitKey(1) == ord('q'):
        break

capture.release()
cv2.destroyAllWindows


