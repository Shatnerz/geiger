% HISTOGRAM_ANALYSE - just a stub
function [row_mean,row_var,col_mean,col_var] = histogram_analyse (data)
    rows = size(data,1);
    cols=size(data,2);
    intervals=sum(data(1,:));    %total number of data points per day
    for row = 1:rows
        this_row = data(row,:);	% extracts single row vector from matrix 
        for i=1:cols
            this_row(i)=this_row(i)*(i-1); %makes elements into number of jaywalkers seen
        end
        row_mean(row)=sum(this_row)/intervals; %calculating row mean
        for j=1:cols %calculating row variance
            this_row(j)=this_row(j)-row_mean(row);
        end
        row_var(row)=sum(this_row.^2)/intervals^2;
    
    end
  
      for col = 1:cols
        this_col = data(:,col);	% extracts single column vector from matrix
                                
     
        col_mean(col)=sum(this_col)/rows; %calculating column mean
        for l=1:rows  %calculating col variance
            this_col(l)=this_col(l)-col_mean(col);
        end
        col_var(col)=sum(this_col.^2)/rows;
    
    end
   