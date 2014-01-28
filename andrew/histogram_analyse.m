% HISTOGRAM_ANALYSE(data) - returns [row_mean, row_var, col_mean, col_var]

function [row_mean,row_var,col_mean,col_var] = histogram_analyse (data)

    rows = size(data,1);
    cols=size(data,2);
    
    intervals=sum(data(1,:));    %total number of data points per day
    
    %Calculate row_mean and variance
    %Takes into account the value each column represents
    for row = 1:rows
        row_mean(row) = sum(data(row,:).*(0:(cols-1)))/intervals;
        row_var(row) = sum(data(row,:) .* ((0:(cols-1))-row_mean(row)).^2)/intervals;  
    end
    
    %Calculate column_mean and variance
    for col = 1:cols
      this_col = data(:,col);	% extracts single column vector from matrix
 
      col_mean(col) = mean(data(:,col));
      col_var(col) = mean((data(:,col)-col_mean(col)).^2); 
    end
