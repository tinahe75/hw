'''
    The entry into your code. This file should include a training function and an evaluation function.
'''
from dataset import GestureData
from model import Gesture_CNN
import numpy as np
import torch
import torch.nn as nn
from torch.autograd import Variable
from torch.utils.data import DataLoader

torch.manual_seed(77)
'''
CHANGE HYPER PARAMETERS HERE
'''
learn_rate = 0.1
bs=2*43
NumEpochs=20
eval_every = 10



'''
LOAD DATA INTO MODEL
t_features,t_labels,v_features,v_labels are numpy arrays
'''
def load_data(t_features,t_labels,v_features,v_labels):
    global bs
    t_dataset = GestureData(t_features,t_labels)
    v_dataset = GestureData(v_features,v_labels)
    t_loader = DataLoader(t_dataset,batch_size=bs,shuffle=True)
    v_loader = DataLoader(v_dataset,batch_size=bs,shuffle=False)
    return t_loader,v_loader



'''
LOAD CNN MODEL
'''
def load_model(learning_rate):
    model = Gesture_CNN()
    loss_fxn = nn.CrossEntropyLoss()
    optimizer = torch.optim.SGD(model.parameters(),lr=learning_rate)
    return model, loss_fxn, optimizer



'''
EVALUATE RESULTS WITH VALIDATION SET
'''
def eval_with_vali_set(model,v_loader):
    global bs
    total_val_corr = 0
    vali_samples = len(v_loader.dataset)
    for vb_features,vb_labels in v_loader:
        vb_features = vb_features.float()
        vb_features = vb_features.view(bs, 1, 100, 2)  # only 1 channel
        vb_predictions = model.forward(vb_features)

        pred_res = vb_predictions.data.numpy() # convert prediction results to single output
        pred_res = np.argmax(pred_res, axis=1)  # find which letter is most probable, that one is the prediction
        actual_res = vb_labels.int().numpy()

        for j in range(bs):
            if pred_res[j] == actual_res[j]:
                total_val_corr += 1

    return float(total_val_corr)/vali_samples  # return this as the evaluation accuracy



'''
TRAINING PROCESS
'''
def main():
    global learn_rate,bs,NumEpochs,eval_every

    t_features = np.load('train_data.npy')
    t_labels = np.load('train_labels.npy')
    v_features = np.load('val_data.npy')
    v_labels = np.load('val_labels.npy')

    model,loss_fxn,optimizer = load_model(learn_rate)
    t_loader,v_loader = load_data(t_features,t_labels,v_features,v_labels)

    batch_done = 0  # keep track of total number of batches we've gone through as we cycle through epochs

    for epoch in range (NumEpochs):
        accum_loss = float(0)
        total_correct = 0

        for (tb_features,tb_labels)in t_loader:
            optimizer.zero_grad()
            tb_features = tb_features.float()
            tb_features = tb_features.view(bs,1,100,2)  # only have 1 channel
            tb_labels = tb_labels.long()

            tb_predictions = model.forward(tb_features)
            tb_loss = loss_fxn(input=tb_predictions.squeeze(), target=tb_labels)
            accum_loss += tb_loss.item()

            tb_loss.backward()
            optimizer.step() # make changes to model

            pred_res = tb_predictions.data.numpy()
            pred_res = np.argmax(pred_res, axis=1)  # the one with max probability is the prediction
            actual_res = tb_labels.int().numpy()

            for j in range(bs):
                if pred_res[j] == actual_res[j]:
                    total_correct +=1  # add correct answers in this batch to the total number of correct answers

            if batch_done == 0:
                print('\n ---------------- T R A I N I N G   I N   P R O G R E S S ----------------\n')
            if (batch_done+1)% eval_every == 0:
                vali_accuracy = eval_with_vali_set(model,v_loader)
                print('\n Epoch {}, after {} total batches, accum loss is {}, validation accuracy is {} \n'.format(epoch+1,batch_done+1,accum_loss/100,vali_accuracy))
            batch_done +=1


        print('\n------------- Training accuracy at end of epoch {} is {} -------------'.format(epoch+1,total_correct/len(t_loader.dataset)))







if __name__ == "__main__":
    main()