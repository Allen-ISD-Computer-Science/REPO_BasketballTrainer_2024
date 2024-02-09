from collections import deque

class MyClass:
    def __init__(self, value):
        self.value = value

def filterNil(frames, framesToSearch):
    nonNilElements = [frame for frame in frames if frame.value is not None]
    return nonNilElements[:framesToSearch]

# Example deque with instances of MyClass
my_deque = deque([MyClass(1), MyClass(None), MyClass(3), MyClass(None), MyClass(5)])

# Find the first three non-None elements
result = filterNil(my_deque, 2)
print("First three non-None elements:", [obj.value for obj in result])