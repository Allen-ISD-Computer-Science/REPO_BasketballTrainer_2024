from ultralytics import YOLO

from collections import defaultdict

import cv2
import threading

poseModel = YOLO("yolov8n-pose.pt")
basketballModel = YOLO(r"C:\Users\onikh\Desktop\Projects\REPO_BasketballTrainer_2024\runs\detect\train6\weights\best.pt")

results = basketballModel.predict(source="0", show=True)


print(results)