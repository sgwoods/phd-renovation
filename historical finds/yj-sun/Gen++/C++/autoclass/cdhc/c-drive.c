#include<stdio.h>

main()
{
	double *omnibus_moments (double* x, int n); 
	double *geary_test (double* x, int n); 
	double *student_range (double* x, int n); 
	double *dagostino_d (double* x, int n); 
	double *kuipers_v (double* x, int n); 
	double *watson_u2 (double* x, int n); 
	double *durbins_exact (double* x, int n); 
	double *anderson_darling (double* x, int n); 
	double *cramer_von_mises (double* x, int n); 
	double *kolmogorov_smirnov (double* x, int n); 
	double *chi_square (double* x, int n); 
	double *shapiro_wilk (double* x, int n); 
	double *shapiro_francia (double* x, int n); 
	double *shapiro_wilk_exp (double* x, int n); 
	double *cramer_von_mises_exp (double* x, int n); 
	double *kolmogorov_smirnov_exp (double* x, int n); 
	double *kuipers_v_exp (double* x, int n); 
	double *watson_u2_exp (double* x, int n); 
	double *anderson_darling_exp (double* x, int n); 
	double *chi_square_exp (double* x, int n); 
	double *mod_maxlik_ratio (double* x, int n); 
	double *coeff_variation (double* x, int n); 
	double *kotz_families (double* x, int n); 


   double x[1000],*y;
   int n=0;
   n = 0; 
   while(scanf("%lf",&x[n++]) != EOF);
   n--;  
   printf("N=%d\n",n);
printf("*y=%ld\n", y);
   y=omnibus_moments (x, n); 
printf("*y=%ld\n", y);
   y=geary_test (x, n); 
printf("*y=%ld\n", y);
   y=student_range(x, n);  
   y=dagostino_d(x, n);  
printf("y=%g\n", y[1]);
   y=kuipers_v (x, n);   
   y=watson_u2 (x, n);  
   y=durbins_exact (x, n);  
   y=anderson_darling (x, n);  
   y=cramer_von_mises (x, n);  
   /* for ks and lillefors, the discrepancy seems to come
      in in computing the sum of x*x */

   y =kolmogorov_smirnov (x, n);  
   y=chi_square(x, n);  
   y=shapiro_wilk(x, n);   
   y=shapiro_francia(x, n);   
   y=shapiro_wilk_exp(x, n);    
   y=cramer_von_mises_exp (x, n);  
   y=kolmogorov_smirnov_exp (x, n);    
   y=kuipers_v_exp (x, n);  
   y=watson_u2_exp (x, n);  
   y=anderson_darling_exp (x, n);  
   y=chi_square_exp(x, n);   
   y=mod_maxlik_ratio (x, n);  
   y=coeff_variation(x, n); 
   y=kotz_families(x,n);  
}
