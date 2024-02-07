from FrameBuffer import FrameBuffer


class EventTracker:

    def __init__(self, bufferSize):
        self.buffer = FrameBuffer(size=bufferSize)
    



    def updateBuffer(self, results):
        self.buffer.addFrame(results)
        
    
b = FrameBuffer(size=10)