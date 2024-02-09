from ultralytics import YOLO

def main():
    model = YOLO('yolov8m.yaml').load("yolov8m.pt")

    results = model.train(
        data="c:/Users/onikh/Desktop/Projects/Data/ISP2024/Basketball/data.yaml",
        epochs=300,
        imgsz=736,
        patience=50,
        project="AIBasketballTrainer",
        name="300 epochs on pretrained model (M)",
        device=0
    )

    success = model.export(format="onnx")

if __name__ == '__main__':
    main()