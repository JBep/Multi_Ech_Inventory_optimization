# Multi_Ech_Inventory_optimization

Check the report if you want the full picture, here's a short summary:

In this project the task was to optimize an inventory control system over two echelons. 

System setup:
The system consisted of a central warehouse delivering to multiple smaller stock-carrying retailers which in turn delivered to customers. All according to a make-to-stock system, thus, if a stock-out, orders were missed and not piling up. The goal was to reach given customer service levels for each retailer while minimizing costs. Furthermore, the nodes in the system is controlled using a (R,Q)-policy, and the Q-values (shipment size of an order) were set beforehand. Thus, we only needed to find the optimal re-order points R.

We were provided with a simulation model of the system which could be used in our solution, however, we wanted an analytical challenge and wanted to attempt to fully model the system using programming (matlab in this case) so we only used the simulation model to confirm that our model did produce accurate estimations of the service levels and costs.

The major challenge of the task is to properly model the dynamics between the warehouse and the retailer in order to capture the full system when optimizing the control parameters R. Theory and empirical research suggests that such an optimization can produce much lower costs in the system compared to modelling each node in isolation.

The solution can be categorized into two steps. 
The first was to use a metric approach to model the behaviour of the retailers, metric approach means that we model the stochastic lead time between central warehouse and retailer with a deterministic transportation time plus an estimation of the stochastic waiting time (the time that a delivery has to wait before sent if the central warehouse is out of stock). This way the service level could be calculated given a waiting time estimation W and a re-order point R.

The 2nd step was to find an estimation of W, the main idea here is to consolidate the stochastic demand from retailers and estimate it with a normal approximation.

For details about the soluation, please refer to the report published in the repo.

To further build upon this model the optimizaiton should be revisited, as time was of essence a brute-force approach was used. It was however theorized that the near-convexity of the problem could be used to find a more sophisticated approach which could be explored further. 

Major take-aways:
* Keeping more stock further downstream in the SC gives a higher service level for a lower amount of total stock.
* To scale up the model, more sophisticated optimization is required.

About the code: 
* I'm much better at handling a bunch of tables of data nowadays and don't resort to jamming things in text-files anymore. :)
