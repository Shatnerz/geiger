function[chi_square_gaussian,chi_square_poisson] = analyse_geiger_test (data_in,m)

	[data,intervals,period]= read_geiger(data_in);
   %Modifier
   %If m is set to 1, replicas are group in 5's. i.e 1-5, 6-10,11-15,...
	if m==1
        data = modify(data); 
        intervals=intervals*5;
	end    

    [rows,columns] = size(data);
    % Uses histogram_analyse to find the column statistics for the geiger
    % data% Uses histogram_analyse to calculate the the
	[~,~,col_mean,col_var] = histogram_analyse(data);
   blaaaaaaaaaaahhhhhhh=7895478897978978978897978
    % Column mean is the mean for each frequency (mean of all the replicas)
    % Mean geiger is the average frequency. Its calculated using
    % histogram_analyse
    [mean_geiger,var_geiger,~,~] = histogram_analyse(col_mean);
    
    %The variance on all the points cannot be calculated using
    %histogram_analyse since there is a variance on each point that must be
    %taken into account
    
    %var_geiger = var(col_mean);             %<<<<<<<<<<<CHANGE THIS<<<<<<<<<<<<!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
     
     % Uses histogram_analyse to calculate the the
    x = [0:0.1:columns];
    figure
    %calculate variance on data points
    
	x2 = [0:1:columns-1];
    %Plots the average number of geiger ticks for each frequency
    %(Average is taken over all replicas)
	errorbar(x2,col_mean,col_var.^0.5,'ro');
   
    hold on
    
    %Find the number of points. This is used to normalize the gaussian and
    %possion functions
    number_of_points = sum(data(1,:));
    %Calculate and plot gaussian fuction
    
    gaussian = number_of_points*(1/(sqrt(2*pi*var_geiger)))*(exp(-(x-mean_geiger).^2/(2*var_geiger)));
    plot(x,gaussian,'b');
    
    lambda = mean_geiger;
    x= [0:1:columns];
    %Plot poisson
    poisson = number_of_points*poisspdf(x,lambda);

    plot(x,poisson,'--k');

    % Add labels and legends to the plot and make it pretty.
    legend('Data Points','Gaussian Fit','Poisson Fit','location','best');
    xlabel('Number of Events','fontsize',14);
    ylabel('Frequency','fontsize',14);
    str = ['Frequency of Evcalculate variance on data pointsents for ',num2str(rows),' repilcas, of ',num2str(intervals),' interval samples with period of ',num2str(period),'s'];
    title(str,'fontsize',14);


    hold off
    % Calculate the chi of gaussian and poisson
    gaussian = number_of_points*(1/(sqrt(2*pi*var_geiger)))*(exp(-(x2-mean_geiger).^2/(2*var_geiger)));
    poisson = number_of_points*poisspdf(x2,lambda);

    chi_square_gaussian = (1/columns)*sum((col_mean-gaussian).^2/var_geiger);


    chi_square_poisson = (1/columns)*sum((col_mean-poisson).^2/var_geiger);
    
    
end