

class Frame:

    def __init__(self, basketballResults):
        
        if (basketballResults[0].boxes.cpu().numpy().xyxy.size > 0):
            self.XCoord = basketballResults[0].boxes.cpu().numpy().xyxy[0][0]
        else:
            self.XCoord = None


