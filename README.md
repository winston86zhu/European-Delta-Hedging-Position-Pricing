# European-Delta-Hedging-Position-Pricing
Typical European Hedging Scenario including [Straddle, Stop-Loss, Jump Model] 

## **WorkFlow for Delta Calculation**
          : Step 1: Simple Binomial Lattice ==> 
          .
          . (Using Binomial Lattice as a grid) 
          . 
          Step 2: Monte Carlo Simulation ==> 
          . 
          . (Pertube the Price and calculate dVdS
          . 
          Step 3: Hedging at different time steps(frequencies) ==> 
          . 
          . (No hedging, Hedging at begining, hedging weekly, hedging monthly) 
          . 
          Step 4: Adding futures such as: 
            * Stop-Loss 
            * Melton's Jump Model 
            * This model connects to my another repo regarding hedging analysis with PDE
                                
                                
### **Step 1: Binomial Lattice: Return 3 matrices and 1 value}: Refer to binomialDeltaStraddle.m**
  - The value of the oprion price 
  - The matrix for Stock price S at different time step(\tau)
  - The matrix for option value V at different time step(\tau)
  - The matrix for dummy delta position computed from binomial delta hedging 

### **Step 2: Interpolation using above binomial grid for passed in stock price**
  - This gives us our first attempt result
  ![alt text](https://github.com/nacked-riveroverflow/European-Delta-Hedging-Position-Pricing/blob/master/result/Binomialplot.JPG) 
  
### **Step 3: When we hedge at different frequencies**
  - Code only includes hedging weekly as an example
  ![alt text](https://github.com/nacked-riveroverflow/European-Delta-Hedging-Position-Pricing/blob/master/result/hedgingdaily.JPG) 


  
