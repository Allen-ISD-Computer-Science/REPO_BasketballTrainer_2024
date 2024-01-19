from ultralytics import YOLO

model = YOLO('yolov8n.yaml')

results = model.train(
    data="c:/Users/onikh/Desktop/Projects/Data/ISP2024/Basketball/data.yaml",
    epochs=65)

success = model.export(format="onnx")