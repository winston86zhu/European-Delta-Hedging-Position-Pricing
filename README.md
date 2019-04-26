# European-Delta-Hedging-Position-Pricing
Typical European Hedging Scenario including [Straddle, Stop-Loss, Jump Model] 

WorkFlow for Delta Calculation: Step 1: Simple Binomial Lattice ==> \
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
                                
                                
