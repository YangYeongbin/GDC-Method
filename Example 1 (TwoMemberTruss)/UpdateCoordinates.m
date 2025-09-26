function [Node_update] = UpdateCoordinates(Node_update,Node_num,dU)
for m = 1 : 1 : Node_num
    for n = 1 : 1 : 2
        if n == 1
            Node_update(m,n) = Node_update(m,n) + dU(2 * m - 1);
        else 
            Node_update(m,n) = Node_update(m,n) + dU(2 * m);
        end
    end
end