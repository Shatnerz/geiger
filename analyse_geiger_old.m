function[chi_square_gaussian,chi_square_poisson] = analyse_geiger (data_in,m)

   [data,intervals,period]= read_geiger(data_in);
   
   if m==1
      data = modify(data); 
      intervals=intervals*5;
   end    

   [rows,columns] = size(data);
    
   [row_mean,row_var,col_mean,col_var] = histogram_analyse(data);
   
   [mean_geiger,var_geiger] = histogram_analyse(col_mean);
     
     
     x = [0:0.1:columns];
      figure
      
 
    
    x2 = [0:1:columns-1];
    
 errorbar(x2,col_mean,col_var.^0.5,'ro');
   
  hold on
    number_of_points = sum(data(1,:));
  
    gaussian = number_of_points*(1/(sqrt(2*pi*var_geiger)))*(exp(-(x-mean_geiger).^2/(2*var_geiger)));
    plot(x,gaussian,'b');
    xlabel('Number of Events','fontsize',14);
    ylabel('Frequency','fontsize',14);
    str = ['Frequency of Events for ',num2str(rows),' repilcas, of ',num2str(intervals),' interval samples with period of ',num2str(period),'s'];
    title(str,'fontsize',14);
  

for counter3 = 1:columns
        data_new(:,counter3) = data(:,counter3).*(counter3-1);
end
    
 for counter2 = 1:rows
     
    lambda(counter2,:) = (sum(data_new(counter2,:))./number_of_points);
    
 end
 
lambda = mean(lambda);
x=[0:1:columns];
poisson = number_of_points*poisspdf(x.',lambda).';

plot(x,poisson,'--k');
xlabel('Number of Events','fontsize',14);
ylabel('Frequency','fontsize',14);
legend('Data Points','Gaussian Fit','Poisson Fit','location','best');


gaussian = number_of_points*(1/(sqrt(2*pi*var_geiger)))*(exp(-(x2-mean_geiger).^2/(2*var_geiger)));
poisson = number_of_points*poisspdf(x2.',lambda).';

chi_square_gaussian = (1/columns)*sum((col_mean-gaussian).^2/var_geiger);


chi_square_poisson = (1/columns)*sum((-(poisson-col_mean)).^2/var_geiger);

