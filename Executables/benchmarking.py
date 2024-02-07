from ultralytics import YOLO

def main():
    basketballModel = YOLO(r"C:\Users\onikh\Desktop\Projects\REPO_BasketballTrainer_2024\runs\detect\train6\weights\best.pt")
    metrics = basketballModel.val()

if __name__ == '__main__':
    main()
