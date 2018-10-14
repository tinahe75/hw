'''
    Extend the torch.utils.data.Dataset class to build a GestureDataset class.
'''
import torch.utils.data as data

class GestureData(data.Dataset):

    def __init__(self,features,labels):
        self.features = features
        self.labels = labels

    def __len__(self):
        return len(self.features)

    def __getitem__(self, index):
        get_labels = self.labels[index]
        get_features = self.features[index]
        return get_features,get_labels