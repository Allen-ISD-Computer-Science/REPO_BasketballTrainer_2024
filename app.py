import ultralytics
import sys
from PyQt6 import QtWidgets, uic
from PyQt6.QtWidgets import * 
from PyQt6.QtGui import *
from PyQt6.QtCore import * 
import sys 
  
  
class Window(QMainWindow): 
    def __init__(self): 
        super().__init__() 
  
        # setting title 
        # self.setWindowTitle("AI Basketball Trainer ") 
        # changing the background color  
        # self.setStyleSheet("background-color: orange;") 
        # setting geometry 
        self.setGeometry(100, 100, 600, 400) 
  
        # calling method 
        self.UiComponents() 
  
        # showing all the widgets 
        self.show() 
  
    # method for widgets 
    def UiComponents(self): 
  
        # creating a push button 
        FilmButton = QPushButton("Film Video ", self) 
  
        # setting geometry of button 
        FilmButton.setGeometry(250, 140, 100, 40) 
  
  
        # adding action to a button 
        FilmButton.clicked.connect(self.clickme) 
        # creating a push button 
        UploadButton = QPushButton("Video Upload ", self) 
  
        # setting geometry of button 
        UploadButton.setGeometry(250, 240, 100, 40) 
  
  
        # adding action to a button 
        UploadButton.clicked.connect(self.clickme) 

        # creating a title labe 
        titleButton = QPushButton("AI Basketball Trainer ", self) 
  
        titleButton.setGeometry(205, 40, 200, 40) 
  
        titleButton.clicked.connect(self.clickme) 

        UploadButton.clicked.connect(self.clickme) 

  
    # action method 
    def clickme(self): 
  
        # printing pressed 
        //filename = QtGui.QFileDialog.getOpenFileName(self, 'Open File', '.')
        //print("Working") 
  
# create pyqt5 app 
App = QApplication(sys.argv) 
  
# create the instance of our Window 
window = Window() 
  
# start the app 
sys.exit(App.exec()) 