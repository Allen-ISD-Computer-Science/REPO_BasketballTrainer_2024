from ultralytics import YOLO
import cv2
import threading

poseModel = YOLO("yolov8n-pose.pt")
basketballModel = YOLO(r"C:\Users\onikh\Desktop\Projects\REPO_BasketballTrainer_2024\runs\detect\train6\weights\best.pt")

capture = cv2.VideoCapture(0)

if not capture.isOpened():
    print("No stream")
    exit()

while(True):
    ret, frame = capture.read()

    results = basketballModel.predict(frame, show=True)

    for result in results:
        print(result.boxes.xywh)

    if not ret:
        print("No more stream")
        break

    cv2.imshow("Webcam!", frame)

    if cv2.waitKey(1) == ord('q'):
        break

capture.release()
cv2.destroyAllWindows


