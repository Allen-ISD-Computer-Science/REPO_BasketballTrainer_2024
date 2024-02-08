from Ball import Ball

class Frame:



    def __init__(self, basketballResults):
        
        if (basketballResults[0].boxes.cpu().numpy().xyxy.size > 0):
            x1 = int(basketballResults[0].boxes.cpu().numpy().xyxy[0][0])
            y1 = int(basketballResults[0].boxes.cpu().numpy().xyxy[0][1])
            x2 = int(basketballResults[0].boxes.cpu().numpy().xyxy[0][2])
            y2 = int(basketballResults[0].boxes.cpu().numpy().xyxy[0][3])

            self.ball = Ball(x1= x1, y1=y1, x2=x2, y2=y2)

            
            
        else:
            self.ball = None






