% geiger_analyse(file_name, group_size) - returns chi_squared for both gauss and poiss for each group
% Loads geiger file and breaks it down into groups and analyses
% filename assumes .data extension
% cuts off bottom rows if number of rows is not divisible by 5

%Currently not working for low periods (<100)

% needs		read_geiger.m
% 				data_analyse.m

function [chi2] = geiger_analyse (file_name, group_size)

	[data, intervals, period] = read_geiger(strcat('data/',strcat(file_name,'.data'))); %load data
	[rows, cols] = size(data);
	
	if nargin < 2
		group_size = 5;
	end

	if mod(rows,group_size) %make sure divisible by group_size
		fprintf('Not divisible by %d removing bottom %d rows\n',group_size, mod(rows,5))
		data = data((1:(rows-mod(rows,5))),:);
		[rows, cols] = size(data);
	end
	 
	chi2 = [];
	%breaker geiger data into groups
	for i = 1:group_size:rows
		data_group = data( i:(i+group_size-1),: );
		chi2 = [chi2; data_analyse(data_group,'b',1)'];
	end
	
	%data_group = data(6:10,:);
	%a = data_analyse(data_group,'b',1)
	
	%disp(chi2)
	
	
