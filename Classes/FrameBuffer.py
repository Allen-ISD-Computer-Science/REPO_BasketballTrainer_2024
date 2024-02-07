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
    
    def getFrame(self, index):
        if (0 <= index and index < len(self.buffer)):
            return self.buffer[index]
        else:
            raise Exception("index given was out of range of FrameBuffer")
        
    


