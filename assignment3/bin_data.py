'''
    Visualize some basic statistics of our dataset.
    Note: this uses output from csv2numpy.py
'''
import numpy as np
import matplotlib.pyplot as plt

def main():
    all_labels = np.load('labels.npy')
    all_instances = np.load('instances.npy')

    # Choose gestures X,Y,Z;    Find avg values over time and gesture instances for each gesture

    # find indices of when the label is x,y,z in the numpy array all_labels

    z_ind_arr = np.where(all_labels == 'z')[0]
    y_ind_arr = np.where(all_labels == 'y')[0]
    x_ind_arr = np.where(all_labels == 'x')[0]

    # crop out the data for each gesture, make an array for each one
    x_data = np.zeros((5*43,100,7))
    y_data = np.zeros((5*43,100,7))
    z_data = np.zeros((5*43,100,7))

    for i in range(5*43):
        x_data[i, :, :] = all_instances[x_ind_arr[i], :, :]
        y_data[i, :, :] = all_instances[y_ind_arr[i], :, :]
        z_data[i, :, :] = all_instances[z_ind_arr[i], :, :]

    # collate data across different instances, so we can investigate statistics over both time and gesture instances
    x_data = np.reshape(x_data,(21500,7))
    y_data = np.reshape(y_data,(21500,7))
    z_data = np.reshape(z_data,(21500,7))
    # now we have an array for each gesture, each array has 7 columns

    x_avg,x_sd = find_stats(x_data)
    y_avg,y_sd = find_stats(y_data)
    z_avg,z_sd = find_stats(z_data)

    sensors = ['a_x','a_y','a_z','w_x','w_y','w_z']

    bar_graph(sensors,x_avg,x_sd,'x')
    bar_graph(sensors,y_avg,y_sd,'y')
    bar_graph(sensors,z_avg,z_sd,'z')

def find_stats(data):
    avg=np.average(data,axis=0)[1::]
    sd=np.std(data,axis=0)[1::]
    return avg,sd

def bar_graph(sensors,avg,sd,gesture):
    plt.figure()
    plt.bar(sensors, avg, yerr=sd)
    plt.title('Bar graph for average features corresponding to gesture {}'.format(gesture))
    plt.savefig(gesture+'_stats_bar_graph')

if __name__ == "__main__":
    main()