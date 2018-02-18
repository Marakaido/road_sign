function [net,tr] = image_neuro_study(saveFileName, goal, times, P, T)

net = feedforwardnet([16, 12]);

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

figure, plotregression(T, best_net(P))
view(best_net)

net = best_net;
tr = best_tr;
time = sum(tr.time);

save(saveFileName, 'net', 'tr', 'time', 'times')