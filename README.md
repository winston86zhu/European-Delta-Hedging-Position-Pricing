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
  ![alt text](https://github.com/nacked-riveroverflow/European-Delta-Hedging-Position-Pricing/blob/master/result/hedgingweekly.JPG) 
  
  - When we quantify the result, we obtained
  ![alt text](https://github.com/nacked-riveroverflow/European-Delta-Hedging-Position-Pricing/blob/master/result/q4-table.PNG) 
  
  - Analysis: 
      
      ```
      1 Hedging performance gets better as we hedge more frequently. <- The mean gets closer to 0 
      2. Less volatile as we hedge more frequently <- std gets smaller
      3. We significantly reduces our risk exposure. <- VaR and CvaR are smalled
      ```
      
### **Foodies: Melton's Jump Model**


We want to make the process path dependent, meaning we set vault to the price pass and once it breaches/drops/..., we make action In this case, we want to set a floor to the stock price, and we buy if it drops below and sell when it goes above. 
We considered this a classic example of buy low sell high!
      
In details: 
      - Assume that S0 < K, i.e. the initial asset price is less than K. As soon as S = K+ep, ep << 1, the writer borrows K+ep and buys the stock. As soon as S = K − ep, the writer sells the stock. 
      - In Execution,  If S < K at expiry, the writer holds no stock, and does not owe the holder of the option anything. If S > K at expiry, the writer sells the stock at price S, gives the holder S −K, and pays back the loan of K used to buy the stock. If we monitor the strategy closely, we can make ep as small as we like. Consequently, this strategy should cost less than the Black-Scholes price.
      
  
