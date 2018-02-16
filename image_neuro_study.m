function [net,tr] = image_neuro_study(saveFileName, goal, times)

load train_data.mat

net = newff(P, T, [16 16], {'logsig', 'logsig'});

net.trainFcn = 'trainoss';
net.performFcn = 'mse';
net.trainParam.epochs=2000;
net.trainParam.goal=goal;

[best_net, best_tr] = train(net,P,T);
best_perf = perform(best_net,T,best_net(P));
for i = 1:times
    net = init(net);
    [net, tr] = train(net, P, T);
    perf = perform(net, T, net(P));
    if perf < best_perf
        best_perf = perf;
        best_net = net;
        best_tr = tr;
    end
end

figure, plotconfusion(T, best_net(P))
view(best_net)

net = best_net;
tr = best_tr;
time = sum(tr.time);

save(saveFileName, 'net', 'tr', 'time', 'times')