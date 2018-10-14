'''
    Write a model for gesture classification.
'''
import torch.nn as nn
import numpy as np

input_size = np.array([2,100])  #only use x and y acc
kernel1_num = 10
kernel1_size = input_size[0]

class Gesture_CNN(nn.Module):

    def __init__(self):
        super(Gesture_CNN,self).__init__()
        self.conv1 = nn.Conv2d(1,kernel1_num,kernel1_size)
        self.pool = nn.MaxPool2d((3,1))
        self.fc1 = nn.Linear(10*33,200)
        self.fc2 = nn.Linear(200,26)

    def forward(self, input):
        x = self.conv1(input)
        relu = nn.ReLU()
        x = relu(x)
        x = self.pool(x)
        x = x.view(-1,330)
        x = relu(self.fc1(x))
        x = relu(self.fc2(x))
        softmax = nn.Softmax(dim=1)
        x = softmax(x)
        return x