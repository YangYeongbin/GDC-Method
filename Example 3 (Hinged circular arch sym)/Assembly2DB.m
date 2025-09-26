function K = Assembly2DB(K, k, i, j)
dofs  = [3*i-2, 3*i-1, 3*i, 3*j-2, 3*j-1, 3*j];
for r = 1:6
    for c = 1:6
        K(dofs(r), dofs(c)) = K(dofs(r), dofs(c)) + k(r,c);
    end
end