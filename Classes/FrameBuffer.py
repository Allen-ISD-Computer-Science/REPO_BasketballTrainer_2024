from collections import deque

class FrameBuffer:

    def __init__(self, size):
        self.buffer = deque(maxlen=size)

    def __iter__(self):
        return iter(self.buffer)

    def addFrame(self, frame):
        self.buffer.appendleft(frame)

    def getFrames(self):
        return list(self.buffer)
    
    def __getitem__(self, item):
        if (0 <= item and item < len(self.buffer)):
            return self.buffer[item]
        else:
            raise Exception("index given was out of range of FrameBuffer")
        
    def filterNilBasketballs(self, howManyFrames):
        nonNilElements = [frame for frame in self.buffer if frame.ball is not None]
        return nonNilElements[:howManyFrames]
        
    
        
    


