% data_analyse(data, pdf_type, draw, name, foo)
% returns chi_squared values and saves figure
% pdf_type - probability density function - default: gaussian
% pdf_types: gauss, poiss, both
% if both gauss is always the first data listed
% draw - boolean to draw results or not
% foo - boolean - quick hack so graphs dont draw over each other
% when foo = 1, draws histogram and averages

%needs	histogram_analyse.m
%				chi_squared.m

function [chi2, fig] = data_analyse (data, pdf_type, draw, name, foo)
	
	if nargin < 2;
		pdf_type = 'gauss'; %Set gaussian as default pdf_type
	end
	if nargin < 3;
		draw = 0; %Set draw off by default
	end
	if nargin < 4;
		name = 'default';
	end
	if nargin < 5;
		foo = 1;
	end
	
	%Check if given pdf_type is supported
	if ~(strcmpi(pdf_type,'gauss') | strcmpi(pdf_type,'poiss') | strcmpi(pdf_type, 'both') | strcmpi(pdf_type, 'b')) %not the best method, but there's only 2 pdf's
		error('pdf %s not supported', pdf_type)
	end

	%Load data
	[row_mean, row_var, col_mean, col_var] = histogram_analyse(data);
	[rows, cols] = size(data);
	num_points = sum(data(1,:)); %ASSUME number of points is the same in each row
	
	%Plot data if needed	
	if draw & foo
		fig = figure('visible','on'); %switch vis to off if it becomes a hassle
		histogram = bar(0:(cols-1), data(1,:), 'FaceColor',[0.8 0.8 0.8]); %plot histogram of first replica - make grey for aesthetics
		hold on;
		errorbar(0:(cols-1), col_mean, sqrt(col_var)/2,'.k'); %plot the mean points with error
		xlabel('Number of Events','fontsize',15); %i may not have all the required fonts installed - may lead to discrepancies
   	ylabel('Frequency','fontsize',15);
	end
	
	if strcmpi(pdf_type, 'both') | strcmpi(pdf_type, 'b')
		%This was added after the the function was finished
		%Now we can compare and graph both simultaneously
		
		gauss_chi2 = data_analyse(data,'gauss', draw, name, 0);
		poiss_chi2 = data_analyse(data,'poiss', draw, name, 0);
		
		chi2 = [gauss_chi2; poiss_chi2];
		
		if draw
			%Add blank scatter plots so I can add the chi squared values to the legend
			sig_fig = 3; %sig figs to show
			scatter(0,0,'marker','none'); gauss_string = sprintf('\\chi^2_{Gauss} = %.*f',  (sig_fig-1)-floor(log10(abs(chi2(1)))), chi2(1)); %formats to sig figs
			scatter(0,0,'marker','none'); poiss_string = sprintf('\\chi^2_{Poiss} = %.*f', (sig_fig-1)-floor(log10(abs(chi2(2)))), chi2(2)); %format wont work if > 1000
			%add a legend to the plot
			legend('Sample trial', 'Average values', 'Ideal Gaussian', 'Ideal Poisson',gauss_string,poiss_string)
			%save figure
			saveas(fig, strcat('figures/',name), 'fig');
			saveas(fig, strcat('figures/eps/',name), 'epsc');
		end
		
	else	
		%%%%%%%%%%%%%%%%%%%%% Generate pdf data %%%%%%%%%%%%%%%%%%%%%
		
		%[average, variance] = histogram_analyse(col_mean); %Doesn't take into account variance we already have
		average = sum( col_mean .* (0:(cols-1)) )/num_points; %same as histogram_analyse
		variance = sum( col_var .* (0:(cols-1)) )/num_points
		%sum( col_var .* (0:(cols-1)) )/(num_points^2)
		%[avg, var] =histogram_analyse(col_mean)
		%variance = 5;
		
		%Handle Gaussian
		if strcmpi(pdf_type, 'gauss')
			fprintf('Using Gaussian\n');
			%gaussian = @(x) 1/sqrt(3*pi*variance)*exp(-power((x-average),2) /(2*variance)); %same method doesnt work for poiss
			%normalization = integral(gaussian, 0, Inf)*num_points;
			pdf = normpdf((0:(cols-1)), average, variance);
			normalization = trapz(pdf)*num_points;
			fprintf('Normalization: %d\n', normalization/num_points);
 			pdf = pdf*normalization;
 		%Handle Poisson
		elseif strcmpi(pdf_type, 'poiss')
			fprintf('Using Poisson\n');
			pdf = poisspdf((0:(cols-1)), average);
			normalization = trapz(pdf)*num_points;
			fprintf('Normalization: %d\n', normalization/num_points);
			pdf = pdf*normalization;
		end
		
		chi2 = chi_squared(col_mean,col_var,pdf);
		
		if draw %Draw the fitted pdf's
			if strcmpi(pdf_type, 'gauss')
				step = 0.1; %used to smooth gaussian
				pdf = normpdf((0:step:cols), average, variance)*normalization; %smooth the gaussian
				color = 'red';
				name = 'Ideal Gaussian';
				plot(0:step:cols, pdf, color,'LineWidth',2);
			elseif strcmpi(pdf_type, 'poiss')
				pdf = poisspdf((0:cols), average)*normalization;
				color = 'blue';
				name = 'Ideal Poisson';
				plot(0:cols, pdf, color,'LineWidth',2);
			end
			legend('Sample trial', 'Average values', name);
    end
	end

	
	
	
	
	
	
	
	
