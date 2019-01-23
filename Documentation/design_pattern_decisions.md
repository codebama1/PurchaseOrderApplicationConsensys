DesignPatterns.md

Fail Early/Fail Loud
•	Conditions are checked with require statements in every  method.

Restricting Access
•	Every method can be executed by buyer or seller or buyer and seller only depending upon set modifiers.

Auto Deprecation
•	Smart contract is designed as mortal. So it can be closed when in emergency.

State Machine
•	I think this is prefect example of state machine, where contract member variable Order behaves differently based on current state it is in.
•	Only certain function can be called on member variable based on the state it is in at the moment.

Circuit Breaker:
•	Circuit Breaker may /may not be implemented. I choose to implement circuit breaker here for the methods that create, approve, confirm, decline PO, that tend to change the state of the contract.

