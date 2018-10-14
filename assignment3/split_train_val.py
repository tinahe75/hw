'''
    Split normalized data into training and validation data
'''
import numpy as np
import random
from sklearn.preprocessing import OneHotEncoder
random.seed(77) # manually set random seed

norm_all_instances = np.load('./data/normalized_data.npy')
all_labels = np.load('labels.npy')

vali_percent = 0.2
vali_samples = int(5590*vali_percent)
rand_ind = np.array(random.sample(range(5590),vali_samples))  # random selection of gesture instance indices
vali_instances = np.zeros((vali_samples,100,6))
vali_labels = np.array([],dtype='int')
train_labels = all_labels

for i in range(vali_samples):
    ind = rand_ind[i]
    vali_instances[i,:,:] = norm_all_instances[ind,:,:]
    int_label = int(ord(all_labels[ind])-97)
    vali_labels = np.append(vali_labels,int_label)  # validation labels as array of integers
    train_labels[ind] = 'del'  # set a flag, later will remove elements with this flag


train_instances = np.delete(norm_all_instances,rand_ind,0)
index = np.argwhere(train_labels == 'del')  # remove validation labels from all_labels, remaining are training labels
train_labels = np.delete(train_labels,index)
for i in range(len(train_labels)):
    train_labels[i]= int(ord(train_labels[i])-97)
train_labels = train_labels.astype(int)   # training labels as arrray of integers


# Use one hot encoding for labels: convert integer array to one hot code
onehot=OneHotEncoder()
oneh_train_labels = onehot.fit_transform(train_labels.reshape(-1,1)).toarray()
oneh_train_labels = oneh_train_labels.reshape(((5590-vali_samples),26,1))
oneh_vali_labels = onehot.fit_transform(vali_labels.reshape(-1,1)).toarray()
oneh_vali_labels = oneh_vali_labels.reshape(((vali_samples),26,1))


# only want x and y acc
vali_instances = vali_instances[:,:,0:2]
train_instances = train_instances [:,:,0:2]

# save validation data and labels
np.save('val_data.npy',vali_instances)
#np.save('val_labels.npy',oneh_vali_labels)
np.save('val_labels.npy',vali_labels)

# save training data and labels
np.save('train_data.npy',train_instances)
#np.save('train_labels.npy',oneh_train_labels)
np.save('train_labels.npy',train_labels)