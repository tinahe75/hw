'''
    Visualize some samples.
    NOTE: this code uses the output from csv2numpy.py
'''
import numpy as np
import matplotlib.pyplot as plt

def main():
    all_labels = np.load('labels.npy')
    all_instances = np.load('instances.npy')

    # Gesture classes chosen: S and L

    print(all_labels[1393],all_labels[5293],all_labels[3084])  # check to see if all three are s
    print(all_labels[708],all_labels[3049],all_labels[4739])  # check to see if all three are l

    time = all_instances[1,:,0:1]
    class1_ind = np.array([1393,5293,3084])  # s
    class2_ind = np.array([708,3049,4739])   # l

    plot_class(class1_ind,'S',all_instances,time)
    plot_class(class2_ind,'L',all_instances,time)


def plot_class(class_indices,gesture,all_instances,time):
    for ind in class_indices:
        plt.figure()
        plt.xlabel('Time/ milliseconds')
        plt.title('Class {}: instance number {}'.format(gesture,ind))
        for i in range(1, 7):
            plt.plot(time, all_instances[ind, :, i])
        plt.legend(['x_acc', 'y_acc', 'z_acc', 'x_rot', 'y_rot', 'z_rot'], loc='best')
        plt.savefig('{}_{}'.format(gesture,ind))


if __name__ == "__main__":
    main()