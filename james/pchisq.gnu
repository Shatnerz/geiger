set xlabel '{/Symbol C^2/n}'
set ylabel 'P_{/Symbol C}({/Symbol C}^2,{/Symbol n})'
plot 'pchisq-1.data' w l title '{/Symbol n} = 1', 'pchisq-2.data' w l title '{/Symbol n} = 2', 'pchisq-3.data' w l title '{/Symbol n} = 3', 'pchisq-5.data' w l title '{/Symbol n} = 5', 'pchisq-10.data' w l title '{/Symbol n} = 10', 'pchisq-20.data' w l title '{/Symbol n} = 20', 'pchisq-30.data' w l title '{/Symbol n} = 30'