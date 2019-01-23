Avoiding common mistakes.md

Transaction-Ordering Dependence/FrontRunning:

•	Transaction Order Dependence is problem I could foresee in this simple contract and added adequate modifier to check the dependency condition is met before executing method.

Renentrancy

•	I do not see any possibility in this code for reentrancy.

Integer overflow/underflow:

•	There is no mathematical calculations involved in this contract. So no measures taken here.

DOS:
•	If the conditions laid out are properly met, we wont get any DOS error.
