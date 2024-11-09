syms lambda m M k;  

A = [k/M, -k/M, 0; 
    -k/m, (k+k)/m, -k/m; 
     0, -k/M, k/M];
I = eye(3);  
A_lambda = A - lambda * I; 
determinant = det(A_lambda);  
eigenvalues = solve(determinant == 0, lambda);  

disp('Eigenvalues:');
disp(eigenvalues);


eigenvectors = cell(length(eigenvalues), 1);  
for i = 1:length(eigenvalues)
    eigenvector_matrix = A - eigenvalues(i) * I; 
    V = null(eigenvector_matrix); 
    eigenvectors{i} = V;  
end

disp('Eigenvectors:');
for i = 1:length(eigenvectors)
    disp(eigenvectors{i});  
end
