# Load order
Load order in mods is a way of explicitly controlling when an action should take place.  By default, all actions have a load order of "0".  

## "What should I typically do?"
Unless actions specifically need to run BEFORE most content or AFTER most content, load order should remain the same.  Instead, as a general practice, make use of references and dependencies to ensure that most actions from the expansions typically occur before your own actions.

This will typically resolve inconsistencies regarding actions that 'override' things such as 'ImportFiles' or 'ReplaceUIScript'.

## Actions with equal load orders.
Actions with equal load orders are sorted by their dependencies and references to packages. Otherwise, the order is not strictly defined.

If Mod A depends on Mod B, actions in Mod A that have the same load order as actions in Mod B will always be applied AFTER actions in Mod B have been applied.  The same goes for if Mod A references Mod B.

## Reverse reference/dependency
If you need to ensure your actions occur before the actions of another mod, you can add that mod as a reverse reference.  This will tell the modding framework that the other mod now has a reference or dependency to your mod and cause your actions to be applied prior.


## Recommended Load Order Values

|Value|Description|
|---|---|
|-100|Schema changes<br/>Remove Data<br/>Populate core data|		
|-75|Unofficial Schema changes|	
|-50|Premature Updates<br/>Updates that need to be made before content is typically added.|
|-25|Unofficial changes to premature updates|
|0|Standard Content Updates<br/>Most actions applied during this phase.|
|25|Unofficial changes to standard updates|
|50|Post Updates<br/>Updates that require most content to be provided.|
|75|Unofficial changes to post-update content|
|100|Scenario Updates<br/>Often applied at the very end of everything else.  Called out as its own phase.|	
|125|Unofficial changes to Scenario updates.|