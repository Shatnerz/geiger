function [chi_2_gauss,chi_2_poiss]=geiger_analyse(data_in,m)

%geiger_analyse takes in a set of data and returns the chi-squared value
%for a gaussian and poisson fit
%Also returns figure showing data points with proposed gaussian and poisson
%distribution

%set m=0 to analyse one set of data
%set m=1 to analyse replica data

[data,intervals,period]=read_geiger(data_in);

%extracts data matrix, number of intervals and period of intervals of the
%given data

if m==1
    data=modify(data);
    intervals=intervals*5;
end

%if m==1, analyse sets of replicas instead of just one set of data

[rows,cols]=size(data);

[~,~,col_mean,col_var] = histogram_analyse(data);
%row_mean, mean count number per interval with variance row_var, both
%unused
%col_mean is array of the mean number of counts in a given bin, with
%variance col_var
   
[geig_mean,geig_var,~,~] = histogram_analyse(col_mean)

geig_var=sum(col_var)/rows
%gives mean and variance of col_mean array

x=0:(cols-1);

errorbar(x,col_mean,col_var.^0.5,'ro');

%plots errorbar for bin count data

hold on

gauss_dist = @(n) intervals/sqrt(2*pi*geig_var)*exp(-(n-geig_mean).^2/(2*geig_var));
fplot(gauss_dist,[0 cols],'b');
xlabel('Number of Events','fontsize',14);
ylabel('Frequency','fontsize',14);

poiss_dist = intervals*poisspdf(x,geig_mean);
plot(x,poiss_dist,'--k');
legend('Data Points','Gaussian Fit', 'Poisson Fit');

hold off

%plots Gaussian and Poisson fits

gauss_chi=gauss_dist(x);
poiss_chi=poiss_dist;

%calculate reduced chi-squared value for both fits

chi_2_gauss=(1/cols)*sum((col_mean-gauss_chi).^2/geig_var);
chi_2_poiss=(1/cols)*sum((col_mean-poiss_chi).^2/geig_var);