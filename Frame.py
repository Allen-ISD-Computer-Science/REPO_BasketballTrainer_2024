

class Frame:

    def __init__(self, basketballResults):
        
        if (basketballResults[0].boxes.cpu().numpy().xyxy.size > 0):
            self.XCoord1 = basketballResults[0].boxes.cpu().numpy().xyxy[0][0]
            self.XCoord2 = basketballResults[0].boxes.cpu().numpy().xyxy[0][1]
            self.YCoord1 = basketballResults[0].boxes.cpu().numpy().xyxy[0][2]
            self.YCoord2 = basketballResults[0].boxes.cpu().numpy().xyxy[0][3]
            
        else:
            self.XCoord1 = None
            self.XCoord2 = None
            self.XCoord3 = None
            self.xCoord4 = None 



    


