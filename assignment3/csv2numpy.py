'''
    Save the data in the .csv file, save as a .npy file in ./data
    Note: time column is kept!
'''
import numpy as np
import glob

#all_instances_data = np.zeros((130*43,100,6))  # without time column
all_instances_data = np.zeros((130*43,100,7))
all_labels = np.array([],dtype='object')
instance_num = 0
for i in range (43):
    folder = 'data/unnamed_train_data/student'+str(i)
    filenames = sorted(glob.glob(folder+'/*.csv'))
    for csv_file in filenames:
        instance_data = np.loadtxt(str(csv_file),delimiter=',')
        #instance_data = instance_data[:,1::]   # get rid of the time data, only want 6 columns
        all_instances_data[instance_num,:,:] = instance_data
        instance_label = str(csv_file)[-7] # get the letter
        all_labels = np.append(all_labels,instance_label)
        instance_num += 1

np.save('instances.npy',all_instances_data)
np.save('labels.npy',all_labels)