from ultralytics import YOLO

model = YOLO("/Users/246353/Desktop/ISP/REPO_BasketballTrainer_2024/runs/detect/train6/weights/best.pt")

results = model.track(source="/Users/246353/Desktop/ISP/REPO_BasketballTrainer_2024/[Tt]G1q3p2.mp4", show=True)
