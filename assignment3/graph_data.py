import numpy as np
import matplotlib.pyplot as plt

def main():
    train_labels = np.load('train_labels.npy')
    train_data = np.load('train_data.npy')
    vali_labels = np.load('val_labels.npy')
    vali_data = np.load('val_data.npy')
    all_instances = np.load('instances.npy')
    time = all_instances[1,:,0:1]
    print(np.amax(vali_data[:,:,1]))

    convert_graph(vali_data,vali_labels,time,'validation')



def convert_graph(data,labels,time,type):
    num_instances = data.shape[0]
    for i in range(num_instances):
        plt.figure(frameon=False,figsize=[6.400,6.400])
        plt.plot(time, data[i,:,0], time, data[i,:,1])  # plot x and y acc
        label = labels[i]
        plt.axis([0, 1980, -7, 5])
        plt.axis('off')
        plt.savefig('./data/{}_graphs/instance_{}_label_{}'.format(type,str(i),label),bbox_inches='tight')


if __name__ == "__main__":
    main()