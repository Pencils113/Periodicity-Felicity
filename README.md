# Periodicity-Felicity

## About

This code in R takes in data from [Harvard DASCH: Digital Access to a Sky Century](http://dasch.rc.fas.harvard.edu/lightcurve.php) and outputs 
a [Lomb-Scargle Periodogram](https://cran.r-project.org/web/packages/lomb/lomb.pdf) along with regression coefficients and strength of a sinusoidal 
regression model of the form:

## Example Output for OJ287

    "Predicted Period" "48.9836740000001"
    "Significant Value Threshold" "12.1798306163538"           
    "Power of Predicted Period" "28.4041632977835"         
    "Probability max occurred by chance" "9.03735420607987e-10"              
    "Amplitude" "-0.625"   
    "Phase" "0.8"  
    "Offset" "-0.125"
    "Error"            "1.00205142163057"

    Formula: regressionY ~ (amplitude * sin((2 * pi * regressionX/predictedPeriod) + 
    phase) + offset)

    Parameters:
          Estimate Std. Error t value Pr(>|t|)    
    amplitude -0.64623    0.07632  -8.467 5.93e-16 ***
    phase      0.84261    0.11257   7.485 5.25e-13 ***
    offset    -0.10359    0.05343  -1.939   0.0533 .  
    ---
    Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

    Residual standard error: 1.004 on 371 degrees of freedom

    Number of iterations to convergence: 2 
    Achieved convergence tolerance: 7.628e-07

## ![Lomb-Scargle Periodogram](https://github.com/Pencils113/Periodicity-Felicity/tree/main/Images/OJ287.png)

## Project Abstract

Binary supermassive black holes are expected to be common at the centers of galaxies. No observational technique has the resolution to directly image them. One indirect way to confirm their presence is to look for periodic variations in their light curves. However, most AGN light curves only go back a few decades since AGN were discovered about 1963. This is a severe problem since the timescale of variations are expected to be of the order of a decade.  Fortunately, the Harvard College Observatory has been monitoring some AGN (mistaken to be stars) since the mid-nineteenth century. These observations have recently been digitized. I obtained this publicly available data and looked for periodicity in the optical light curves of 13 of the brightest quasars using Spectral Analysis in R. I then used least-square regression to find the best fitting model of the lightcurve data. Finally, multiple complementary methods were used to determine whether each lightcurve has a periodic component.

