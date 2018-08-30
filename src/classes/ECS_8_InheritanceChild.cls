/* demo of Inheritance - Child class */

public with sharing class ECS_8_InheritanceChild extends ECS_8_InheritanceParent
{
    public override void print()
    {
        system.debug('Child method is executed');
    }
}