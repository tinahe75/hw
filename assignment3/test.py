import numpy as np


all_instances_time = np.load('instances.npy')
all_labels = np.load('labels.npy')

all_instances = all_instances_time [:,:,1:]  # get rid of time column

norm_all_instances = all_instances

# Find local mean;
all_instances_mean = np.mean(all_instances[:,:,:],axis=1,keepdims = True)

# Find local standard deviation
all_instances_sd = np.std(all_instances,axis=1, keepdims = True)

# Normalize locally
norm_all_instances = np.divide((all_instances - all_instances_mean), all_instances_sd) # has shape of (5590,100,6)