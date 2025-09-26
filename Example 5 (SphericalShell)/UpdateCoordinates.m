function [Node_update] = UpdateCoordinates(Node_update,Node_num,dU)
for m = 1 : 1 : Node_num
    for n = 1 : 1 : 3
        if n == 1
            Node_update(m,n) = Node_update(m,n) + dU(6 * m - 5);
        elseif n == 2
            Node_update(m,n) = Node_update(m,n) + dU(6 * m - 4);
        else
            Node_update(m,n) = Node_update(m,n) + dU(6 * m - 3);
        end
    end
end