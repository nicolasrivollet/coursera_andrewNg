function [C, sigma] = dataset3Params(X, y, Xval, yval)
%EX6PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = EX6PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C     = 1   ;
sigma = 0.3 ;


model= svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma));
predictions = svmPredict(model, Xval);
err = mean(double(predictions ~= yval));

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

% initialisation
C     = 1   ;
sigma = 0.3 ;


model= svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma));
predictions = svmPredict(model, Xval);
err = mean(double(predictions ~= yval));

% loop
C_tab     = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30] ;
sigma_tab = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30] ;

for i=1:length(C_tab),
    for j=1:length(sigma_tab),
        model= svmTrain(X, y, C_tab(i), @(x1, x2) gaussianKernel(x1, x2, sigma_tab(j)));
        predictions = svmPredict(model, Xval);
        err_temp = mean(double(predictions ~= yval));
        if err_temp < err,
            err   = err_temp     ;
            C     = C_tab(i)     ;
            sigma = sigma_tab(j) ;
        end;
    end;
end;


% =========================================================================

end
