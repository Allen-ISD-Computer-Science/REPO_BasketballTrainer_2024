

class BasketballTracker:

    #rawFrames is the FrameBuffer containing all the Frames
    def dribbleDetector(rawFrames):
        filteredFrames = rawFrames.filterNilBasketballs(howManyFrames=3)

        deltaY_1 = filteredFrames[0].ball.y1 - filteredFrames[0].ball.y1
        print(deltaY_1)

