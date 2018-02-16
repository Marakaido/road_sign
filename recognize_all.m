function [Result, correct_counter] = recognize_all(net, R, T)

correct_counter = 0;
dims = size(R);

for i = 1:dims(2)
    result = net(R(:, i));
    [M, index] = max(result);
    result = zeros(62, 1);
    result(index) = 1;
    Result(:,i) = result;
    if isequal(result, T(:, i))
        correct_counter = correct_counter + 1;
    end
end